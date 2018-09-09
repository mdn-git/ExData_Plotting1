###############################################################################################################
###                     Exploratory Data Analysis: Week 1 Project                                           ###
###                                     PLOT3.R                                                             ###
###############################################################################################################

#LIBS
library(data.table)

###############################################################################################################
###     FILE IMPORT                                                                                          ##
###############################################################################################################

# set the zipfile properties
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipName <- "ELETRIC_POWER_CONSUMPTION.zip"

# Verify if the .zip file exists in the working directory
if (!file.exists(zipName)) {
  
  # Download as binary
  download.file(fileUrl, zipName, mode = "wb")
  
}

#extract the zip file 
unzip(zipName)

###############################################################################################################
###     READ FILES                                                                                           ##
###############################################################################################################

#read the data
dt_data <- fread("household_power_consumption.txt")

#conversions
dt_data$Date <- as.Date(dt_data$Date, format = "%d/%m/%Y")

# ? will be replaced as NAs - supress the Warning
suppressWarnings(dt_data$Global_active_power <- as.numeric(dt_data$Global_active_power))
suppressWarnings(dt_data$Sub_metering_1 <- as.numeric(dt_data$Sub_metering_1))
suppressWarnings(dt_data$Sub_metering_2 <- as.numeric(dt_data$Sub_metering_2))
suppressWarnings(dt_data$Sub_metering_3 <- as.numeric(dt_data$Sub_metering_3))

#subset
dt_data_subset <- dt_data[Date >= "2007-02-01" & Date <= "2007-02-02"]

#create a datetime column
DateTime <- strptime(paste(dt_data_subset$Date, dt_data_subset$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

###############################################################################################################
###     PLOT                                                                                         ##
###############################################################################################################

#plot on screen
plot(DateTime, dt_data_subset$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(DateTime, dt_data_subset$Sub_metering_2, type="l", col="red")
lines(DateTime, dt_data_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#save to the Working Directory as png
dev.copy(png, file = "plot3.png", width = 480, height = 480)

#closes the device
dev.off()

