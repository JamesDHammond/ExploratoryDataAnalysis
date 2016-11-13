setwd("D:\\Coursera\\ExploratoryDataAnalysis")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##str(NEI)
##str(SCC)
##names(SCC)
unique(SCC$EI.Sector)
##length(grep("[Cc]oal", SCC$EI.Sector ))
##head(NEI)

## Problem 5
library(dplyr)
library(ggplot2)
# Note that I am including on road and off road vehicles as 
# well as aircraft, locomotives, and marine vehicles
Sector2Test <- c("Mobile - On-Road Gasoline Light Duty Vehicles"
                ,"Mobile - On-Road Diesel Light Duty Vehicles"
                ,"Mobile - Non-Road Equipment - Gasoline"
                ,"Mobile - Non-Road Equipment - Diesel"
                ,"Mobile - Commercial Marine Vessels"
                ,"Mobile - On-Road Gasoline Heavy Duty Vehicles"
                ,"Mobile - On-Road Diesel Heavy Duty Vehicles"
                ,"Mobile - Non-Road Equipment - Other"
                ,"Mobile - Aircraft"
                ,"Mobile - Locomotives")

SCC2Test <- subset(SCC,EI.Sector %in% Sector2Test)$SCC

# Baltimore City data
fips2Test <- c("24510")

BaltimoreCars4NEI <- subset(NEI,NEI$SCC %in% SCC2Test & NEI$fips %in% fips2Test)
groupP25    <- 
    group_by(BaltimoreCars4NEI, year )

sumP25=summarize(groupP25,Total_Emissions=sum(Emissions,na.rm=TRUE))
fileName="plot5.png"
png(filename = fileName,
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

ggplot(sumP25,
       aes(x=year,
           y=Total_Emissions))+
    geom_line()

dev.off()
