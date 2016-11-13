setwd("D:\\Coursera\\ExploratoryDataAnalysis")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##str(NEI)
##str(SCC)
##names(SCC)
##unique(SCC$EI.Sector)
##length(grep("[Cc]oal", SCC$EI.Sector ))
##head(NEI)

## Problem 4
library(dplyr)
library(ggplot2)
Sector2Test <- c("Fuel Comb - Electric Generation - Coal"
                ,"Fuel Comb - Industrial Boilers, ICEs - Coal"
                ,"Fuel Comb - Comm/Institutional - Coal")
SCC2Test <- subset(SCC,EI.Sector %in% Sector2Test)
coal4NEI <- subset(NEI,NEI$SCC %in% SCC2Test$SCC)
groupP25    <- 
    group_by(coal4NEI, year )

sumP25=summarize(groupP25,Total_Emissions=sum(Emissions,na.rm=TRUE))
fileName="plot4.png"
png(filename = fileName,
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

ggplot(sumP25,
       aes(x=year,
           y=Total_Emissions))+
    geom_line()

dev.off()
