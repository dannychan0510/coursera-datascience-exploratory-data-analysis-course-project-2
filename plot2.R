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


# Question 2  --------------------------------------------------------------

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# subsetting data for only fips = 24510
NEI.24510 <- NEI[which(NEI$fips == "24510")]

# aggregating total emissions by year
total.emissions <- as.data.table(with(NEI.24510, aggregate(Emissions, by = list(year), sum)))

# opening the PNG device to plot chart for question 1
png(filename = "plot2.png", width = 500, height = 500, units = "px")

# plotting total.emissions using the base package
plot(total.emissions, type = "b", main = "Total Emissions from PM2.5 \nBaltimore City, Maryland", xlab = "Year", ylab = "Amount of PM2.5 emitted, in tons", col = "blue")

# closing the PNG device
dev.off()

