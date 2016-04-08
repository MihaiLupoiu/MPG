#!/bin/sh

export OUTPUT_PATTERN="host_*.txt"
export OUTPUT_ARCHIVE=myout.tgz

# the first paramater is the name of a host in the
copy_from_remote_node() {
	if [[ $1 == `hostname` || $1 == 'hostname -f' || $1 == "localhost" ]]; then
		echo "skip local host"
		return 1
	fi

	CMD="scp -r $1:\"$PWD/$OUTPUT_PATTERN\" ."
	$CMD
}

post_run_hook () {
	echo "post_run_hook called"
	
	if [ "x$MPI_START_SHARED_FS" == "x0" -a "x$MPI_SHARED_HOME" != "xyes" ] ; then
		echo "gather output from remote hosts"
		mpi_start_foreach_host copy_from_remote_node
	fi
	
	echo "pack the data"
	tar cvzf $OUTPUT_ARCHIVE $OUTPUT_PATTERN
	return 0
}
