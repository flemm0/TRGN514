## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(eval=TRUE)

## ----loadLibs, message=FALSE, warning=FALSE-----------------------------------
library(IONiseR)
library(ggplot2)
library(gridExtra)

## ----readData, eval=FALSE-----------------------------------------------------
#  fast5files <- list.files(path = "/path/to/data/", pattern = ".fast5$", full.names = TRUE)
#  example.summary <- readFast5Summary( fast5files )

## ----loadData-----------------------------------------------------------------
library(minionSummaryData)
data(s.typhi.rep1)

## ----exampleData--------------------------------------------------------------
s.typhi.rep1

## ----extractData1, warning=FALSE----------------------------------------------
baseCalled(s.typhi.rep1)

## ----extractData2, warning=FALSE----------------------------------------------
baseCalled(s.typhi.rep1[1:2])

## ----summaryPlots1, fig.height=5, fig.width=12.5, dev='png', warning=FALSE----
p1 <- plotReadAccumulation(s.typhi.rep1)
p2 <- plotActiveChannels(s.typhi.rep1)
grid.arrange(p1, p2, ncol = 2)

## ----readCategories, fig.height=5, fig.width=12.5, dev='png', warning=FALSE----
p1 <- plotReadCategoryCounts(s.typhi.rep1)
p2 <- plotReadCategoryQuals(s.typhi.rep1)
grid.arrange(p1, p2, ncol = 2)

## ----summaryPlots2, fig.height=5, fig.width=12.5, dev='png', warning=FALSE----
p1 <- plotEventRate(s.typhi.rep1)
p2 <- plotBaseProductionRate(s.typhi.rep1)
grid.arrange(p1, p2, ncol = 2)

## ----numReads, fig.height=4.8, fig.width=14.5, dev='png', warning=FALSE-------
p1 <- layoutPlot(s.typhi.rep1, attribute = "nreads")
p2 <- layoutPlot(s.typhi.rep1, attribute = "kb")
grid.arrange(p1, p2, ncol = 2)

## ----heatmapExample, fig.height=4.8, fig.width=14.5, dev='png', message=FALSE, warning=FALSE----
library(dplyr)

read_count_2D <- baseCalled(s.typhi.rep1) %>% ## start with base called reads
  filter(strand == 'template') %>% ## keep template so we don't count things twice
  left_join(readInfo(s.typhi.rep1), by = 'id') %>% ## channel stored in @readInfo slot, match by id column
  group_by(channel) %>% ## group according to channel
  summarise(d2_count = length(which(full_2D == TRUE)), ## count those with full 2D status
            d2_prop = length(which(full_2D == TRUE)) / n()) ## divide by total count of reads from channel

## plot side-by-side
p1 <- channelHeatmap(read_count_2D, zValue = 'd2_count')
p2 <- channelHeatmap(read_count_2D, zValue = 'd2_prop')
grid.arrange(p1, p2, ncol = 2)

## ----channelActivity, fig.height=4.8, fig.width=10, dev='png', message=FALSE, warning=FALSE----
data(s.typhi.rep3, package = 'minionSummaryData')
## we will plot the median event signal for each read on z-axis
z_scale = select(eventData(s.typhi.rep3), id, median_signal)
channelActivityPlot( s.typhi.rep3, zScale = z_scale )

## ----pentamerCorrelation, fig.height=5, fig.width=6.5, dev='png', message=FALSE, warning=FALSE----
plotKmerFrequencyCorrelation( s.typhi.rep3, only2D = FALSE )

## ----combinedplots, eval=FALSE------------------------------------------------
#  p1 <- channelActivityPlot(dat, select(eventData(dat), id, median_signal))
#  p2 <- plotKmerFrequencyCorrelation(dat)
#  grid.arrange(p1, p2, ncol = 2)

## ----writefastq, message=FALSE------------------------------------------------
library(ShortRead)
writeFastq( fastq( s.typhi.rep1 ), file = tempfile() )

## ----writefastq2--------------------------------------------------------------
writeFastq( fastq2D( s.typhi.rep1 ), file = tempfile() )

## ----fast5toFastq-------------------------------------------------------------
fast5files <- system.file('extdata', 'example.fast5', package = "IONiseR")
fast5toFastq(files = fast5files, fileName = "test", outputDir = tempdir(), 
             strand = 'all', ncores = 1)
list.files(path = tempdir(), pattern = "*.fq.gz$")

