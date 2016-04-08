#!/bin/bash
myproxy-get-delegation -l mpgproxy -m biomed
echo "PASS: MPGproxy"
export LCG_CATALOG_TYPE=lfc
export LFC_HOME=/grid/biomed
export LFC_HOST=lfc-biomed.in2p3.fr
