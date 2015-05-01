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

//Declared Functions
void GrowCluster(int i, int j, int cSpin);
void TryAddNeighbor(int i, int j, int cSpin);

//Display Options:
//verbose = 0, prints parameter values
//verbose = 1, also prints initial and final spin matrix
//verbose = 2, also prints spin matrix for each individual T

//Global Constants
int		L 		= 32;		 //Length of Grid 
int		MCSteps = pow(10,4); //number of MCSteps
double	Tstart	= 2;		 //Start Temperature
double	Tend	= 4;		 //End Temperature
double	Tstep	= 0.25;	 //Temperature Step-Size
double  outPrec = 6;		 //Output Precision (decimal places)
int		verbose = 1;		 //Verbose Option
double 	J = 1; 				 //interaction energy
int 	k = 1; 				 //Boltzman's constant

//Global Variables
int **spin;	 				//spin array
bool **cluster;				//cluster array
double sumE, sumE2; 		//Energy Sums
double sumM, sumM2;	 		//Magnetization Sums
double sumMabs, sumM2abs;	//Absolute Magnetization Sums
double p_add; 				//transition probability
double T;					//Temperature

//timer variables
clock_t t1, t2; 

double drand ( ) { 
	//random decimal from [0,1)
	return (double)rand() / ((double)RAND_MAX + 1);
}

int irand (int min, int max) {
	//random integer from [min, max]
	return floor((max - min + 1)*drand()) + min;
}

void initialization ( ) { 
	//create spin array and assign spin values
	spin = new int* [L]; 
	for (int i = 0; i < L; i++) 
		spin[i] = new int [L];
	cluster = new bool* [L];
	for (int i = 0; i < L; i++) 
		cluster[i] = new bool [L];
}

void resetConfig ( ) {
	for (int i=0; i<L; i++)
		for (int j=0; j<L; j++)	
			spin[i][j] = drand()<0.5 ? -1 : 1;
	//cluster addition probability
	p_add =  1 - exp(-2*J/(k*T));
	//reset sums;
	sumM = sumM2 = sumE = sumE2 = sumMabs = 0;
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
	cout<<right<<setw(12)<<"c"        <<", ";
	cout<<right<<setw(12)<<"p_add"    <<";";
	cout<<endl;
}

void ComputeMCStep ( ) {
	//reset the cluster array
	for (int i = 0; i < L; i++) 
		for (int j = 0; j < L; j++) 
			cluster[i][j] = false;
	//choose random spin
	int i = irand(0,L-1);
	int j = irand(0,L-1);
	//grow the cluster
	GrowCluster(i, j, spin[i][j]);
	//flip the cluster
	for (int i=0; i<L; i++)
		for (int j=0; j<L; j++)
			if (cluster[i][j])
				spin[i][j] = -spin[i][j];
}

void GrowCluster(int i, int j, int cSpin) {
	//add spin to cluster
	cluster[i][j] = true;
	//find the indices of the 4 neighbors
	int iPrev = i == 0 	 ? L-1  : i-1; 
	int iNext = i == L-1 ? 0 	: i+1; 
	int jPrev = j == 0 	 ? L-1  : j-1; 
	int jNext = j == L-1 ? 0 	: j+1; 
	//Attempt to add neighbors to cluster
	if (!cluster[iPrev][j]) 
		TryAddNeighbor(iPrev, j, cSpin); 
	if (!cluster[iNext][j]) 
		TryAddNeighbor(iNext, j, cSpin); 
	if (!cluster[i][jPrev]) 
		TryAddNeighbor(i, jPrev, cSpin); 
	if (!cluster[i][jNext]) 
		TryAddNeighbor(i, jNext, cSpin); 
}

void TryAddNeighbor(int i, int j, int cSpin) {
	if (spin[i][j] == cSpin && drand()<p_add)
			GrowCluster(i, j, cSpin);
}

void MeasureObservables ( ) {
	int M = 0; //magnetization
	int E = 0; //energy
	for (int i = 0; i < L; i++) 
		for (int j = 0; j < L; j++) {
			int iNext = i == L-1 ? 0 : i+1; 
			int jNext = j == L-1 ? 0 : j+1; 
			M += spin[i][j];
			E -= J*spin[i][j]*(spin[iNext][j]+spin[i][jNext]);
		}	
	sumM  += M;
	sumM2 += M*M;
	sumE  += E;
	sumE2 += E*E;
	sumMabs += M>0 ? M : -M;
}

void displayAverages ( ) {
	if (sumM < 0) sumM = -sumM;
	double Z = MCSteps; //partition function 
	double N = L*L;	//Number of sites
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
	cout<<setw(12)<<c 		 <<", ";
	cout<<setw(12)<<p_add	 <<"; ";
	cout<<endl;
}
		
void timer (int startClock) {
	if (startClock == 1) {
		srand(time(NULL));//seed random number generator	
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
	for (T=Tstart; T<=Tend; T+=Tstep) {
		resetConfig();
		if (T==Tstart){
			displaySpins(0);
			displayParameters();
		}
		//Thermalization Loop
		for (int i = 0; i < MCSteps/5; i++)
			ComputeMCStep();
		//Measurement Loop
		for (int i = 0; i < MCSteps; i++) {
			ComputeMCStep();
			MeasureObservables();
		}
		displayAverages();
		displaySpins(1);
	}
	displaySpins(0);
	timer(0);
	cin.get();
}
