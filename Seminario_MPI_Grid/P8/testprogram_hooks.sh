#!/bin/sh
export OUTPUT_PATTERN=P8
export OUTPUT_ARCHIVE=resultadoMihai.tar.gz
export OUTPUT_HOST=storm-se-01.ba.infn.it
export OUTPUT_SE=lfn:/grid/biomed/MPG_15_16
export OUTPUT_VO=biomed
pre_run_hook () {
	tar xzvf testprogram.tgz
    cd o3parallel
    make
    cp ./o3sg_8 ./..
    cd ..
    return 0
}

# the first parameter is the name of a host in the
copy_from_remote_node() {
	if [[ $1 == `hostname` || $1 == 'hostname -f' || $1 == "localhost" ]]; then
		echo "skip local host"
		return 1
	fi
	# pack data
	CMD="scp -r $1:\"$PWD/$OUTPUT_PATTERN\" ."
	echo $CMD
	$CMD
}

post_run_hook () {
	echo "post_run_hook called"
	if [ "x$MPI_START_SHARED_FS" == "x0" ] ; then
		echo "gather output from remote hosts"
		mpi_start_foreach_host copy_from_remote_node
	fi
	echo "pack the data"
	tar cvzf $OUTPUT_ARCHIVE $OUTPUT_PATTERN
	
	echo "tar cvzf $OUTPUT_ARCHIVE $OUTPUT_PATTERN"
	
	echo "delete old file if it is thre"
	lfc-rm $OUTPUT_SE/$OUTPUT_ARCHIVE
	
	echo "upload the data to SE"
	lcg-cr --vo $OUTPUT_VO -d $OUTPUT_HOST -l $OUTPUT_SE/$OUTPUT_ARCHIVE file://$PWD/$OUTPUT_ARCHIVE
	
	echo "lcg-cr --vo $OUTPUT_VO -d $OUTPUT_HOST -l $OUTPUT_SE/$OUTPUT_ARCHIVE file://$PWD/$OUTPUT_ARCHIVE"
	
	return 0
}
