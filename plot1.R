# Set working directory where data file is stored
setwd("C:\\Users\\Home\\Documents\\Coursera\\exdata_data_household_power_consumption")
# Read in data from file
rawdata = read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")

# Convert date in rawdata array to date format to trim data
rawdata[,1] <- as.Date(rawdata[,1],format="%d/%m/%Y")
# Trim rawdata to dates of interest
rawdatatrim <- subset(rawdata, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02") )

# Create datetime variable by combining date and time variables 
datetime <- paste(as.character(rawdatatrim$Date),rawdatatrim$Time)

# Create datetime variable by combining date and time variables 
datetime <- strptime(x = as.character(datetime),format ="%Y-%m-%d %H:%M:%S")

# Create data interested to plot
dataplot <- data.frame(datetime=datetime,Global_active_power=rawdatatrim$Global_active_power)

# Open PNG file to write to
png("plot1.png", width=480, height=480, units="px")

# Plot the histogram
hist(dataplot$Global_active_power,main = "Global Active Power",xlab="Global Active Power (kilowatts)", col="red")

# Close PNG device
dev.off()