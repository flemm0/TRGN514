setwd("~/Desktop/TRGN514/RStuff/Week9")

#getwd()

# read in copy number variant data
CNV <- read.table("~/Desktop/TRGN514/RStuff/Week7/hm3_cnv_submission.txt", header = TRUE, sep = "\t")

# remove chromosome number, start pos, and end pos columns
CNV <- CNV[-c(2:4)]

# set cnv ids as index and remove cnv id row to create matrix
row.names(CNV) <- CNV$cnp_id
CNV <- CNV[-c(1)]

# transpose so sample id is row and cnp id is column
CNV <- t(CNV)

# convert back to data frame
CNV <- as.data.frame(CNV)
head(CNV)[0:5] # check to see if data looks correct

# impute missing values
CNV[is.na(CNV)] <- 2
sum(is.na(CNV)) # check

# normalize data by scaling to mean of 0 and standard deviation of +1/-1
CNV <- scale(CNV)
head(CNV, n = 3)



#### Computing Euclidean Distance and Pearson Correlation

# Base R's distance method for euclidean distance
dist.eucl <- dist(CNV, method = "euclidean")

if(!require("factoextra")) { install.packages("factoextra") }
library("factoextra")

# factoextra::get_dist() for pearson correlation
dist.cor <- get_dist(CNV, method = "pearson")

# calculate optimal number of clusters for case of performing partitioning clustering
fviz_nbclust(CNV, kmeans, method = "silhouette") # 3 clusters optimal (same as PCA)


## will be doing hierarchical clustering, not partitioning clustering in this activity

## two types of hierarchical clustering: agglomerative and divisive
## agglomerative considers each cluster its own leaf and merges up to one big cluster, and divisive works the opposite way


# use linkage function to take the distance matrix and group pairs into clusters based on similarity
# ward minimizes total within-cluster variance
# complete defines dist between two clusters as max value of all pairwise distances between elements in the two clusters
hclust.ward.eucl <- hclust(d = dist.eucl, method = "ward.D2") 
hclust.ward.cor <- hclust(d = dist.cor, method = "ward.D2")
hclust.complete.eucl <- hclust(d = dist.eucl, method = "complete")
hclust.complete.cor <- hclust(d = dist.cor, method = "complete")


# plot dendrograms
plot(hclust.ward.eucl, labels = FALSE, main = "Euclidian - Ward's")
plot(hclust.ward.cor, labels = FALSE, main = "Pearson's - Ward's")
plot(hclust.complete.eucl, labels = FALSE, main = "Euclidian - Complete")
plot(hclust.complete.cor, labels = FALSE, main = "Pearson's - Complete")

# plot colored dendrograms
fviz_dend(hclust.ward.eucl, k = 4,
          labels = FALSE,
          k_colors = c("#FCFF74", "#74E4FF", "#74FF7F", "#EAFF74"),
          color_labels_by_k = TRUE,
          rect = TRUE)
