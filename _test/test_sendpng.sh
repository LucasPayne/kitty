#!/bin/bash
mode=none
if [ $# -gt 0 ] ; then mode="$1" ; fi
bash sendpng.sh "$mode" /home/lucas/drive/images/heat_solver.png
