#!/bin/bash
STARTTIME=$(date)
for DIR in `cat wrong_list.txt`
do
	cd $DIR
	chmod 755 ./ELRun.sh
	sbatch --qos schott --partition premium $DIR/ELRun.sh
	#./ELRun.sh
	let i++
	echo $i
done
STOPTIME=$(date)
echo "Start:  $STARTTIME. Stop: $STOPTIME" | mail -s "Jobs Completed - Serial" jxc4005@rit.edu
