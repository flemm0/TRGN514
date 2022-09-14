setwd("~/Desktop/TRGN514/RStuff")

install.packages("devtools")

require(devtools)

install_version("qqman", version = "0.1.2", repos = "http://cran.us.r-project.org")

library("qqman")

str(gwasResults)

head(gwasResults)

tail(gwasResults)


vignette("qqman")

#Checkpoint 1. From the vignette, it looks like there should be 5 observations, or columns, in the gwasResults dataset. Both the instructor and I have only 4 columns, missing the zcore column.


as.data.frame(table(gwasResults$CHR))

manhattan(gwasResults)

manhattan(gwasResults, main = "Manhattan Plot", ylim = c(0, 10), cex = 0.6, cex.axis = 0.9, col = c("blue4", "orange3"), suggestiveline = F, genomewideline = F, chrlabs = c(1:20, "P", "Q"))


manhattan(subset(gwasResults, CHR == 1))
#My plot resembles my instructor's plot.

##The vignette's graph has points scattered around the plot, but my plot has points on a straight line through the x-axis. Additionally, the ticks on the x-axis seem to be in Mb ranging from -1.0 to 1.0, whereas the x-axis in the vignette plot seem to be in bases, ranging from 0 to 1500.


str(snpsOfInterest) #can be an user-generated input of any list of SNPs

manhattan(subset(gwasResults, CHR == 3), highlight = snpsOfInterest, xlim = c(200, 500), main = "Chr 3")
#Again, my plot resembles that of my instructor's instead of that of the vignette. I notice the same issue with the scale of the x-axis (which is in Mb in my plot) being different than in the vignette, which is likely in base pairs.

install.packages("qqman")

library(qqman)

manhattan(subset(gwasResults, CHR == 1))
#Plot looks correct now.


manhattan(subset(gwasResults, CHR == 3), highlight = snpsOfInterest, xlim = c(200, 500), main = "Chr 3")
#Plot looks correct.

manhattan(gwasResults, highlight = snpsOfInterest)

manhattan(gwasResults, annotatePval = 0.01) #labels top SNP per chromosome that exceeds p-value threshold (default action)

manhattan(gwasResults, annotatePval = 0.005, annotateTop = FALSE) #excludes top SNP on each chromosome
