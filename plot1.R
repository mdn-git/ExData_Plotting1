###############################################################################################################
###                     Exploratory Data Analysis: Week 1 Project                                           ###
###                                     PLOT1.R                                                             ###
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

#subset
dt_data_subset <- dt_data[Date >= "2007-02-01" & Date <= "2007-02-02"]

###############################################################################################################
###     PLOT                                                                                         ##
###############################################################################################################

#plot on screen
hist(dt_data_subset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red")

#save to the Working Directory as png
dev.copy(png, file = "plot1.png", width = 480, height = 480)

#closes the device
dev.off()

