#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "mpi.h"
#define SEED 35791246

int main (int argc, char *argv[]) {

	double x, y, z;
	double pi;
	int id, nTasks;
	long long int i, npoints, inside;
	FILE *fp;
	char filename[20];

	MPI_Init(&argc,&argv);
	MPI_Comm_size(MPI_COMM_WORLD,&nTasks);
	MPI_Comm_rank(MPI_COMM_WORLD,&id);

	sprintf(filename, "result_%d.txt", id);
	fp=fopen(filename, "w");

	npoints = 1000000000;
	inside = 0;

	srand (SEED);
	for (i = id; i < npoints; i +=nTasks)
	{
	        x = (double) rand()/RAND_MAX;
	        y = (double) rand()/RAND_MAX;
	        z = x*x+y*y;
	        if (z <= 1.0)
                inside++;
	}

	pi = 4.0*inside/npoints;
	fprintf(fp,"%.20f", pi);
	fclose(fp);
	MPI_Finalize();

	return 0;
}

