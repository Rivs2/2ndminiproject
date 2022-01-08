#
# Data Prep
#

# Data directory
hpc <- "specdata/household_power_consumption.txt"

# Reading data
plotData <- read.table(hpc, header=TRUE, sep=";", na.strings="?")

# Convert Date and Time variables to Date/Time classes
plotData$DateTime <- strptime(paste0(plotData$Date,' ',plotData$Time), '%d/%m/%Y %H:%M:%OS')

# Extract data for the dates 2007-02-1 and 2007-02-02
finalData <- plotData[format(plotData$DateTime, "%Y%m%d") == '20070201' | format(plotData$DateTime, "%Y%m%d") == '20070202',]

#
# Generate Plot 1
#

hist(finalData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# Save plot as PNG file
dev.copy(png,"plot1.png", width=480, height=480)

# Turn off device
dev.off()

# 
# Generate Plot 2
#

plot(finalData$DateTime, finalData$Global_active_power, type="l", ylab="Global Active Power (kilowatts", xlab="")

# Save plot as PNG file
dev.copy(png,"plot2.png", width=480, height=480)

# Turn off device
dev.off()

#
# Generate Plot 3
#

plot(finalData$DateTime, finalData$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
lines(finalData$DateTime, finalData$Sub_metering_2, col="red")
lines(finalData$DateTime, finalData$Sub_metering_3, col="blue")
legend("topright",  col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lwd=1, lty=1, y.intersp=0.5)

# Save plot as PNG file
dev.copy(png,"plot3.png", width=480, height=480)

# Turn off device
dev.off()

#
# Generate Plot 4
#

labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(finalData$DateTime, finalData$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(finalData$DateTime, finalData$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
plot(finalData$DateTime, finalData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(finalData$DateTime, finalData$Sub_metering_2, type="l", col="red")
lines(finalData$DateTime, finalData$Sub_metering_3, type="l", col="blue")
legend("topright",  col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lwd=1, lty=1, cex=.66, y.intersp=0.2, bty = "n")
plot(finalData$DateTime, finalData$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")

# Save plot as PNG file
dev.copy(png,"plot4.png", width=480, height=480)

# Turn off device
dev.off()