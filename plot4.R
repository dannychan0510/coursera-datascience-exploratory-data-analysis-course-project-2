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


# Question 4 --------------------------------------------------------------

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# obtaining SCC codes for coal combustion related emissions, and subsetting NEI cases relating to only coal combustion
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
coalCombustionSCC <- SCC[coalCombustion,]$SCC
coalCombustionNEI <- NEI[NEI$SCC %in% coalCombustionSCC,]

# aggregating total emissions by year
total.emissions <- as.data.table(with(coalCombustionNEI, aggregate(Emissions, by = list(year), sum)))

# renaming columns of total.emissions
names(total.emissions) <- c("Year", "Emissions")

# opening the PNG device to plot chart for question 1
png(filename = "plot4.png", width = 500, height = 500, units = "px")

# plotting total.emissions using the base package
ggplot(total.emissions, aes(Year, Emissions)) + geom_line() + geom_point() + ggtitle('Total Emissions from coal combustion-related sources in the US') 

# closing the PNG device
dev.off()



