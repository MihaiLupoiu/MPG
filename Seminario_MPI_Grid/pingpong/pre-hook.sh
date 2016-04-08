#!/bin/sh
pre_run_hook () {
	tar xzvf pingpong.tar.gz
	make 
	
	return 0
}