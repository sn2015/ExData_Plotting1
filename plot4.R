## this code gets data from web into data folder, unzips, reads and makes plot.png

## were used Windows 8.1 
## R version 3.1.3 (2015-03-09) -- "Smooth Sidewalk", Platform: x86_64-w64-mingw32/x64 (64-bit)
## base package

## getting data
if(!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/household_power_consumption.zip")
datedownloaded <- date()
write(datedownloaded, file="./data/datedownloaded.txt")
unzip("./data/household_power_consumption.zip", exdir = "./data")

## reading data
alldata <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";",
                      na.strings = "?", colClasses = c(Date = "character", Time = "character"))

## subsetting two days
data <- alldata[alldata$Date == "1/2/2007" | alldata$Date == "2/2/2007", ]

# creating new variable
data$DateTime <- paste(data$Date, data$Time, sep = " ")
data$DateTime <- strptime(data$DateTime, "%e/%m/%Y %H:%M:%S")

## making plot4
Sys.setlocale("LC_TIME", "English") # makes weekdays appear in English 
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))
par(mar = c(2, 2, 2, 2))

with(data, plot(DateTime, Global_active_power, type = "l", xlab = "", 
                ylab = "Global active power (kilowatts)"))

with(data, plot(DateTime, Sub_metering_1, ylab = "Energy Submrtering", type= "n"))        
with(data, points(DateTime, Sub_metering_1, type = "l"))
with(data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", pch = "-", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(data, plot(DateTime, Voltage, type = "l", 
                ylab = "Voltage"))

with(data, plot(DateTime, Global_reactive_power, type = "l", 
                ylab = "Global reactive power (kilowatts)"))
dev.off()
Sys.setlocale(category = "LC_TIME", locale = "") # restore local settings

## plot4 is in your working directory
