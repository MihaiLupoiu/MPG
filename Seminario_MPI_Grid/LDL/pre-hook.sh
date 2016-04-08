#!/bin/sh
pre_run_hook () {
	tar xzvf ldl.tar.gz
	make 
	
	return 0
}