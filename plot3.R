setwd("D:\\Coursera\\ExploratoryDataAnalysis")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Problem 3
library(dplyr)
library(ggplot2)

# Baltimore City data
fips2Test <- c("24510")
fips4NEI <- subset(NEI,NEI$fips %in% fips2Test)
typeof(fips4NEI)
str(fips4NEI)
unique(fips4NEI$fips)
unique(fips4NEI$year)
groupP25    <- 
    group_by(fips4NEI, year, type )
sumP25=summarize(groupP25,Total_Emissions=sum(Emissions,na.rm=TRUE))
yr=unique(sumP25$year)
fileName="plot3.png"
png(filename = fileName,
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

ggplot(sumP25,
       aes(x=year,
           y=Total_Emissions,
           group=type,
           color=type))+
    geom_line()

dev.off()
