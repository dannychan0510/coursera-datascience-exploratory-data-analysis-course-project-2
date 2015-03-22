# Coursera Data Science Specialisation: Exploratory Data Analysis Course Project 2

# load libraries needed
library(data.table)

# setting up working directory and loading data
setwd("~/Documents/GitHub/coursera-datascience-exploratory-data-analysis-course-project-2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# convert NEI and SCC into data.table objects
NEI <- as.data.table(NEI)
SCC <- as.data.table(SCC)


# Question 1 --------------------------------------------------------------

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# aggregating total emissions by year
total.emissions <- with(NEI, aggregate(Emissions, by = list(year), sum))

# opening the PNG device to plot chart for question 1
png(filename = "plot1.png", width = 500, height = 500, units = "px")

# plotting total.emissions using the base package
plot(total.emissions, type = "b", main = "Total Emissions from PM2.5", xlab = "Year", ylab = "Amount of PM2.5 emitted, in tons", col = "blue")

# closing the PNG device
dev.off()
