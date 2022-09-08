setwd('~/Desktop/TRGN514/RStuff')

BPM <- read.table('~/Desktop/TRGN514/RStuff/heartrates.txt', header=TRUE)
#BPM #view table

hist(BPM$Heart_Rate_bp)

#?hist #view options for hist function

hist(BPM$Heart_Rate_bp, breaks=4, col='purple', main="Scientists' Heart Rates", xlab="BPM")
