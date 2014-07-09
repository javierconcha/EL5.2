#!/bin/bash
rm notsubmitted_list.txt

for DIR in `cat directory_list.txt`
do
	if [ -f "$DIR/ref/tempR.txt" ]
	then
		echo "$DIR/ref/tempR.txt found."
	else
		echo "$DIR/ref/tempR.txt not found."
		echo $DIR >> $PWD/notsubmitted_list.txt
		SITE="$(echo $DIR | cut -d/ -f7)"
                CHL="$(echo $DIR | cut -d/ -f9)"
                SM="$(echo $DIR | cut -d/ -f11)"
                CDOM="$(echo $DIR | cut -d/ -f13)"
                DPF="$(echo $DIR | cut -d/ -f15)"
                echo $SITE $CHL $SM $CDOM $DPF
		
		input=$SITE".txt"
                cat $input | sed 's"site"'$SITE'"g' | sed 's"fla1"'$CHL'"g' | sed 's"fla2"'$CDOM'"g' | sed 's"fla3"'$SM'"g' | sed 's"user_dpfCHL"'$DPF'"g' | sed 's"user_dpfTSS"'$DPF'"g'  > $DIR/input.txt

                 cat ELRun.sh | sed 's"flag"'$DIR'"g' > $DIR/ELRun.sh
                 #cp ./CommonInputs/* $directory/
                 #sbatch --qos=cis-normal $directory/ELRun.sh
#                sbatch --qos=cis-nopreempt $directory/ELRun.sh
                 sbatch --qos schott --partition premium $DIR/ELRun.sh

	fi
	let i++
	echo $i
done
echo Jobs not completed: $(cat ./notsubmitted_list.txt|wc -l)

nohup nice ./monitor.sh > nohup.out &
