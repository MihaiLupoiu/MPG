CC1=mpicc

all:
	$(CC1) -o mpi.out ./tools.c mpi.c -lm

O3:
	$(CC1) -o mpi.out ./tools.c mpi.c -lm -O3

debug:
	$(CC1) -o mpi.out ./tools.c mpi.c -lm -fsanitize=address -g

clean:
	rm *.out