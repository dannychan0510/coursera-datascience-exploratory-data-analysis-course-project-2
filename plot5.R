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


# Question 5 --------------------------------------------------------------

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# subsetting data for only fips = 24510
NEI.24510 <- NEI[which(NEI$fips == "24510")]

# aggregating total emissions by year, and only for On Road
total.emissions <- as.data.table(with(NEI.24510, aggregate(Emissions, by = list(year, type), sum)))

# renaming columns of total.emissions
names(total.emissions) <- c("Year", "Type", "Emissions")

# subsetting total.emissions for only ON-ROAD (which consist of emissions for all motor vehicles. Source: https://www.tceq.texas.gov/airquality/areasource/Sources_of_Air_Pollution.html)
total.emissions.Onroad <- total.emissions[which(total.emissions$Type == "ON-ROAD")]

# opening the PNG device to plot chart for question 1
png(filename = "plot5.png", width = 500, height = 500, units = "px")

# plotting total.emissions using the base package
ggplot(total.emissions.Onroad, aes(Year, Emissions, colour = Type)) + geom_line() + geom_point() + ggtitle('Total Emissions of Motor Vehicle Sources\nBaltimore City, Maryland') 

# closing the PNG device
dev.off()



