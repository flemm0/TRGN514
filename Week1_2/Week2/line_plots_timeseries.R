setwd('~/Desktop/TRGN514/RStuff')

#Read in tab-separated .txt file
##timeseries <- read.table('~/Desktop/TRGN514/RStuff/series_all_merged.txt', header=TRUE)
timeseries <- read.table('~/Desktop/TRGN514/RStuff/series_all_merged.txt', header=TRUE, sep='\t')


#Generate individual plots for each of the four columns
plot(timeseries$half_seconds, timeseries$series1_bpm, type="l")

plot(timeseries$half_seconds, timeseries$series2_bpm, type="l")

plot(timeseries$half_seconds, timeseries$series3_bpm, type="l")

plot(timeseries$half_seconds, timeseries$series4_bpm, type="l")


#Plot all four lines onto single plot

##First figure out what the min and max values are to use for the y lims
max(timeseries$series1_bpm, timeseries$series2_bpm, timeseries$series3_bpm, timeseries$series4_bpm, na.rm=TRUE)
#returns 106.756

min(timeseries$series1_bpm, timeseries$series2_bpm, timeseries$series3_bpm, timeseries$series4_bpm, na.rm=TRUE)
#returns 52.0833

##Will use 107 as the ylim max and 52 as the ylim min

#Generate empty plot
plot(0, ylim=c(52,107), xlim=c(0,1800), ylab="BPM", xlab="Half Seconds", main="Time Series of Heart Rates", type="n")

#Add lines
lines(timeseries$series1_bpm, col="red")
lines(timeseries$series2_bpm, col="purple")
lines(timeseries$series3_bpm, col="blue")
lines(timeseries$series4_bpm, col="green")
