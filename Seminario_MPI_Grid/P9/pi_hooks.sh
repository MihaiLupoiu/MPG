#!/bin/sh
export OUTPUT_PATTERN="result_*.txt"
export OUTPUT_ARCHIVE=ResultadoP9.tar.gz
export OUTPUT_HOST=se-ngi.ceta-ciemat.es
export OUTPUT_SE=lfn:/grid/biomed/MPG_15_16/Mihai
export OUTPUT_VO=biomed
pre_run_hook () {
    make
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

#       echo "tar cvzf $OUTPUT_ARCHIVE $OUTPUT_PATTERN"

        echo "delete old file if it is thre"
	lcg-del -a --vo $OUTPUT_VO $OUTPUT_SE/$OUTPUT_ARCHIVE

	

        echo "upload the data to SE"
        lcg-cr --vo $OUTPUT_VO -d $OUTPUT_HOST -l $OUTPUT_SE/$OUTPUT_ARCHIVE file://$PWD/$OUTPUT_ARCHIVE

#       echo "lcg-cr --vo $OUTPUT_VO -d $OUTPUT_HOST -l $OUTPUT_SE/$OUTPUT_ARCHIVE file://$PWD/$OUTPUT_ARCHIVE"

        rm $OUTPUT_PATTERN
        rm $OUTPUT_ARCHIVE

        echo "Downloading data"

        lcg-cp --vo $OUTPUT_VO $OUTPUT_SE/$OUTPUT_ARCHIVE file://$PWD/$OUTPUT_ARCHIVE

        echo "Processing data"
        tar xzvf $OUTPUT_ARCHIVE

        sum=0;
        for f in result_*.txt; do
                value=`cat $f`
                sum=`echo "$sum+$value" | bc -l`
        done
        echo $sum


	return 0
}
