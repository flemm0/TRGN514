setwd("~/Desktop/TRGN514/RStuff/Week7")

#getwd()

# install and load ggfortify
if (!require("ggfortify")) { #returns TRUE if the package is available, and FALSE if the package is not
  install.packages("ggfortify")
}
library(ggfortify)


# read in data
CNV <- read.table("./hm3_cnv_submission.txt", header = TRUE, sep = "\t")
CEU <- read.table("./CEU_samples.txt", header = FALSE)
CHB <- read.table("./CHB_samples.txt", header = FALSE)
YRI <- read.table("./YRI_samples.txt", header = FALSE)
JPT <- read.table("./JPT_samples.txt", header = FALSE)

# prepare data for pca
CNV <- CNV[-c(2:4)] #remove unnecessary cols from CNV data
row.names(CNV) <- CNV$cnp_id #set indexes to cnv ids
CNV <- CNV[-c(1)] #remove column used for index

