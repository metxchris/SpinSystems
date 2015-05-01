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
#define PI 3.14159265
using namespace std;

//Declared Functions
void GrowCluster(int i, int j, int cSpin);
void TryAddNeighbor(int i, int j, int cSpin);

//Display Options:
//verbose = 0, prints parameter values
//verbose = 1, also prints initial and final spin matrix
//verbose = 2, also prints spin matrix for each individual T

//Global Constants
int		q		= 2;		 //Number of Spins	
int		L 		= 32;		 //Length of Grid 
int		MCSteps = pow(10,5); //number of MCSteps
double	Tstart	= 0.5;		 //Start Temperature
double	Tend	= 4;		 //End Temperature
double	Tstep	= 0.01;		 //Temperature Step-Size
double  outPrec = 6;		 //Output Precision (decimal places)
int		verbose = 1;		 //Verbose Option
double 	J = 1; 				 //interaction energy
int 	k = 1; 				 //Boltzman's constant

//Global Variables
int **spin;	 				//spin array
bool **cluster;				//cluster array
double **metric;	 		//distance metric
double sumE, sumE2; 		//Energy Sums
double *sumM, *sumM2;	 	//Magnetization Sums
double sumMabs, sumM2abs;	//Absolute Magnetization Sums
double p_add; 				//transition probability
double T;					//Temperature

//timer variables
clock_t t1,t2; 

int kdelta (int spin1, int spin2) {
	//kronecker delta.
	return spin1==spin2 ? 1 : 0;
}

double drand ( ) { 
	//random decimal from [0,1)
	return (double)rand() / ((double)RAND_MAX + 1);
}

int randint (int min, int max) {
	//random integer from [min, max]
	return floor((max - min + 1)*drand()) + min;
}

void initialization ( ) { 
	//seed random number generator	
	srand(time(NULL));

	//create spin array and assign spin values
	spin = new int* [L]; 
	for (int i = 0; i < L; i++) 
		spin[i] = new int [L];
	cluster = new bool* [L];
	for (int i = 0; i < L; i++) 
		cluster[i] = new bool [L];
	double angle[q-1];
	for (int i=0; i<q; i++)
		angle[i] = (double)i*2*PI/((double)q);
	metric = new double* [q-1]; 
	for (int i = 0; i < q; i++) 
		metric[i] = new double [q-1];
	for (int i=0; i<q; i++)
		for (int j=0; j<q; j++) { 
			cout<<"";
			metric[i][j] = kdelta(i,j);
		}
	sumM = new double [q-1];
	sumM2 = new double [q-1];
}

void ResetConfig ( ) {
	for (int i=0; i<L; i++)
		for (int j=0; j<L; j++)	
			spin[i][j] = randint(0,q-1);
	//cluster addition probability
	p_add =  1 - exp(-J/(k*T));
	//reset sums;
	sumE=sumE2=sumMabs=0;
	for (int n=0;n<q;n++) {
		sumM[n]=0;sumM2[n]=0;
	}
}

void DisplaySpins (int verboseLevel) {
	if (verbose>verboseLevel) {
		cout<<endl<<"Site Matrix:"<<endl;
		for (int i=0; i<L; i++)
			for (int j=0; j<L; j++){	
				cout<<" "<<spin[i][j];
				if (j==L-1) cout<<endl;
			}
		cout<<endl;
	}
}

void DisplayParameters ( ) {
	//Display Initial Parameters
	cout<<"Parameters:"<<endl;
	cout<<" L       = "<<L<<endl;
	cout<<" MCSteps = "<<MCSteps<<endl;
	cout<<" Tstart  = "<<Tstart<<endl;
	cout<<" Tend    = "<<Tend<<endl;
	cout<<" Tstep   = "<<Tstep<<endl;
	cout<<" J       = "<<J<<endl;
	cout<<endl;
	std::cout << std::setprecision(2) << std::fixed;
	//Display Distance matrix
	cout<<"Distance Matrix:"<<endl;
	for (int i=0; i<q; i++)
		for (int j=0; j<q; j++){	
			cout<<" "<<right<<setw(5)<<metric[i][j];
			if (j==q-1) cout<<endl;
		}
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
	int i = randint(0,L-1);
	int j = randint(0,L-1);
	//grow the cluster
	GrowCluster(i,j,spin[i][j]);
	//choose new random spin type
	int newSpin = (spin[i][j]+randint(1,q-1))%q;
	//flip the cluster
	for (int i=0; i<L; i++)
		for (int j=0; j<L; j++)
			if (cluster[i][j])
				spin[i][j] = newSpin;
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
	if (spin[i][j] == cSpin)
		if (drand()<p_add)
			GrowCluster(i,j,cSpin);
}

void measureObservables ( ) {
	int M[q-1]; //magnetization
	for (int n=0; n<q; n++) 
		M[n]=0;
	int E = 0; //energy
	int s;
	for (int i = 0; i < L; i++) 
		for (int j = 0; j < L; j++) {
			int iNext = i == L-1 ? 0 : i+1; 
			int jNext = j == L-1 ? 0 : j+1; 
				s=spin[i][j];
				for (int n=0; n<q; n++)
					M[n] += q * kdelta(n,s - 1)/(q-1);
			E -= J*(kdelta(s,spin[iNext][j])+kdelta(s,spin[i][jNext]));
		}
	for (int n=0; n<q; n++) {
		sumM[n]  += M[n];
		sumM2[n] += M[n]*M[n];
	}
	sumE  += E;
	sumE2 += E*E;
	sumMabs += M[0]>0 ? M[0] : -M[0];
}

void displayAverages ( ) {
	double Z = MCSteps; //partition function 
	double N = L*L;	//Number of sites
	double sumMmax  = 0;
	double sumM2max = 0;
	for (int n=0;n<q;n++)
		if (sumM[n]>sumMmax) {
			sumMmax = sumM[n];
			sumM2max = sumM2[n];
		}
	//Averaged observables per site
	double meanE     = sumE/(N*Z);
	double meanE2    = sumE2/(N*N*Z);
	double meanM     = sumMmax/(N*Z);
	double meanM2    = sumM2max/(N*N*Z);
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
		ResetConfig();
		// Initial Display
		if (T==Tstart) {
			DisplaySpins(0);
			DisplayParameters();
		}
		// Thermalization Loop
		for (int i = 0; i < MCSteps/5; i++)
			ComputeMCStep();
		// Measurement Loop
		for (int i = 0; i < MCSteps; i++) {
			ComputeMCStep();
			measureObservables();
		}
		displayAverages();
		DisplaySpins(1);
	}
	DisplaySpins(0);
	timer(0);
	cin.get();
}
