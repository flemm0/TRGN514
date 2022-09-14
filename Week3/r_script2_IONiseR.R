setwd("~/Desktop/TRGN514/RStuff/Week3")

#getwd()

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("IONiseR")

vignette("IONiseR")
browseVignettes("IONiseR")


# IONiseR is a package that lets you visualize and perform quality checks on sequencing experiments done on the Oxford Nanopore sequencers.
# These sequencers work by measuring change in electrical signal instead of fluorescence.

library(IONiseR)


# The sequencer outputs data in FAST5 file format, which contain sequences, raw signal, and other metadata.

library(minionSummaryData)
library(ggplot2)
library(gridExtra)


data(s.typhi.rep1)

s.typhi.rep1


# Print information about reads
readInfo(s.typhi.rep1) # file name, channel, pass/fail status


# Once the data have been read into a summary object, you can plot your data to visualize how your sequencer performed over time during your experiment
p1 <- plotReadAccumulation(s.typhi.rep1)
p2 <- plotActiveChannels(s.typhi.rep1)
grid.arrange(p1, p2, ncol=2)


# Oxford Nanopore sequencing reads both template and complement strands, giving higher confidence in what the consensus sequence is (2D read) 

# Visualize the proportion of each type of read, as well as the quality scores of each type of read
p1 <- plotReadCategoryCounts(s.typhi.rep1)
p2 <- plotReadCategoryQuals(s.typhi.rep1)
grid.arrange(p1, p2, ncol = 2)


# Flow Cell Layout plots

p1 <- layoutPlot(s.typhi.rep1, attribute = "nreads") # plot total number of reads per channel
p2 <- layoutPlot(s.typhi.rep1, attribute = "kb") # plot cumulative number of bases read by a channel
grid.arrange(p1, p2, ncol = 2)


# Write out to a fastq file for further analysis
library(ShortRead)
writeFastq( fastq( s.typhi.rep1 ), file = tempfile() )


