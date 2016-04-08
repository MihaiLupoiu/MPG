#!/bin/sh
pre_run_hook () {
	tar xzvf imb.tar.gz
	cd src
	gmake
	
	cp IMB-MPI1 ../.
	cd ..
	
	return 0
}