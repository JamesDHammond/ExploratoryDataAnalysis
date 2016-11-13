setwd("D:\\Coursera\\ExploratoryDataAnalysis")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
str(SCC)
unique(NEI$Pollutant)

## Problem 1
library(dplyr)
year2Test <- c(1999,2002,2005,2008)
years4NEI <- subset(NEI,NEI$year %in% year2Test)
typeof(years4NEI)
str(years4NEI)
unique(years4NEI$year)
groupP25    <- 
    group_by(years4NEI, year)
sumP25=summarize(groupP25,Total_Emissions=sum(Emissions,na.rm=TRUE))
yr=unique(sumP25$year)
fileName="plot1.png"
png(filename = fileName,
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
plot(yr,sumP25$Total_Emissions,pch=19,xlab="Year",ylab="Total Emissions")
dev.off()
