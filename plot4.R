## Project 1 - Exploratory Data Analysis / Plot 4
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
png(filename = "plot4.png",
    width = 480, height = 480, units = "px",
    bg = "white")
## Set up for 4 plots on the one device/file
par(mfcol=c(2,2))

## Create the plot at the top left
plot( graphData$Date_Time
      ,as.numeric(graphData$Global_active_power)
      ,col="black"
      ,xlab=""
      ,ylab="Global Active Power (kilowatts)"
      ,type = "l" )

## Create the plot at the bottom left
plot( graphData$Date_Time
     ,as.numeric(graphData$Sub_metering_1)
     ,col="black"
     ,xlab=""
     ,ylab="Energy sub metering"
     ,type = "l" )
lines(graphData$Date_Time
     ,as.numeric(graphData$Sub_metering_2)
     ,col="red")
lines(graphData$Date_Time
      ,as.numeric(graphData$Sub_metering_3)
      ,col="blue")
## add any additional legends and labels
legend("topright"
       ,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=c(1,1,1)
       ,lwd=c(2,2,2)
       ,col=c("black", "red", "blue"))

## Create the plot at the top right
plot( graphData$Date_Time
      ,as.numeric(graphData$Voltage)
      ,col="black"
      ,xlab=""
      ,ylab="Voltage"
      ,type = "l" )

## Create the plot at the bottom right
plot( graphData$Date_Time
      ,as.numeric(graphData$Global_reactive_power)
      ,col="black"
      ,xlab=""
      ,ylab="Global_Reactive_Power"
      ,type = "l" )


## close the device
dev.off()
     
     