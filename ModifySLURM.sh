#!/bin/bash
j=0
for i in $(squeue -u jxc4005 -h -t PD -o %i)
do
	#if [ "$j" -ne "1000" ];
	#then
		scontrol update jobid=$i partition=work
		scontrol update jobid=$i qos=free
		let j++
		echo $j
		echo $i	
	#else
	#	exit
	#fi
done
