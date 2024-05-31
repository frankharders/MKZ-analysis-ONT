#!/bin/bash

##  activate the environment for this downstream analysis
eval "$(conda shell.bash hook)";
conda activate dragonflye;

FILE=samples.txt;


count1=1;
countS=$(cat "$FILE" | wc -l);


while [ $count1 -le $countS ]; do 

line=$(cat "$FILE" | awk 'NR=='$count1)

echo $line;

BC=$(echo "$line" | cut -f1 -d',');
name=$(echo "$line" | cut -f2 -d',');
mkdir -p 05_dragonflye/"$name";

FILEin=02a_trim_reads/"$name"."$BC".PA067338.EXP-PBC096.porechop.fastq.gz;
OUTdir=05_dragonflye/"$name";

MEDAKA=10;
RACON=10;


dragonflye --reads "$FILEin" --outdir "$OUTdir" --keepfiles --nanohq --force -g 7000 --racon "$RACON" --medaka "$MEDAKA" --model r1041_e82_400bps_hac_v4.3.0;


count1=$((count1+1));
done

exit 1