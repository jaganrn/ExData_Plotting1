# Exploratory Data Analysis Course Project
#
# This program demonstrates the generation of Histogram and saving it as PNG file
# script named plot1.R, does the following:
#
# 1. Reads the data from the file only for 2007-02-01 & 2007-02-02
# 2. Sets the lables as they were skipped while reading the data
# 3. Plots 2x2 graphs and saves it as plot4.png


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

# construct the date object
data$dateTime <-strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# convert to numeric to handle data with ?
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# plot the basic line graph as PNG with appropriate labels
png("plot4.png", width=480, height=480) 

# create 2x2 frames
par(mfrow=c(2,2))


#graph 1
plot(data$dateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power") 

#graph 2
plot(data$dateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage") 

#graph 3
plot(data$dateTime, data$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black") 
points(data$dateTime, data$Sub_metering_2, type="l", col="red")
points(data$dateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#graph 4
plot(data$dateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power") 

dev.off()  # close the devide

