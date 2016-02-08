# Plot2.R Program for Exploratory Data Analysis Project Week 1 - 
## generating Plot 2
#  Danny Kugler

# check if the required package is installed or not
if (!("lubridate" %in% rownames(installed.packages())) ) {
  install.packages("lubridate")
} 

## Load required library 'lubridate'
library(lubridate)

# Read in data - could just screen out the data as it is read it but haven't done that trick
#   in a long time so doing the brute force method and reading in the whole data set
#   even though it is >20k records
test.data<-read.table("c:/users/Danny/Google Drive/Computing/DataScience/JohnsHopkinsCoursera/Exploratory Data Analysis/Week 1/household_power_consumption.txt", header= TRUE, sep=";", na.strings="?")
# quick data checks
dim(test.data) 
head(test.data)

# Created DateTime variable for Time Series Plotting
test.data$DateTime <- strptime(paste(test.data$Date, test.data$Time), "%d/%m/%Y %H:%M:%S")
class(test.data$DateTime)
# change date from character representation of dates to actual date variable
test.data$Date <- as.Date(strptime(test.data$Date, "%d/%m/%Y"))
start.date<-ymd("2007-02-01")
end.date<-ymd("2007-02-02")
# Generate Interval of Dates to subset data for graphs
test.interv <- interval(start.date,end.date)
# Generate intersection of interval of interest and data to create subset indicator
dataofinterest<-test.data$Date %within% test.interv
# Subset data based on subset indicator and save in graph.data
graph.data<-test.data[dataofinterest,]
# Checks on data
head(graph.data)
tail(graph.data)
dim(graph.data)
# Remove overall data set test.data since don't neet anymore.
rm(test.data)

# Create PNG file for Plot2 with appropriate image dimensions
png("plot2.png", width=480, height=480)
# Generate graph
with(graph.data, plot(DateTime, Global_active_power, type="l", xlab="", 
                      ylab="Global Active Power (kilowatts)"))
dev.off()  # Close file