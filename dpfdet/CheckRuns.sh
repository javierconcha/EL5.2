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
		SITE="$(echo $DIR | cut -d/ -f8)"
                DPFCHL="$(echo $DIR | cut -d/ -f10)"
                DPFTSS="$(echo $DIR | cut -d/ -f12)"
                echo $SITE $DPFCHL $DPFTSS
		
		input=$SITE".txt"
		cat $input| sed 's"site"'$SITE'"g' | sed 's"user_dpfCHL"'$DPFCHL'"g' | sed 's"user_dpfTSS"'$DPFTSS'"g' > $directory/input.txt

                cat ELRun.sh | sed 's"flag"'$DIR'"g' > $DIR/ELRun.sh
               	chmod 755 $DIR/ELRun.sh
		#cp ./CommonInputs/* $directory/
                #sbatch --qos=cis-normal $directory/ELRun.sh
#               sbatch --qos=cis-nopreempt $directory/ELRun.sh
                sbatch --qos schott --partition premium --mem=1000 $DIR/ELRun.sh
	fi
	let i++
	echo $i
done
echo Jobs not completed: $(cat ./notsubmitted_list.txt|wc -l)

if [ "$(cat ./notsubmitted_list.txt|wc -l)" -ne 0 ]
then
	nohup nice ./monitor.sh > nohup.out &
else
	exit
fi
