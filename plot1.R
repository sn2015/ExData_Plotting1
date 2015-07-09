# this code gets data frum url in data folder, unzips, reads and makes plot1.png

# getting data
if(!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/household_power_consumption.zip")
datedownloaded <- date()
write(datedownloaded, file="./data/datedownloaded.txt")
unzip("./data/household_power_consumption.zip", exdir = "./data")

# reading data
initial <- read.table("./data/household_power_consumption.txt",
                      header = TRUE, sep = ";", nrows=100)
classes <- sapply(initial, class)
data <- read.table("./data/household_power_consumption.txt",
                   header = TRUE, sep = ";", na.strings = "?", colClasses = classes)

# converting the Date and Time variables to Date/Time classes
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(data$Time, "%H:%M:%S")

# subsetting two days
data1 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

# checking for NA
any(is.na(data1))
colSums(is.na(data1))

# making plot1
png(filename = "plot1.png",
    width = 480, height = 480)
hist(data1$Global_active_power, main = "Global active power", 
     xlab = "Global active power (kilowatts)", col = "red")
dev.off()

# plot1.png is in your working directory
