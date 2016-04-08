CC1=mpicc

all:
	$(CC1) -o pingpong.out pingpong.c

debug:
	$(CC1) -o pingpong.out pingpong.c -fsanitize=address -g

clean:
	rm *.out