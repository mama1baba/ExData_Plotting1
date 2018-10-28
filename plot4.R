library(dplyr)
library(data.table)

#create a temporary file + download file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = temp)

# unzip file and read 
sourcefile <- unzip(temp)
hpc <- fread(sourcefile, header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE)
unlink(sourcefile)

#subsetting data required + change the class of variable
hpc_subset <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"), ]
GlobalActivePower <- as.numeric(hpc_subset$Global_active_power)
voltage <- as.numeric(hpc_subset$Voltage)
GlobalReactivePower <- as.numeric(hpc_subset$Global_reactive_power)
subMeter1 <- as.numeric(hpc_subset$Sub_metering_1)
subMeter2 <- as.numeric(hpc_subset$Sub_metering_2)
subMeter3 <- as.numeric(hpc_subset$Sub_metering_3)
datetime <- strptime(paste(hpc_subset$Date,hpc_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#set windows and alignment
windows(width = 10, height = 8)
par(mfrow = c(2,2))

#plot globalactivepower
plot(datetime, GlobalActivePower, type = "l" , xlab = "", ylab = "Global Active Power" )

#plot voltage
plot(datetime, voltage, type = "l", ylab = "Voltage")

#plot submetering
plot(datetime, subMeter1, type = "l", xlab = "", ylab = "Energy sub Metering")
lines(datetime, subMeter2, type = "l", col = "red")
lines(datetime, subMeter3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 1, col = c("black", "red", "blue"), cex = 0.7)

#plot globalreactivepower
plot(datetime, GlobalReactivePower, type = "l", ylab = "Global_reactive_power")

#copy the charts from graphic device to png file
dev.copy(png, file = "plot4.png")
dev.off()
