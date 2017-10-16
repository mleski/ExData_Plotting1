#Calculate memory requirements in GB
mem_need <- 2075259 * 9 * 8 / 2^20 / 1000; mem_need

#Read in data
library(dplyr)
library(lubridate)
getwd()
setwd("/Users/EZ/Documents/Data/Exercises/Coursera/ExploratoryDataAnalysis/assign1")
electric <- read.delim("household_power_consumption.txt", sep=";", na.strings="?")

#Convert date to date/time class and get only data for Feb 1-Feb 2, 2007
electric$Date1 <- strptime(paste(electric$Date, electric$Time, sep=" "), format="%d/%m/%Y %H:%M:%S", tz="")
feb<-interval(ymd_hms("2007-02-01 00:00:00", tz=""), ymd_hms("2007-02-02 23:59:59", tz=""))
electric<-subset(electric, electric$Date1 %within% feb) %>% 
  select(Date1, Global_active_power:Sub_metering_3)

#Create Plot 4 and Export to PNG
png(filename="plot4.png")
par(mfrow=c(2,2), xpd=FALSE)
plot(electric$Date1, electric$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(electric$Date1, electric$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(electric$Date1, electric$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(electric$Date1, electric$Sub_metering_2, col="red")
lines(electric$Date1, electric$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
plot(electric$Date1, electric$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()