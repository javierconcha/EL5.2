#!/bin/bash
STARTTIME=$(date)
while :
do
	if [ $(squeue -u jxc4005|grep ELRun|wc -l) -eq 0 ]
	then

	        echo "infinite loops [ hit CTRL+C to stop]"
        	# sleep 10
		STOPTIME=$(date)
		echo "Jobs Completed. Start:  $STARTTIME. Stop: $STOPTIME" | mail -s "Jobs Completed" jxc4005@rit.edu
       		exit	
	fi
	sleep 15m
done



#if $(queue -u jxc4005|grep HydRun|wc -l) == 0
#sent email
# "job completed"
