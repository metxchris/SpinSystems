#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <cstdlib>
#include <ctime>
#include <math.h>
#include <windows.h>
#include <time.h>
#include <iomanip>
#include <string>

using namespace std;
//Display Options:
//verbose = 0, prints parameter values
//verbose = 1, also prints initial and final site matrix
//verbose = 2, also prints site matrix for each individual T

//Global Constants
int		L 		= 32;		 //Length of Grid 
int		MCSteps = pow(10,4); //number of MCSteps
double	Tstart	= 2.00;		 //Start Temperature
double	Tend	= 2.3;		 //End Temperature
double	Tstep	= 0.001;	 //Temperature Step-Size
double  outPrec = 6;		 //Output Precision (decimal places)
int		verbose = 1;		 //Verbose Option
double 	J = 1; 				 //interaction energy
int 	k = 1; 				 //Boltzman's constant

//Global Variables
int **spin;	 				 //spin array
double sumE, sumE2; 		 //Energy Sums	
double sumM, sumM2;	 		 //Magnetization Sums
double sumMabs, sumM2abs;	 //Absolute Magnetization Sums
double T;					 //Temperature

//timer variables
clock_t t1,t2; 

double drand ( ) { 
	//random decimal from [0,1)
	return (double)rand() / ((double)RAND_MAX + 1);
}

int randint (int min, int max) {
	//random integer from [min, max]
	return floor((max - min + 1)*drand()) + min;
}

void initialization ( ) { 
	srand(time(NULL));//seed random number generator	
	//create spin array and assign spin values
	spin = new int* [L]; 
	for (int i = 0; i < L; i++) 
		spin[i] = new int [L];
	for (int i=0; i<L; i++)
		for (int j=0; j<L; j++)	
			spin[i][j] = drand()<0.5 ? -1 : 1;
}

void resetConfig ( ) {
	sumE=sumE2=sumM=sumM2=sumMabs=0;
}

void displaySpins (int verboseLevel) {
	if (verbose>verboseLevel) {
		cout<<endl<<"Site Matrix:"<<endl;
		for (int i=0; i<L; i++)
			for (int j=0; j<L; j++){	
				cout<<(spin[i][j]>0 ? " x" : " o");
				if (j==L-1) cout<<endl;
			}
		cout<<endl;
	}
}

void displayParameters ( ) {
	//Display Initial Parameters
	cout<<"Parameters:"<<endl;
	cout<<" L       = "<<L<<endl;
	cout<<" MCSteps = "<<MCSteps<<endl;
	cout<<" Tstart  = "<<Tstart<<endl;
	cout<<" Tend    = "<<Tend<<endl;
	cout<<" Tstep   = "<<Tstep<<endl;
	cout<<" J       = "<<J<<endl;
	cout<<endl;
	//Set output precision to outPrec decimal places
	std::cout << std::setprecision(outPrec) << std::fixed;
	//Display Output Headers
	cout<<"Output Data:"<<endl;
	cout<<right<<setw(12)<<"T"		  <<", ";
	cout<<right<<setw(12)<<"meanM"	  <<", ";
	cout<<right<<setw(12)<<"meanMabs" <<", ";
	cout<<right<<setw(12)<<"meanM2"   <<", ";
	cout<<right<<setw(12)<<"meanE"    <<", ";
	cout<<right<<setw(12)<<"meanE2"   <<", ";
	cout<<right<<setw(12)<<"chi"      <<", ";
	cout<<right<<setw(12)<<"chiabs"   <<", ";
	cout<<right<<setw(12)<<"c"        <<";";
	cout<<endl;
}

void computeMCStep ( ) {
	//One MCStep
	for (int n=0; n<L; n++) { 
		//Choose Random Site
		int i=randint(0,L-1); 
		int j=randint(0,L-1); 
		//find the indices of the 4 neighbors
		int iPrev = i == 0 	 ? L-1  : i-1; 
		int iNext = i == L-1 ? 0 	: i+1; 
		int jPrev = j == 0 	 ? L-1  : j-1; 
		int jNext = j == L-1 ? 0 	: j+1; 
		//calculate energies and transition probability
		double deltaE = 2*J*spin[i][j]*(spin[iPrev][j]+spin[iNext][j]+spin[i][jPrev]+spin[i][jNext]);
		double p_trans = exp(-deltaE/(k * T));
		//spin transition condition
		if (p_trans > drand()) spin[i][j] = -spin[i][j];
	}
}

void measureObservables ( ) {
	int M = 0; //magnetization
	int E = 0; //energy
	
	for (int i = 0; i < L; i++) 
		for (int j = 0; j < L; j++) {
			int iNext = i == L-1 ? 0 : i+1; 
			int jNext = j == L-1 ? 0 : j+1; 
			M += spin[i][j];
			E -= J*spin[i][j]*(spin[iNext][j]+spin[i][jNext]);
		}
	sumE    += E;
	sumE2   += E*E;
	sumM    += M;
	sumM2   += M*M;
	sumMabs += M>0 ? M : -M;
}

void displayAverages ( ) {
	if (sumM < 0) sumM = -sumM;
			
	double Z = MCSteps;	//partition function
	double N = L*L; 	//Number of sites
	//Averaged observables per site
	double meanE     = sumE/(N*Z);
	double meanE2    = sumE2/(N*N*Z);
	double meanM     = sumM/(N*Z);
	double meanM2    = sumM2/(N*N*Z);
	double meanMabs  = sumMabs/(N*Z);
	//magnetic susceptibility per site
	double chi    = N*(meanM2-pow(meanM,2))/(k*T);
	double chiabs = N*(meanM2-pow(meanMabs,2))/(k*T);
	//heat capacity per site
	double c = N*(meanE2-pow(meanE,2))/(k*T*T);
	//display output parameters
	cout<<setw(12)<<T		 <<", ";
	cout<<setw(12)<<meanM	 <<", ";
	cout<<setw(12)<<meanMabs <<", ";	
	cout<<setw(12)<<meanM2	 <<", ";
	cout<<setw(12)<<meanE	 <<", ";
	cout<<setw(12)<<meanE2	 <<", ";
	cout<<setw(12)<<chi  	 <<", ";
	cout<<setw(12)<<chiabs 	 <<", ";
	cout<<setw(12)<<c 		 <<";";
	cout<<endl;
}

void timer (int startClock) {
	if (startClock == 1) {
		t1=clock();//start time 
	} else {
		t2=clock();//end time
		float diff ((float)t2-(float)t1);//elapsed time
		cout<<endl<<"Run Time: "<<diff / CLOCKS_PER_SEC<<" seconds";
	}
}

int main() { 
	timer(1);
	initialization();
	for (T=Tstart; T<=Tend; T+=Tstep){
		resetConfig();
		if (T==Tstart) {
			displaySpins(0);
			displayParameters();
			}
		//Thermalization Loop
		for (int i = 0; i < MCSteps/5; i++)
			computeMCStep();
		//Measurement Loop
		for (int i = 0; i < MCSteps; i++) {
			computeMCStep();
			measureObservables();
		}
		displayAverages();
		displaySpins(1);
	}
	displaySpins(0);
	timer(0);
	cin.get();
}