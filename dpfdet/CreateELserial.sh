#!/bin/bash
STARTTIME=$(date)
for DIR in `cat directory_list5.txt`
do
	cd $DIR
	./ELRun.sh
	let i++
	echo $i
done
STOPTIME=$(date)
echo "Start:  $STARTTIME. Stop: $STOPTIME" | mail -s "Jobs Completed - Serial 5" jxc4005@rit.edu
