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

# since we want the population code for a given individual to be its own column for labeling the data,
## we will have to transpose the matrix so that CNV ID numbers are columns and individual samples are indexes
CNV <- t(CNV)

CNV <- as.data.frame(CNV) #convert to data frame
CNV$Samples <- rownames(CNV) #create new column with sample IDs
CNV$Group <- NA #create column to hold population code

# fill Group column with corresponding population code for individual sample
CNV$Group <- ifelse(CNV$Samples %in% CEU$V1, "CEU",
                    ifelse(CNV$Samples %in% CHB$V1, "CHB",
                           ifelse(CNV$Samples %in% JPT$V1, "JPT",
                                  ifelse(CNV$Samples %in% YRI$V1, "YRI", "Unknown"))))

cnv.data <- CNV[c(1:856)] #select only CNV data
cnv.data[is.na(cnv.data)] <- 2 #impute NA with 2, the assumed normal copy number variant

# plot

autoplot(prcomp(cnv.data))

autoplot(prcomp(cnv.data), data = CNV, colour = "Group")

CNV2 <- subset(CNV, CNV$Group != "Unknown")
subset.cnv.data <- CNV2[c(1:856)]
subset.cnv.data[is.na(subset.cnv.data)] <- 2
autoplot(prcomp(subset.cnv.data), data = CNV2, colour = "Group")

# investigate how much of the variance in the data is explained by each of the principal components
PCA1 <- prcomp(subset.cnv.data)
summary(PCA1)

# write to table
summary <- summary(PCA1)
write.table(summary$importance, file = "./HapMap_PCA_summary.txt", sep = "\t", col.names = NA)
