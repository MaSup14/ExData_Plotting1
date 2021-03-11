# Clear command window and environment
rm(list=ls())
cat("\f")

# Download data
file1 <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./exdata_data_household_power_consumption.zip")
con1 <- unzip("./exdata_data_household_power_consumption.zip",exdir = ".")

# Read in header of table and the relevant rows of the data
head_data <- read.csv2("./household_power_consumption.txt",header = F, skip = 0, nrows = 1);
data <- read.csv2("./household_power_consumption.txt",header = T, skip = 66636, nrows = 2880)

# Assign header data to the columns of the relevant data
names(data)<-head_data

# Set localtime to English
Sys.setlocale("LC_TIME", "English")

# Convert first column in Date format
data[,1] <- as.Date(data[,1],"%d/%m/%Y")

# Convert date and time into Date/Time class
timedata <- as.POSIXct(paste(data[,1], data[,2]), format="%Y-%m-%d %H:%M:%S")

##plot4
png("./plot4.png",width = 480, height = 480)
par(mfcol=c(2,2))
#4.1
plot(data[,3] ~ timedata, type = "n", xlab = "", ylab = "Global Active Power")
lines(data[,3] ~ timedata)
#4.2
plot(data[,7] ~ timedata, type = "n", xlab = "", ylab = "Energy sub metering")
lines(data[,7] ~ timedata)
lines(data[,8] ~ timedata, col = "red")
lines(data[,9] ~ timedata, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1,bty = "n", cex = 0.9)
#4.3
plot(data[,5] ~ timedata, type = "n", xlab = "datetime", ylab = "Voltage")
lines(data[,5] ~ timedata)
#4.4
plot(data[,4] ~ timedata, type = "n", xlab = "datetime", ylab = "Global_reactive_power", ylim=c(0.1,0.5))
lines(data[,4] ~ timedata)
dev.off()