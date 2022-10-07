#!/bin/bash

echo "downloading HapMap CNV data"
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/cnv_data/hm3_cnv_submission.txt

echo "downloading README file"
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/cnv_data/00README.txt

mv 00README.txt READMEcnv_Nemesh.txt


echo "downloading sample ID information"
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/samples_individuals/*.txt.gz

echo "unzipping sample ID files"
gunzip *.txt.gz

echo "extracting sample ID from sample ID files"
for file in *_*.txt
do
	population=$(basename $file .txt)
	awk '{print $NF}' $file > ${population#*_}_samples.txt

	column -t -s ':' ${population#*_}_samples.txt > ${population#*_}_samples_2.txt

	awk '{print $5}' ${population#*_}_samples_2.txt > ${population#*_}_samples.txt
	rm ${population#*_}_samples_2.txt
done	
