# script to establish connection with file and extract rows
# related to dates of 01/02/2007 and 02/02/2007

# Requirements:
# 1. Data text file and script must be in the working directory
# 2. package dplyr

# load dplyr
library(dplyr)

# acquire variable (col) names from main dataset
vars <- read.table("household_power_consumption.txt", sep = ";", 
                   nrows = 1)

# acquire data related to dates 1 & 2 of month 2 year 2007
# from main dataset
subdata <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), 
                      sep = ";", stringsAsFactors = FALSE)

# create variable to use in constructing x axis tick marks
rows <- nrow(subdata)

# add column (variable) names to subdata
colnames(subdata) <- unlist(vars[1,])

# create a datetime variable (column) and sort data in ascending order
# this ensures data is in ascending order by date and time
subdata <- mutate(subdata, datetime = paste(Date, Time))
subdata1$datetime <- as.numeric(strptime(subdata1$datetime, 
                                         "%d/%m/%Y %H:%M:%OS"), units = "secs")
subdata1 <- subdata1[order(subdata1$datetime),] #sorted in ascending order

# set (device) filename and size of png file
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# plot chart with no x-axis, label for y axis, and line type chart
# for sub metering 1 variable
plot(subdata$Sub_metering_1, type = "l", 
     xaxt = "n", xlab = " ", 
     ylab = "Energy sub metering")

# add sub metering 2 variable as a line and color red
lines(subdata$Sub_metering_2, type="l", col="red")

# add sub metering 3 variable as a line and color blue
lines(subdata$Sub_metering_3, type="l", col="blue")

# add legend
legend("topright", legend = c("Sub_metering_1", 
    "Sub_metering_2", "Sub_metering_3"), 
    col = c("black", "red", "blue"), lty = c(1, 1, 1))

# add tick marks and labels
axis(1, c(1, rows/2, rows), labels = c("Thu", "Fri", "Sat"))

# generate png file
dev.off()

#remove variables from memory
rm(list = ls())
