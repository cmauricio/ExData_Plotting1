##### Exploratory Data Analysis
#First assignment

# Loading libraries

install.packages("lubridate")

library(lubridate)

# Getting the data

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
WD<-"~/GitHub/ExploratoryDataCoursera/Assignment1/"
download.file(url,"~/GitHub/ExploratoryDataCoursera/Assignment1/DatasetAssignment1.zip")
setwd(WD)

# Unziping the file
unzip("DatasetAssignment1.zip")

# reading the file
dataset<-read.table("household_power_consumption.txt", header=T, sep = ";", dec = ".", na.strings = "?")

#transforming dates and times

dataset$DateTime<-strptime(paste(dataset$Date, dataset$Time), format="%d/%m/%Y %H:%M:%S")

dataset$Date<-as.Date(dataset$Date, format="%d/%m/%Y")

dataset$DateTime<-as.POSIXct(dataset$DateTime)


# subsetting the database
consumption<-subset(dataset, Date=="2007-02-01" | Date=="2007-02-02")


# Creating and exporting the second graph
png(filename = "plot2.png", width= 480, height=480,
    units="px", pointsize = 12)

with(consumption, plot(Global_active_power~ymd_hms(consumption$DateTime), type="l", main="", xlab="", ylab="Global Active Power (kilowatts)"))

dev.off()