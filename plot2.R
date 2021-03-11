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

##plot2
png("./plot2.png",width = 480, height = 480)
plot(data[,3] ~ timedata, type = "n",xlab = "", ylab = "Global Active Power")
lines(data[,3] ~ timedata)
dev.off()