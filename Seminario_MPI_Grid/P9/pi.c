#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <mpi.h>

int main (int argc, char** args)
{
	FILE *fp;
	int rank, size;

        MPI_Init (&argc, &args);        /* starts MPI */
        MPI_Comm_rank (MPI_COMM_WORLD, &rank);  /* get current process id */
        MPI_Comm_size (MPI_COMM_WORLD, &size);  /* get number of processes */

	char file[15];

	sprintf(file, "result_%d.txt", rank);
	//printf(file);

	int task_id;
	int total_tasks;
	long long int n;
	long long int i;
	double l_sum, x, h;
	task_id = rank;
	total_tasks = size;
	n = 10000000000;
 	

 	if (argc >= 2) {
        if ((n = atoi(args[1])) < 1000) n = 10000000000;
    }

	h = 1.0/n;
	l_sum = 0.0;
	for (i = task_id; i < n; i +=total_tasks){
		x = (i + 0.5)*h;
		l_sum += 4.0/(1.0 + x*x);
	}
	l_sum *= h;
//	printf("%0.12g\n", l_sum);
	

   	fp = fopen(file, "w+");
   	fprintf(fp,"%0.20g\n", l_sum);
   	fclose(fp);

	MPI_Finalize();
	return 0;
}
