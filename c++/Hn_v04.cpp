#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <cstdlib>
#include <ctime>
#include <math.h>
#include <windows.h>
#include <time.h>
#include <iomanip>

#define PI 3.14159265

using namespace std;

//Usage: 	 g++ -o  G2_1a.exe Heis2d_v03.cpp -O2 ;./G2_1a.exe 2 32 50000 .3 1.5 0.05 2 0 > out_G2_1a.txt
 //			 g++ -o  G1_1a.exe Heis2d_v03.cpp -O2 ;./G1_1a.exe 2 32 50000 .3 1.5 0.05 2 0 > out_G1_1a.txt


//waiting function
void wait ( double seconds )
{
  clock_t endwait;
  endwait = clock () + seconds * CLOCKS_PER_SEC ;
  while (clock() < endwait) {}
}



//kronecker Delta
double kdelta (double pos1, double pos2)
{
	double d;
	if (pos1 == pos2){d=1;}
	else 			 {d=0;}
	return d;
}

//returns random integer between and including min and max.
int rand_int (int min, int max)
{
	int n = floor((max - min + 1)*(double)rand() / ((double)RAND_MAX + 1)) + min;
	return n;
}



//************************************************************************************************
//input order: 
//	q, grid length, number of iterations, Tstart, Tend, Tstep, distance_type, verbose
//verbose options:
//	verbose = 0, prints parameter values
//	verbose = 1, prints initial and final grid + parameter values
//type of distance function to use:
//	distance_type = 1, delta function
//	distance_type = 2, cosine function
int main(int argc, char **argv) { //argc is number of arguments, **argv is an 2d array of arguments

	//Input Parameters, in order of entry
	int q;
	int gridSize;
	int end;
	double Tstart;
	double Tend;
	double Tstep;
	int verbose;
	int distance_type;

	//Get Inputs
	if (1<argc){q = atoi(argv[1]);}							//q-value
	else{q = 2;}

	if (2<argc){gridSize = atoi(argv[2]);}		//length of grid side
	else{gridSize = 50;}

	if (3<argc){end = atoi(argv[3]);} 			//number of loop iterations
	else{end = 1000;}

	if (4<argc){Tstart = atof(argv[4]);} 		//temperature start
	else{Tstart = 1;}	

	if (5<argc){Tend = atof(argv[5]);} 			//temperature end
	else{Tend = Tstart + 3;} 	

	if (6<argc){Tstep = atof(argv[6]);} 		//temperature step-size
	else{Tstep = 0.5;} 	

	if (7<argc){verbose = atoi(argv[7]);}		//verbose level
	else{verbose = 0;}		

	int i,j;
	int rowNum,colNum;
	
	int J = 2; 				//interaction energy
	int k = 1; 				//Boltzman's constant
	
	double Z;					//partion function
	double E;
	double sumE;  			//running energy sum
	double sumE2;  			//running energy^2 sum 
	double sumE3; 
	double sumE4; 
	double sumM[q-1];
	double sumM2[q-1];
	double sumM3[q-1];
	double sumM4[q-1];
	double meanM;
	double meanM2;
	double meanM3;
	double meanM4;
	double meanE;			// <E>
	double meanE2;			// <E^2>
	double meanE3;
	double meanE4;
	double E_curr;			//energy of current state
	double E_new;			//energy of new state
	double deltaE; 			//change in energy
	double chi_N;			//magnetic susceptibility per site
	double c_N;				//specific heat per site
	
	double p_trans; 		//transition probability
	double p_rand; 			//random probability from 0 to 1

	double N = pow(gridSize,2); //Number of grid points, for 2x2 array.
	
	int u_neighbor, d_neighbor, l_neighbor, r_neighbor; 			//neighbor indices
	double u_curr_dist, d_curr_dist, l_curr_dist, r_curr_dist;		//current neighbor distances
	double u_new_dist,  d_new_dist,  l_new_dist,  r_new_dist;		//new neighbor distances

	int neighbors 	[gridSize][gridSize]; //neighbor array
	int grid 		[gridSize][gridSize]; //grid array
	

	double M [q-1]; 		 //magnetization array (for each spin type);
	double Mmax = 0;		 //maximum magnetization;
	double sumMmax = 0;
	double sumM2max = 0;
	double sumM3max = 0;
	double sumM4max = 0;
	double M4Cumulant = 0;
	double E4Cumulant = 0;
	double M4Cumulant2 = 0;
	double E4Cumulant2 = 0;
	double angleSpace [q-1]; //array of possible angle values
	int spinNum;
	
	


	//Distance Matrix Set By Function
	double distance [8][8];
	
	//angleSpace initializer (for cosine distance)
	if (verbose>0){cout<<"Angles:"<<endl;}
	for (spinNum=0; spinNum<q; spinNum++)
	{
		angleSpace[spinNum] = (double)spinNum*PI/((double)q);
		if (verbose>0){cout<<angleSpace[spinNum]<<" "<<endl;}
	}
	if (verbose>0){cout<<endl;}
	
	for (colNum=0; colNum<q; colNum++)
	{
		for (rowNum=0; rowNum<q; rowNum++)
		{			
			distance[rowNum][colNum] = pow(cos(angleSpace[colNum]-angleSpace[rowNum] ),2);
			if (distance[rowNum][colNum]<0)
			{
				//distance[rowNum][colNum] = -distance[rowNum][colNum];
			}

		}//row loop
	}//column loop



	//Distance Matrix Explicitly Set
/*	
	int distance [8][8] =
	{
        {4, 3, 3, 2, 2, 1, 1, 0},
        {3, 4, 2, 3, 1, 2, 0, 1},
		{3, 2, 4, 3, 1, 0, 2, 1},
        {2, 3, 3, 4, 0, 1, 1, 2},
		{2, 1, 1, 0, 4, 3, 3, 2},
        {1, 2, 0, 1, 3, 4, 2, 3},
		{1, 0, 2, 1, 3, 2, 4, 3},
        {0, 1, 1, 2, 2, 3, 3, 4}
    };

	//Normalized group distance
	double distance [8][8] =
	{
        {1.00, 0.75, 0.75, 0.50, 0.50, 0.25, 0.25, 0.00},
        {0.75, 1.00, 0.50, 0.75, 0.25, 0.50, 0.00, 0.25},
		{0.75, 0.50, 1.00, 0.75, 0.25, 0.00, 0.50, 0.25},
        {0.50, 0.75, 0.75, 1.00, 0.00, 0.25, 0.25, 0.50},
		{0.50, 0.25, 0.25, 0.00, 1.00, 0.75, 0.75, 0.50},
        {0.25, 0.50, 0.00, 0.25, 0.75, 1.00, 0.50, 0.75},
		{0.25, 0.00, 0.50, 0.25, 0.75, 0.50, 1.00, 0.75},
        {0.00, 0.25, 0.25, 0.50, 0.50, 0.75, 0.75, 1.00}
    };
	
	//Potts Model Distance
	double distance [8][8] =
	{
        {1, 0, 0, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 0, 0},
		{0, 0, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 0, 0, 0, 0, 1}
    };
	
	double distance [5][5] =
	{
        {1, 0, 0, 0, 0},
        {0, 1, 0, 0, 0},
		{0, 0, 1, 0, 0},
        {0, 0, 0, 1, 0},
		{0, 0, 0, 0, 1}
	};
	
	double distance [4][4] =
	{
        {1, 0, 0, 0},
        {0, 1, 0, 0},
		{0, 0, 1, 0},
        {0, 0, 0, 1}
	};
	
	double distance [2][2] =
	{
        {1, 0,},
        {0, 1,}
	};
	
	g++ -o  H1_j4.exe Hn_v04.cpp -O2 ;./H1_j4.exe 2 32 1000000 3 6 0.01 2 0 > out_H1_j4.txt
	
 	double distance [8][8] =
	{
 {1.00, 0.75, 0.75, 0.50, 0.50, 0.25, 0.25, 0.00},
{0.75, 1.00, 0.50, 0.75, 0.25, 0.50, 0.00, 0.25},
{0.75, 0.50, 1.00, 0.25, 0.75, 0.00, 0.50, 0.25},
{0.50, 0.25, 0.75, 0.00, 1.00, 0.25, 0.75, 0.50},
{0.50, 0.75, 0.25, 1.00, 0.00, 0.75, 0.25, 0.50},
{0.25, 0.50, 0.00, 0.75, 0.25, 1.00, 0.50, 0.75},
{0.25, 0.00, 0.50, 0.25, 0.75, 0.50, 1.00, 0.75},
{0.00, 0.25, 0.25, 0.50, 0.50, 0.75, 0.75, 1.00}
};
*/
	
	//Write Distance Matrix
	std::cout << std::setprecision(2) << std::fixed;
	cout<<"Distance Matrix:"<<endl;
	for (colNum=0; colNum<q; colNum++)
	{
		for (rowNum=0; rowNum<q; rowNum++)
		{			
			cout<<" "<<distance[rowNum][colNum];
		}//row loop
		cout<<endl;
	}//column loop
	cout<<endl;
	
	
	std::cout << std::setprecision(6) << std::fixed;
	srand(time(NULL));//seed random number generator

	clock_t t1,t2; //clock variables
	t1=clock(); //start timer

	//display initial parameters
	cout<<"Parameters:"<<endl<<" gridSize = "<<gridSize<<"; iterations = "<<end<<"; ";
	cout<<"Tstart = "<<Tstart<<"; Tend = "<<Tend<<"; Tstep = "<<Tstep<<"; ";
	cout<<"q = "<<q<<"; J = "<<J<<";"<<endl<<endl;

	cout<<"T,       "    <<" \t";
	cout<<"meanM,   "<<" \t"<<"meanM2,  "<<" \t";
	cout<<"meanE,   "<<" \t"<<"meanE2,  "<<" \t";
	cout<<"chi_N,   "<<" \t"<<"c_N,     ";
	cout<<"; "<<endl;

	//Set output precision to 6 decimal places
	std::cout << std::setprecision(6) << std::fixed;
	
	
	//Temperature Loop
	for (double T=Tstart; T<=Tend; T=T+Tstep)
	{
		//reset energy sums
		sumE  = 0;
		sumE2 = 0;
		sumE3 = 0;
		sumE4 = 0;
		
		//reset magnetizations
		for (spinNum=0; spinNum<q; spinNum++)
		{
			M[spinNum] = 0;		//magnetization per iteration
			sumM[spinNum] = 0;
			sumM2[spinNum] = 0;
			sumM3[spinNum] = 0;
			sumM4[spinNum] = 0;
		}
		
		Mmax=0;
		sumMmax=0;
		sumM2max=0;
		sumM3max=0;
		sumM4max=0;

		//Construct initial grid
		if (verbose>0){cout<<"Initial Grid:"<<endl;}

		for (colNum=0; colNum<gridSize; colNum++)
		{
			for (rowNum=0; rowNum<gridSize; rowNum++)
			{			
						//assign random integer from the interval [0,q-1]
						grid[rowNum][colNum] = rand_int(0,q-1);
						
						//output initial grid if verbose > 0
						if (verbose>0){cout<<" "<<grid[rowNum][colNum];}
						
			}//row loop
			if (verbose>0){cout<<endl;}
			
		}//column loop

		if (verbose>0){cout<<endl;}
		
		//Thermalization Loop
		for (i=0; i<end/100; i++) 
		{ 
		
			//reset magnetizations
		for (spinNum=0; spinNum<q; spinNum++)
		{
			M[spinNum] = 0;
		}
		
		Mmax=0;E=0;
		
			//row Loop
			for (rowNum=0; rowNum<gridSize; rowNum++) 
			{ 
			
				//up and down neighbor positions
				u_neighbor = rowNum-1;
				d_neighbor = rowNum+1;

				//account for endpoints
				if 		(rowNum==0)				{u_neighbor = gridSize-1;}
				else if (rowNum==gridSize-1)	{d_neighbor=0;}

				//column loop
				for (colNum=0; colNum<gridSize; colNum++) 
				{ 
				
					//left and right neighbor positions
					l_neighbor = colNum-1;
					r_neighbor = colNum+1;

					//account for endpoints
					if 		(colNum==0)				{l_neighbor = gridSize-1;}
					else if (colNum==gridSize-1)	{r_neighbor=0;}

					//choose random spin
					spinNum = rand_int(0,q-1);
					
					//change the spinNum if it matches the current state
					if (spinNum == grid[rowNum][colNum])
					{
						spinNum = (spinNum + rand_int(1,q-1)) % q;  //modulo q
					}
					
					//calculate neighbor distances for current position
					l_curr_dist = distance[ grid[rowNum][colNum] ][ grid[rowNum][l_neighbor] ];
					r_curr_dist = distance[ grid[rowNum][colNum] ][ grid[rowNum][r_neighbor] ];
					u_curr_dist = distance[ grid[rowNum][colNum] ][ grid[u_neighbor][colNum] ];
					d_curr_dist = distance[ grid[rowNum][colNum] ][ grid[d_neighbor][colNum]] ;
	
					//calculate neighbor distances for possible new position
					l_new_dist = distance[spinNum][ grid[rowNum][l_neighbor] ];
					r_new_dist = distance[spinNum][ grid[rowNum][r_neighbor] ];
					u_new_dist = distance[spinNum][ grid[u_neighbor][colNum] ];
					d_new_dist = distance[spinNum][ grid[d_neighbor][colNum] ];

					//calculate energies
					E_curr = -J * (l_curr_dist + r_curr_dist + u_curr_dist + d_curr_dist);
					E_new  = -J * (l_new_dist  + r_new_dist  + u_new_dist  + d_new_dist);
					
					//energy difference
					deltaE =  E_new - E_curr;

					//transition probability
					p_trans = exp(-deltaE/(k * T));

					//random probability, from 0 to 1
					p_rand = (double)rand() / ((double)RAND_MAX + 1);

					//spin transition condition
					if (p_trans > p_rand)
					{
						//flip the spin
						grid[rowNum][colNum] = spinNum;	
					}

				}//colLoop
				
				if (verbose>1){cout<<endl;}
				
			}//rowLoop
						
		}//Thermalization Loop
			
		//grid iteration Loop
		for (i=0; i<end; i++) 
		{ 
		
		for (spinNum=0; spinNum<q; spinNum++)
		{
			M[spinNum] = 0;
		}
		
		E=0;
		
		
		
			//row Loop
			for (rowNum=0; rowNum<gridSize; rowNum++) 
			{ 
			
				//up and down neighbor positions
				u_neighbor = rowNum-1;
				d_neighbor = rowNum+1;

				//account for endpoints
				if 		(rowNum==0)				{u_neighbor = gridSize-1;}
				else if (rowNum==gridSize-1)	{d_neighbor=0;}

				//column loop
				for (colNum=0; colNum<gridSize; colNum++) 
				{ 
				
					//left and right neighbor positions
					l_neighbor = colNum-1;
					r_neighbor = colNum+1;

					//account for endpoints
					if 		(colNum==0)				{l_neighbor = gridSize-1;}
					else if (colNum==gridSize-1)	{r_neighbor=0;}

					//choose random spin
					spinNum = rand_int(0,q-1);
					
					//change the spin if it matches the current state
					if (spinNum == grid[rowNum][colNum])
					{
						spinNum = (spinNum + rand_int(1,q-1)) % q;  //modulo q
					}
					
					//calculate neighbor distances for current position
					l_curr_dist = distance[ grid[rowNum][colNum] ][ grid[rowNum][l_neighbor] ];
					r_curr_dist = distance[ grid[rowNum][colNum] ][ grid[rowNum][r_neighbor] ];
					u_curr_dist = distance[ grid[rowNum][colNum] ][ grid[u_neighbor][colNum] ];
					d_curr_dist = distance[ grid[rowNum][colNum] ][ grid[d_neighbor][colNum]] ;
	
					//calculate neighbor distances for possible new position
					l_new_dist = distance[spinNum][ grid[rowNum][l_neighbor] ];
					r_new_dist = distance[spinNum][ grid[rowNum][r_neighbor] ];
					u_new_dist = distance[spinNum][ grid[u_neighbor][colNum] ];
					d_new_dist = distance[spinNum][ grid[d_neighbor][colNum] ];
					
					//calculate energies
					E_curr = -J * (l_curr_dist + r_curr_dist + u_curr_dist + d_curr_dist);
					E_new  = -J * (l_new_dist  + r_new_dist  + u_new_dist  + d_new_dist);
					
					//energy difference
					deltaE =  E_new - E_curr;

					//transition probability
					p_trans = exp(-deltaE/(k * T));

					//random probability, from 0 to 1
					p_rand = (double)rand() / ((double)RAND_MAX + 1);

					//spin transition condition
					if (p_trans > p_rand)
					{
						//flip the spin
						grid[rowNum][colNum] = spinNum;	
						
						//add new energy
						E = E + E_new/2;
						//sumE  = sumE  + E_new/2;						
						//sumE2 = sumE2 + pow(E_new/2,2);
					}
					else
					{
						//add current energy
						E = E + E_curr/2;
						//sumE  = sumE  + E_curr/2;						
						//sumE2 = sumE2 + pow(E_curr/2,2);
					}


					for (spinNum=0; spinNum<q; spinNum++)
					{
						//magnetization equals 1 or -1/(q-1)
						M[spinNum] = M[spinNum] + (q * kdelta(spinNum, grid[rowNum][colNum]) - 1);
							//M[spinNum] = M[spinNum] + kdelta(spinNum, grid[rowNum][colNum]);
							

						
					}


				}//colLoop
				
				if (verbose>1){cout<<endl;}
				
			}//rowLoop
			
						sumE  = sumE + E;
						sumE2 = sumE2 + pow(E,2);
				//		sumE3 = sumE3 + pow(E,3);
				//		sumE4 = sumE4 + pow(E,4);
						
						for (spinNum=0; spinNum<q; spinNum++)
						{
							M[spinNum]      = M[spinNum]/(q-1);
							
							sumM[spinNum] 	= sumM[spinNum]  + M[spinNum];
							sumM2[spinNum]	= sumM2[spinNum] + pow(M[spinNum],2);
					//		sumM3[spinNum]	= sumM3[spinNum] + pow(M[spinNum],3);							
					//		sumM4[spinNum]	= sumM4[spinNum] + pow(M[spinNum],4);
						}
		}//grid iteration Loop	

		//calculate maximum spin
		for (spinNum=0; spinNum<q; spinNum++)
		{		
			//sumM2max is dependent on sumMmax
			if (sumM[spinNum]  > sumMmax) 
			{
				sumMmax  = sumM[spinNum];
				sumM2max = sumM2[spinNum];
			//	sumM3max = sumM3[spinNum];
		//		sumM4max = sumM4[spinNum];
			}
							
		}
				
		//Construct Final grid if verbose > 0
		if (verbose>0)
		{
			cout<<endl<<"Final Grid:"<<endl;
			for (colNum=0; colNum<gridSize; colNum++)
			{
				for (rowNum=0; rowNum<gridSize; rowNum++)
				{			
					cout<<" "<<grid[rowNum][colNum];			
				}
				
				if (verbose>0){cout<<endl;}
			}
			
			cout<<endl;
		}
			
		//partition function (?)
		Z = ((double)i+1);
		
		//mean per site
		meanE  = sumE/(N*Z);
		meanE2 = sumE2/(N*N*Z);
//		meanE3 = sumE3/(pow(N,3)*Z);
//		meanE4 = sumE4/(pow(N,4)*Z);
		meanM  = sumMmax/(N*Z);
		meanM2 = sumM2max/(N*N*Z);
//		meanM3 = sumM3max/(pow(N,3)*Z);
//		meanM4 = sumM4max/(pow(N,4)*Z);
			
		//specific magnetic susceptibility 
		chi_N = N*(meanM2-pow(meanM,2))/(k*T);
		
		//specific heat (heat capcitiy over number of sites)
		c_N = N*(meanE2-pow(meanE,2)) / (k*pow(T,2));
		
		//4th Order Cumulants
//		M4Cumulant = 1 - meanM4/(3*pow(meanM2,2));
//		E4Cumulant = 1 - meanE4/(3*pow(meanE2,2));
//		M4Cumulant2 = 1 - ( meanM4-4*meanM3*meanM + 6*meanM2*pow(meanM,2) - 3*pow(meanM,4))/(3*(pow(meanM2,2)-2*meanM2*pow(meanM,2)+pow(meanM,4)));
//		E4Cumulant2 = 1 - ( meanE4-4*meanE3*meanE + 6*meanE2*pow(meanE,2) - 3*pow(meanE,4))/(3*(pow(meanE2,2)-2*meanE2*pow(meanE,2)+pow(meanE,4)));
//		M4Cumulant2 = ( meanM4-4*meanM3*meanM + 6*meanM2*pow(meanM,2) - 3*pow(meanM,4)) - (3*(pow(meanM2,2)-2*meanM2*pow(meanM,2)+pow(meanM,4)));
//		E4Cumulant2 = ( meanE4-4*meanE3*meanE + 6*meanE2*pow(meanE,2) - 3*pow(meanE,4)) - (3*(pow(meanE2,2)-2*meanE2*pow(meanE,2)+pow(meanE,4)));

		
		//display output parameters
		cout<<T    <<", \t";

		//Standard Output
		cout<<meanM<<", \t"<<meanM2<<", \t";
		cout<<meanE<<", \t"<<meanE2<<", \t";
//		cout<<M4Cumulant<<", \t"<<E4Cumulant<<", \t";
//		cout<<M4Cumulant2<<", \t"<<E4Cumulant2<<", \t";
		cout<<chi_N<<", \t"<<c_N;
		cout<<",\t\t";
		
		//Individual Magnetization Output
//		cout<<(1+(q-1)*sumM[0]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[1]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[2]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[3]/(N*Z))/q<<", \t";
//		cout<<(1+(q-1)*sumM[4]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[5]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[6]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[7]/(N*Z))/q;
		//cout<<(sumM[0]+sumM[1]+sumM[2]+sumM[3])/(N*Z)<<", \t"<<(sumM[4]+sumM[5]+sumM[6]+sumM[7])/(N*Z)<<", \t";
		//cout<<(sumM[0]+sumM[2]+sumM[5]+sumM[7])/(N*Z)<<", \t"<<(sumM[1]+sumM[3]+sumM[4]+sumM[6])/(N*Z)<<", \t";
		//cout<<(sumM[0]+sumM[1]+sumM[6]+sumM[7])/(N*Z)<<", \t"<<(sumM[2]+sumM[3]+sumM[4]+sumM[5])/(N*Z)<<", \t";
		cout<<";"<<endl;
		
	
	} //Temperature Loop
	
	t2=clock();//end timer
    float diff ((float)t2-(float)t1);//calculate time difference
	cout<<endl<<"Run Time: "<<diff / CLOCKS_PER_SEC<<" seconds";
		
	 
}//main loop

