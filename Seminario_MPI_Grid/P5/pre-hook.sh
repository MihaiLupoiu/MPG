#!/bin/sh
pre_run_hook () {
	
	# Compile the program.
	echo "Compiling ${I2G_MPI_APPLICATION}"
	
	# Actually compile the program.
	cmd="mpicc ${MPI_MPICC_OPTS} -o ${I2G_MPI_APPLICATION} ${I2G_MPI_APPLICATION}.c"
	$cmd
	if [ ! $? -eq 0 ]; then
		echo "Error compiling program. Exiting..."
		return 1
	fi
	
	# Everything's OK.
	echo "Successfully compiled ${I2G_MPI_APPLICATION}"
	
	return 0
}