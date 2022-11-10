# samtools index all bam files

mkdir Activity_4

cd Activity_4

nohup cp -R /scratch/Illumina-Human-Body-Map-BAMS . &

cd Illumina-Human-Body-Map-BAMS

for file in *.bam
do 
	nohup samtools index $file &
done
