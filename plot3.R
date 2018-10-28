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
subMeter1 <- as.numeric(hpc_subset$Sub_metering_1)
subMeter2 <- as.numeric(hpc_subset$Sub_metering_2)
subMeter3 <- as.numeric(hpc_subset$Sub_metering_3)
datetime <- strptime(paste(hpc_subset$Date,hpc_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#plot as required
windows(width = 10, height = 8)
plot(datetime, subMeter1, type = "l", xlab = "", ylab = "Energy sub Metering")
lines(datetime, subMeter2, type = "l", col = "red")
lines(datetime, subMeter3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 1, col = c("black", "red", "blue"), cex = 0.7)

#copy the line chart from graphic device to png file
dev.copy(png, file = "plot3.png")
dev.off()
