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


# Question 6 --------------------------------------------------------------

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# aggregating total emissions by year, and only for On Road
total.emissions <- as.data.table(with(NEI, aggregate(Emissions, by = list(year, fips, type), sum)))

# renaming columns of total.emissions
names(total.emissions) <- c("Year", "FIPS", "Type", "Emissions")

# subsetting total.emissions for only ON-ROAD (which consist of emissions for all motor vehicles. Source: https://www.tceq.texas.gov/airquality/areasource/Sources_of_Air_Pollution.html)
total.emissions.Onroad <- total.emissions[which(total.emissions$Type == "ON-ROAD" & (total.emissions$FIPS == "24510" | total.emissions$FIPS == "06037"))]

# opening the PNG device to plot chart for question 1
png(filename = "plot6.png", width = 500, height = 500, units = "px")

# plotting total.emissions using the base package
ggplot(total.emissions.Onroad, aes(Year, Emissions, colour = FIPS)) + geom_line() + geom_point() + geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1), show_guide = FALSE) + ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + scale_color_manual("Legend Title\n", labels = c("Los Angeles County, California", "Baltimore City, Maryland"), values = c("blue", "red"))

# closing the PNG device
dev.off()




