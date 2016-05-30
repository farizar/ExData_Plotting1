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
dataplot <- data.frame(datetime=datetime,Global_active_power=rawdatatrim$Global_active_power,Voltage=rawdatatrim$Voltage,Sub_metering_1=rawdatatrim$Sub_metering_1,Sub_metering_2=rawdatatrim$Sub_metering_2,Sub_metering_3=rawdatatrim$Sub_metering_3,Global_reactive_power=rawdatatrim$Global_reactive_power)

# Open PNG file to write to
png("plot4.png", width=480, height=480, units="px")

# Plot the line diagram
par(mfrow=c(2,2))
plot(dataplot$datetime,dataplot$Global_active_power,type="l",xlab="",ylab="Global Active Power")
plot(dataplot$datetime,dataplot$Voltage,type="l",xlab="",ylab="Voltage")
plot(dataplot$datetime,dataplot$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(dataplot$datetime,dataplot$Sub_metering_2,type="l",col="red")
lines(dataplot$datetime,dataplot$Sub_metering_3,type="l",col="blue")
legend("top",lty=c(1,1,1),col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
plot(dataplot$datetime,dataplot$Global_reactive_power,type="l",xlab="",ylab="Global Reactive Power")

# Close PNG device
dev.off()