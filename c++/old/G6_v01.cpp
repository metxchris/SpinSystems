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

//Usage: 	 g++ -o  G5_v01c.exe G5_v01.cpp -O2 ;./G5_v01c.exe 32 32 4000000 1.025 1.05 0.005 2 0 > out_G5_2cc.txt




//************************************************************************************************
//input order: 
//	q, grid length, number of iterations, Tstart, Tend, Tstep, distance_type, verbose
//Twalk options:
// Twalk = -1, uses random configuration each temperature step, thermalizing before each run.
// Twalk = 0, 1, ..., q-1; Twalk starts each site off with the assigned number and does not randomize the configuration afterwards.
//verbose options:
//	verbose = 0, prints parameter values
//	verbose = 1, prints initial and final grid + parameter values

int main(int argc, char **argv) { //argc is number of arguments, **argv is an 2d array of arguments

	//Input Parameters, in order of entry
	int q;
	int gridSize;
	int end;
	double Tstart;
	double Tend;
	double Tstep;
	int Twalk;
	int verbose;
	

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

	if (7<argc){Twalk = atoi(argv[7]);}		//Twalk option
	else{Twalk = 0;}		
	
		if (8<argc){verbose = atoi(argv[8]);}		//verbose level
	else{verbose = 0;}	

	string dName;
	int i,j;
	int rowNum,colNum;
	
	int J = 1; 				//interaction energy
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
		double sum2M[q-1];
	double sum2M2[q-1];
	double sum2M3[q-1];
	double sum2M4[q-1];
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
	double M2 [q-1]; 		 //magnetization array (for each spin type);
	double Mmax = 0;		 //maximum magnetization;
	double M2max = 0;		 //maximum magnetization;
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
	double g[gridSize/2];//correlation function
	double sumg[gridSize/2];
	double meang[gridSize/2];
	
	

//Distance Matrix Set By Function
	double distance [q][q];
	dName = "Standard Clock Distance";
	//angleSpace initializer (for cosine distance)
	if (verbose>0){cout<<"Angles:"<<endl;}
	for (spinNum=0; spinNum<q; spinNum++)
	{
		angleSpace[spinNum] = (double)spinNum*2*PI/((double)q);
		if (verbose>0){cout<<angleSpace[spinNum]<<" "<<endl;}
	}
	if (verbose>0){cout<<endl;}
	
	for (colNum=0; colNum<q; colNum++)
	{
		for (rowNum=0; rowNum<q; rowNum++)
		{			
			distance[rowNum][colNum] = (1+pow(cos(angleSpace[colNum]-angleSpace[rowNum] ),1))/2;
			if (distance[rowNum][colNum]<0)
			{
				//distance[rowNum][colNum] = -distance[rowNum][colNum];
			}

		}//row loop
	}//column loop


// g++ -o  H1_j9.exe G5_v01.cpp -O2 ;./H1_j9.exe 8 32 1000000 0.2 2 0.4 0 1> out_Clock_q8_L.txt

	//Write Distance Matrix
	std::cout << std::setprecision(2) << std::fixed;
	cout<<"Distance Matrix: "<<dName<<endl;
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


	//Set output precision to 6 decimal places
	std::cout << std::setprecision(6) << std::fixed;
	
	

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
		cout<<"Initial Grid:"<<endl;

		for (colNum=0; colNum<gridSize; colNum++)
		{
			for (rowNum=0; rowNum<gridSize; rowNum++)
			{			
						//assign random integer from the interval [0,q-1]
						if (Twalk < 0){grid[rowNum][colNum] = rand_int(0,q-1);}
						else {grid[rowNum][colNum] = Twalk;}
						
						
						//output initial grid if verbose > 0
						cout<<" "<<grid[rowNum][colNum];
						if(grid[rowNum][colNum]<10){cout<<" ";}
						
			}//row loop
			cout<<endl;
			
		}//column loop

		cout<<endl;
	 

		//display initial parameters
	cout<<"Parameters:"<<endl<<" gridSize = "<<gridSize<<"; iterations = "<<end<<"; ";
	cout<<"Tstart = "<<Tstart<<"; Tend = "<<Tend<<"; Tstep = "<<Tstep<<"; ";
	cout<<"q = "<<q<<"; J = "<<J<<"; Twalk = "<<Twalk<<";"<<endl<<endl;

	cout<<"T,       "    <<" \t";
	cout<<"meanM,   "<<" \t"<<"meanM2,  "<<" \t";
	cout<<"meanE,   "<<" \t"<<"meanE2,  "<<" \t";
	cout<<"M4Cumulant,"<<" "<<"E4Cumulant,"<<" ";
	cout<<"M4Cumulant2,"<<" "<<"E4Cumulant2,"<<" ";
	cout<<"chi_N,   "<<" \t"<<"c_N,     ";
	cout<<"; "<<endl;


	
		
			
			//Temperature Loop
	for (double T=Tstart; T<=Tend; T=T+Tstep)
	{
	
	
	
	if (Twalk <0 || T==Tstart )//Thermalize first sweep and if Twalk < -1
	{
		if (Twalk < -1)//Randomize grid 
		{
			//Construct initial grid
			for (colNum=0; colNum<gridSize; colNum++)
			{
				for (rowNum=0; rowNum<gridSize; rowNum++)
				{			
					//assign random integer from the interval [0,q-1]
					grid[rowNum][colNum] = rand_int(0,q-1);			
				}//row loop
			}//column loop
		}
	
		//Thermalization Loop
		for (i=0; i<20000; i++) 
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
				
			
				
			}//rowLoop
		}//Thermalization Loop		
	}//if (Twalk <0 || T==Tstart )
		
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
						//M[spinNum] = M[spinNum] + (q * kdelta(spinNum, grid[rowNum][colNum]) - 1);
						M[spinNum] = M[spinNum] + cos(grid[rowNum][colNum]);
						M2[spinNum] = M2[spinNum] + sin(grid[rowNum][colNum]);
							//M[spinNum] = M[spinNum] + kdelta(spinNum, grid[rowNum][colNum]);
							

						
					}


				}//colLoop
				
				
				
			}//rowLoop
			
						sumE  = sumE + E;
						sumE2 = sumE2 + pow(E,2);
						sumE3 = sumE3 + pow(E,3);
						sumE4 = sumE4 + pow(E,4);
						
						for (spinNum=0; spinNum<q; spinNum++)
						{
							M[spinNum]      = M[spinNum]/(q-1);
							M2[spinNum]      = M2[spinNum]/(q-1);
							
							sumM[spinNum] 	= sumM[spinNum]  + M[spinNum];
							sumM2[spinNum]	= sumM2[spinNum] + pow(M[spinNum],2);
							sum2M[spinNum] 	= sum2M[spinNum]  + M2[spinNum];
							sum2M2[spinNum]	= sum2M2[spinNum] + pow(M2[spinNum],2);

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
				sumM3max = sumM3[spinNum];
				sumM4max = sumM4[spinNum];
			}
							
		}
				
		
			
		//partition function (?)
		Z = ((double)i+1);
		
		//mean per site
		meanE  = sumE/(N*Z);
		meanE2 = sumE2/(N*N*Z);
		meanE3 = sumE3/(pow(N,3)*Z);
		meanE4 = sumE4/(pow(N,4)*Z);
		meanM  = sumMmax/(N*Z);
		meanM2 = sumM2max/(N*N*Z);
		meanM3 = sumM3max/(pow(N,3)*Z);
		meanM4 = sumM4max/(pow(N,4)*Z);
		

		//specific magnetic susceptibility 
		chi_N = N*(meanM2-pow(meanM,2))/(k*T);
		
		//specific heat (heat capcitiy over number of sites)
		c_N = N*(meanE2-pow(meanE,2)) / (k*pow(T,2));
		
		//4th Order Cumulants
		M4Cumulant = 1 - meanM4/(3*pow(meanM2,2));
		E4Cumulant = 1 - meanE4/(3*pow(meanE2,2));
//		M4Cumulant2 = 1 - ( meanM4-4*meanM3*meanM + 6*meanM2*pow(meanM,2) - 3*pow(meanM,4))/(3*(pow(meanM2,2)-2*meanM2*pow(meanM,2)+pow(meanM,4)));
//		E4Cumulant2 = 1 - ( meanE4-4*meanE3*meanE + 6*meanE2*pow(meanE,2) - 3*pow(meanE,4))/(3*(pow(meanE2,2)-2*meanE2*pow(meanE,2)+pow(meanE,4)));
		M4Cumulant2 = ( meanM4-4*meanM3*meanM + 6*meanM2*pow(meanM,2) - 3*pow(meanM,4)) - (3*(pow(meanM2,2)-2*meanM2*pow(meanM,2)+pow(meanM,4)));
		E4Cumulant2 = ( meanE4-4*meanE3*meanE + 6*meanE2*pow(meanE,2) - 3*pow(meanE,4)) - (3*(pow(meanE2,2)-2*meanE2*pow(meanE,2)+pow(meanE,4)));

		
		//display output parameters
		cout<<T    <<", \t";

		//Standard Output
		cout<<meanM<<", \t"<<meanM2<<", \t";
		cout<<meanE<<", \t"<<meanE2<<", \t";
		cout<<M4Cumulant<<", \t"<<E4Cumulant<<", \t";
		cout<<M4Cumulant2<<", \t"<<E4Cumulant2<<", \t";
		cout<<chi_N<<", \t"<<c_N<<";"<<endl;

		
		//Individual Magnetization Output
		// cout<<(1+(q-1)*sumM[0]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[1]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[2]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[3]/(N*Z))/q;
		
		// if (q>4)
		// {
			// cout<<", \t";
			// cout<<(1+(q-1)*sumM[4]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[5]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[6]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[7]/(N*Z))/q;
		// }
		// if (q>8)
		// {
			// cout<<", \t";
			// cout<<(1+(q-1)*sumM[8]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[9]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[10]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[11]/(N*Z))/q;
			// cout<<", \t";
			// cout<<(1+(q-1)*sumM[12]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[13]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[14]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[15]/(N*Z))/q;
		// }
		// if (q>16)
		// {
			// cout<<", \t";
			// cout<<(1+(q-1)*sumM[16]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[17]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[18]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[19]/(N*Z))/q;
			// cout<<", \t";
			// cout<<(1+(q-1)*sumM[20]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[21]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[22]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[23]/(N*Z))/q;
			// cout<<", \t";
			// cout<<(1+(q-1)*sumM[24]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[25]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[26]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[27]/(N*Z))/q;
			// cout<<", \t";
			// cout<<(1+(q-1)*sumM[28]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[29]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[30]/(N*Z))/q<<", \t"<<(1+(q-1)*sumM[31]/(N*Z))/q;
		// }
		// cout<<";"<<endl;
		
		
		//Construct Final grid of Temperature loop if verbose > 1
		if (verbose>1)
		{
			cout<<endl<<"Temperature Final Grid:"<<endl;
			for (colNum=0; colNum<gridSize; colNum++)
			{
				for (rowNum=0; rowNum<gridSize; rowNum++)
				{			
					cout<<" "<<grid[rowNum][colNum];			
				}
				
				cout<<";"<<endl;
			}
			
			cout<<endl;
		}
		
		
	
	}//Temperature Loop
	
	//Construct Overall Final grid if verbose > 0
		if (verbose>0)
		{
			cout<<endl<<"Overall Final Grid:"<<endl;
			for (colNum=0; colNum<gridSize; colNum++)
			{
				for (rowNum=0; rowNum<gridSize; rowNum++)
				{			
					cout<<" "<<grid[rowNum][colNum];			
				}
				
				cout<<endl;
			}
			
			cout<<endl;
		}
		
	t2=clock();//end timer
    float diff ((float)t2-(float)t1);//calculate time difference
	cout<<endl<<"Run Time: "<<diff / CLOCKS_PER_SEC<<" seconds";
		
	 
}//main loop





