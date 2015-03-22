# Coursera Data Science Specialisation: Exploratory Data Analysis Course Project 2

# load libraries needed
library(data.table)
library(ggplot2)

# setting up working directory and loading data
setwd("~/Documents/GitHub/coursera-datascience-exploratory-data-analysis-course-project-2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# convert NEI and SCC into data.table objects
NEI <- as.data.table(NEI)
SCC <- as.data.table(SCC)


# Question 3 --------------------------------------------------------------

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# subsetting data for only fips = 24510
NEI.24510 <- NEI[which(NEI$fips == "24510")]

# aggregating total emissions by year
total.emissions <- as.data.table(with(NEI.24510, aggregate(Emissions, by = list(year, type), sum)))

# renaming columns of total.emissions
names(total.emissions) <- c("Year", "Type", "Emissions")

# opening the PNG device to plot chart for question 1
png(filename = "plot3.png", width = 500, height = 500, units = "px")

# plotting total.emissions using the base package
ggplot(total.emissions, aes(Year, Emissions, colour = Type)) + geom_line() + geom_point() + ggtitle('Total Emissions of Motor Vehicle Sources\nBaltimore City, by type') 

# closing the PNG device
dev.off()


