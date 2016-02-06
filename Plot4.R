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

# Creating and Exporting the fourth graph

png(filename = "plot4.png", width= 480, height=480,
    units="px", pointsize = 12)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(consumption, {
     plot(Global_active_power~ymd_hms(consumption$DateTime), type = "l", xlab="", ylab = "Global Active Power")
     
     plot(Voltage~ymd_hms(consumption$DateTime), type = "l", xlab = "datetime", ylab= "Voltage")
     
     plot(Sub_metering_1~ymd_hms(consumption$DateTime), type="l", col="black", main="", xlab="", ylab="Energy sum metering")
     lines(consumption$Sub_metering_2~ymd_hms(consumption$DateTime), col="red")
     lines(consumption$Sub_metering_3~ymd_hms(consumption$DateTime), col="blue")
     legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
            lty=1, col=c("black", "red", "blue"), bty='n', cex=.75)
     
     plot(Global_reactive_power~ymd_hms(consumption$DateTime),type = "l", xlab="datetime", ylab = "Global Reactive Power")
})

dev.off()

