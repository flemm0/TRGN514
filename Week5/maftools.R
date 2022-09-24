#Install BiocManager if needed
if(!require("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")
}

#Install maftools through BiocManager and load
BiocManager::install("maftools")
library(maftools)

#Try to list TCGA cancer types through maftools vignette
##Does not contain all of the TCGA cancer types
list.files(system.file('extdata', package = 'mfatools'))

#Load in cancer types from GitHub repo
install.packages("devtools")
devtools::install_github(repo = "PoisonAlien/TCGAmutations")

library("TCGAmutations")

tcga_available()

#Load Lymphoid Neoplasm Diffuse Large B-cell Lymphoma (DLBC) MAF data from TCGA
dlbc <- tcga_load(study = "DLBC")

#https://doi.org/10.1016/j.cels.2018.03.002 

#Run basic summary of MAF file
dlbc


#Plot MAF summary
plot.new()
plotmafSummary(maf = dlbc, rmOutlier = TRUE, addStat = "median", dashboard = TRUE, titvRaw = FALSE)


#Draw oncoplots
plot.new()
oncoplot(maf = dlbc, top = 15, fontSize = 0.6, legendFontSize = 0.8)

#Create protein plots
plotProtein(gene = "IGLL5", refSeqID = 'NM_001178126')

###################################################################

#Load Acute Myeloid Leukemia (LAML) MAF data from TCGA
laml <- tcga_load(study = "LAML")

#View summary
laml

#Plot MAF summary
plot.new()
plotmafSummary(maf = laml, rmOutlier = TRUE, addStat = "median", dashboard = TRUE)

#Draw oncoplots
plot.new()
oncoplot(maf = laml, top = 15, fontSize = 0.6)

#Create protein plots
plotProtein(gene = "BPIFC", legendTxtSize = 0.05)
