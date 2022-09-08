setwd("~/Desktop/TRGN514/RStuff/Week3")

#getwd()

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("IONiseR")

vignette("IONiseR")
browseVignettes("IONiseR")


#The FAST5 format is the standard sequencing output for Oxford Nanopore sequencers such as the MinION. It is based on the hierarchical data format HDF5 format which enables storage of large and comples data. In contrast to fasta and fastq files a FAST5 file is binary and can not be opened with a normal text editor.

#Data stored in nanopore FAST5 files can contain the sequence of a read in fastq format (after basecalling), the raw signal of the pore as well as several log files and other information.


library(minionSummaryData)
data(s.typhi.rep1)

s.typhi.rep1

#Print information about individual reads
readInfo(s.typhi.rep1)

baseCalled(s.typhi.rep1)

# Once the data have been read into a summary object, you can plot your data to visualize how your sequencer performed over time during your experiment
p1 <- plotReadAccumulation(s.typhi.rep1)
p2 <- plotActiveChannels(s.typhi.rep1)
grid.arrange(p1, p2, ncol=2)


