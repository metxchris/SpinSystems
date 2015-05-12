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
void GrowCluster(int i, int j, int cluster_spin);
void TryAddNeighbor(int i, int j, int cluster_spin);
void ReflectCluster();

//Display Options:
//verbose = 0, prints parameter values
//verbose = 1, also prints initial and final spin matrix
//verbose = 2, also prints spin matrix for each individual T

//Global Constants
int     q       = 5;         //Number of Spins  
int     L       = 8;        //Length of Grid 
int     MCSteps = pow(10,4); //number of MCSteps
double  Tstart  = 1;       //Start Temperature
double  Tend    = 2;         //End Temperature
double  Tstep   = 0.05;      //Temperature Step-Size
double  outPrec = 6;         //Output Precision (decimal places)
int     verbose = 1;         //Verbose Option
double  J = 1;               //interaction energy
int     k = 1;               //Boltzman's constant

//Global Variables
int **spin;                 //spin array
bool **cluster;             //cluster array
double **metric;            //distance metric
double sumE, sumE2;         //Energy Sums
double *sumM, *sumM2;       //Magnetization Sums
double sumMabs, sumM2abs;   //Absolute Magnetization Sums
double p_add;               //transition probability
double T;                   //Temperature
double *angle;              //Angle array

//timer variables
clock_t t1,t2; 

int kdelta (int spin1, int spin2) {
    return spin1==spin2 ? 1 : 0;
}

double abs (double x) {
    return  x > 0 ? x  : -x; 
}

double drand ( ) { 
    //random decimal from [0,1)
    return (double)rand() / ((double)RAND_MAX + 1);
}

int irand (int min, int max) {
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
    angle = new double [q-1];
    for (int i=0;i<q;i++){
        cout<<""; // add these to avoid random C++ bug.
        angle[i]=(double)i*PI/((double)q);
    }
    metric = new double* [q-1]; 
    for (int i = 0; i < q; i++) 
        metric[i] = new double [q-1];
    for (int i=0; i<q; i++)
        for (int j=0; j<q; j++) {
        cout<""; // add these to avoid random C++ bug.
            metric[i][j] = (1-pow(cos(angle[j]-angle[i]),2));
        }
    sumM = new double [q-1];
    sumM2 = new double [q-1];
}

void resetConfig ( ) {
    for (int i=0; i<L; i++)
        for (int j=0; j<L; j++) 
            spin[i][j] = irand(0,q-1);
    //reset sums;
    sumE = sumE2 = sumMabs = 0;
    for (int n=0;n<q;n++) {
        sumM[n] = 0; 
        sumM2[n] = 0;
    }
}

void displaySpins (int verboseLevel) {
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


void displayCluster () {
    cout<<endl<<"Cluster Matrix:"<<endl;
    for (int i=0; i<L; i++)
        for (int j=0; j<L; j++){    
            cout<<" "<<cluster[i][j];
            if (j==L-1) cout<<endl;
        }
    cout<<endl;
}


void ComputeMCStep ( ) {
    //reset the cluster array
    for (int i = 0; i < L; i++) 
        for (int j = 0; j < L; j++) 
            cluster[i][j] = false;
    //choose random spin
    int i = irand(0, L-1);
    int j = irand(0, L-1);
    //grow the cluster
    GrowCluster(1,1,spin[1][1]);
    ReflectCluster();

}

void GrowCluster(int i, int j, int cluster_spin) {
    //add spin to cluster
    cluster[i][j] = true;
    //find the indices of the 4 neighbors
    int iPrev = i == 0   ? L-1  : i-1; 
    int iNext = i == L-1 ? 0    : i+1; 
    int jPrev = j == 0   ? L-1  : j-1; 
    int jNext = j == L-1 ? 0    : j+1; 
    //Attempt to add neighbors to cluster
    if (!cluster[iPrev][j]) 
        TryAddNeighbor(iPrev, j, cluster_spin); 
    if (!cluster[iNext][j]) 
        TryAddNeighbor(iNext, j, cluster_spin); 
    if (!cluster[i][jPrev]) 
        TryAddNeighbor(i, jPrev, cluster_spin); 
    if (!cluster[i][jNext]) 
        TryAddNeighbor(i, jNext, cluster_spin); 
}

void TryAddNeighbor(int i, int j, int cluster_spin) {
        //cluster addition probability
        //p_add =  1 - exp(-J*(1-metric[spin[i][j]][cluster_spin])/(k*T));
        //cluster addition probability
    if (abs(spin[i][j] - cluster_spin)<2){
        p_add =  1 - exp(-J/(k*T));
        if (drand()<p_add)
            GrowCluster(i, j, cluster_spin);
    }
}

void ReflectCluster() {
    //choose reflection axis
    int reflection_axis = irand(0, 2*q-1)/2;
    cout<<"Reflection Axis: "<<reflection_axis;
    //Reflect the cluster
    for (int i=0; i<L; i++)
        for (int j=0; j<L; j++)
            if (cluster[i][j]) {
                int curr_angle = abs(spin[i][j]);
                int difference = spin[i][j]-reflection_axis;
                difference = difference > 0 ? difference : -difference;
                int new_angle = (curr_angle + 2*difference)%q;


                spin[i][j] = new_angle;
            }
}


int main() { 

    initialization();
    resetConfig();
    displaySpins(0);
    //DisplayParameters();
    ComputeMCStep();
    displaySpins(0);
    displayCluster();

}
