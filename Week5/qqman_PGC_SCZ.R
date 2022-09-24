setwd("~/Desktop/TRGN514/RStuff/Week5")

library(qqman)

SCZ <- read.table("~/Desktop/TRGN514/RStuff/Week5/daner_PGC_SCZ52_0513a.hq2", header = TRUE, sep = "\t")

str(SCZ)

levels(SCZ$CHR) #returns null because the chromosome column is already a list of ints, not a character list 

unique(SCZ$CHR)


SCZ$CHR <- gsub("chr","",SCZ$CHR)
SCZ$CHR <- gsub("X","23",SCZ$CHR)

is.integer(SCZ$CHR)
SCZ$CHR <- as.integer(SCZ$CHR)
is.integer(SCZ$CHR)

0.05/10172956

#creating manhanttan plot
manhattan(SCZ,
          suggestiveline = FALSE,
          genomewideline = -log10(4.915e-09),
          cex = 0.35,
          main = "PGC SCZ GWAS")

manhattan(subset(SCZ, CHR == 6),
          suggestiveline = FALSE,
          genomewideline = -log10(4.915e-09),
          cex = 0.35,
          main = " PGC SCZ GWAS Chr 6")


# citation
#Turner, (2018). qqman: an R package for visualizing GWAS results using Q-Q and manhattan plots. Journal of Open Source Software, 3(25), 731, https://doi.org/10.21105/joss.00731.
