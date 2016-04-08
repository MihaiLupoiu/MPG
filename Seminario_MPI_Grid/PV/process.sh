#!/bin/bash

       sum=0;
        for f in result_*.txt; do
                value=`cat $f`
                sum=`echo "$sum+$value" | bc -l`
        done
        echo $sum

