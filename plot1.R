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

#Create PLot 1 and Export to PNG
png(filename="plot1.png")
hist(electric$Global_active_power, breaks=15, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()


