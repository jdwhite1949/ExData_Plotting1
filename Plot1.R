# script to establish connection with file and extract rows
# related to dates of 01/02/2007 and 02/02/2007

# Requirements:
# 1. Data text file and script must be in the working directory

# acquire variable (col) names from main dataset
var_label <- read.table("household_power_consumption.txt", sep = ";", 
                nrows = 1)

# acquire data related to dates 1 & 2 of month 2 year 2007
# from main dataset
subdata <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), 
                      sep = ";", stringsAsFactors = FALSE)

# add column (variable) names to subdata
colnames(subdata) <- unlist(var_label[1,])

# set (device) filename and size of png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# do plot
hist(subdata$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# generate png file
dev.off()

#remove variables from memory
rm(list = ls())




