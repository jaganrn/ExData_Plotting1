# Exploratory Data Analysis Course Project
#
# This program demonstrates the generation of Histogram and saving it as PNG file
# script named plot1.R, does the following:
#
# 1. Reads the data from the file only for 2007-02-01 & 2007-02-02
# 2. Sets the lables as they were skipped while reading the data
# 3. Generates the histogram and saves it as plot1.png


# common environment setup
library(data.table)  # load the data.table library
setwd("C:/usr/jagan/DataScience/ExploratoryDataAnalysis/Week1/Project/ExData_Plotting1")  # set the working directory


# read the input data only for the 2 days so that operation is faster. 
# This is done by skipping all the records until 2007-01-31 and reading only 2880 records to cover 2 days
dataFile <- paste(getwd(), "/household_power_consumption.txt", sep="")
data     <- read.table(dataFile, header=FALSE, sep=';', skip=grep("^31/1/2007;23:59:00", readLines(dataFile)), nrows=2880)

# read the column headers and set them as previous read operation skipped all the records until required dates
columnHeaders  <- read.table(dataFile, sep=';', header=TRUE, nrows=1)  # read ONLY 1 record
colnames(data) <- colnames(columnHeaders)

# plot the histogram as PNG
png("plot1.png", width=480, height=480)
# convert to numeric to handle data with ?
data$Global_active_power <- as.numeric(data$Global_active_power)
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)") 
dev.off()  # close the devide

