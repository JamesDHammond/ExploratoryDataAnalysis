## Project 1 - Exploratory Data Analysis / Plot 2
## Load any necessary libraries
library(data.table)
library(lubridate)

## Load the data set into a data table
workingDir      <- 
    "D:\\Coursera\\ExploratoryDataAnalysis\\ExData_Plotting1-master"
inputFile       <- 
    "D:\\Coursera\\ExploratoryDataAnalysis\\ExData_Plotting1-master\\household_power_consumption.txt"
setwd(workingDir)
hshldPowerData  <-fread(inputFile)
## Verified all rows got loaded
## print(nrow(hshldPowerData))

## Convert Dates and Times to Date and Time object vectors
dateTimeVector  <- 
    with(hshldPowerData, strptime(paste(Date, Time, sep=":"),
                                  format="%d/%m/%Y:%H:%M:%S"))

## Remove the character Date and Time columns and replace with dateTimeVector
hshldPowerData  <- hshldPowerData[,Date := NULL]
hshldPowerData  <- hshldPowerData[,Time := NULL]
hshldPowerData  <- cbind(Date_Time=dateTimeVector,hshldPowerData)
#head(hshldPowerData)

## Generate the subset of data from which the graphs will be generated
graphData       <- 
    subset(hshldPowerData, 
              Date_Time >= ymd("2007-02-01") & 
              Date_Time < ymd("2007-02-03"))
## Open the png device/file
png(filename = "plot2.png",
    width = 480, height = 480, units = "px",
    bg = "white")
## Create the base plot
plot( graphData$Date_Time
     ,as.numeric(graphData$Global_active_power)
     ,col="black"
     ,xlab=""
     ,ylab="Global Active Power (kilowatts)"
     ,type = "l" )
## close the device
dev.off()
     
     