# samtools index all bam files

cd /scratch/wuflemmi-F22/

mkdir Activity_4

cd Activity_4

nohup cp -R /scratch/Illumina-Human-Body-Map-BAMS . & #all .bam files are in this directory, copy to current directory

cd Illumina-Human-Body-Map-BAMS

for file in *.bam
do 
	nohup samtools index $file &
done

mv * ..

rmdir Illumina-Human-Body-Map-BAMS


# create symbolic links for 5 selected bam and index files:
## adipose, breast, colon, brain, liver

ln -s /scratch/Illumina-Human-Body-Map-BAMS/ERR030880_F73_Adipose.proj.accepted_hits.bam Adipose
ln -s /scratch/Illumina-Human-Body-Map-BAMS/ERR030883_F29_Breast.proj.accepted_hits.bam Breast
ln -s /scratch/Illumina-Human-Body-Map-BAMS/ERR030884_F68_Colon.proj.accepted_hits.bam Colon
ln -s /scratch/Illumina-Human-Body-Map-BAMS/ERR030882_F77_Brain.proj.accepted_hits.bam Brain
ln -s /scratch/Illumina-Human-Body-Map-BAMS/ERR030887_M37_Liver.proj.accepted_hits.bam Liver


ln -s ERR030880_F73_Adipose.proj.accepted_hits.bam.bai Adipose.bai
ln -s ERR030883_F29_Breast.proj.accepted_hits.bam.bai Breast.bai
ln -s ERR030884_F68_Colon.proj.accepted_hits.bam.bai Colon.bai
ln -s ERR030882_F77_Brain.proj.accepted_hits.bam.bai Brain.bai
ln -s ERR030887_M37_Liver.proj.accepted_hits.bam.bai Liver.bai


# run samtools idxstats on the 5 sets of files

samtools idxstats Adipose > Adipose.idxstats && \
samtools idxstats Breast > Breast.idxstats && \
samtools idxstats Colon > Colon.idxstats && \
samtools idxstats Brain > Brain.idxstats && \
samtools idxstats Liver > Liver.idxstats &


### idxstats columns are 1: ref sequence name, 2: chromosome size, 3: # of mapped reads, 4: # of unmapped reads

# create a merged text file that has the first column from any of the idxstats file (the chromosome name) and the # of mapped reads from each of the 5 samples as their own column

paste Adipose.idxstats Breast.idxstats Colon.idxstats Brain.idxstats Liver.idxstats | awk 'BEGIN {print "Chromosome", "Adipose", "Breast", "Colon", "Brain", "Liver" } { print $1, $3, $7, $11, $15, $19 }' > 5-Tissues.mapped.idxstats.txt

# line up columns by running the following command in command mode on vim on the new file:
## :%!column -t
## save: :wq

# run samtools flagstat on selected .bam files

samtools flagstat Adipose > Adipose.flagstat && \
samtools flagstat Breast > Breast.flagstat && \
samtools flagstat Colon > Colon.flagstat && \
samtools flagstat Brain > Brain.flagstat && \
samtools flagstat Liver > Liver.flagstat &

# get the number of total mapped reads and the number of reads whose mate mapped to a different chromosome

for file in *.flagstat; do echo "$file"; egrep "[0-9]+\s[+]\s[0-9]\smapped" "$file"; egrep "with mate mapped to a different chr$" "$file"; done


# samtools merge adipose and breast bam files, as well as liver and brain bam files

nohup samtools merge Adipose_Breast.merged.bam Adipose Breast &
nohup samtools merge Liver_Brain.merged.bam Liver Brain &

# finally, create index files for the merged bam files

nohup samtools index Adipose_Breast.merged.bam &
nohup samtools index Liver_Brain.merged.bam &
