setwd("~/Desktop/TRGN514/RStuff")

install.packages("devtools")

require(devtools)

install_version("qqman", version = "0.1.2", repos = "http://cran.us.rproject.org")

library("qqman")

str(gwasResults)

head(gwasResults)

tail(gwasResults)


vignette("qqman")

#Checkpoint 1. From the vignette, it looks like there should be 5 observations, or columns, in the gwasResults dataset. Both the instructor and I have only 4 columns, missing the zcore column.


as.data.frame(table(gwasResults$CHR))

manhattan(gwasResults)
