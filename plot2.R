library(dplyr)
library(data.table)

#create a temporary file + download file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = temp)

# unzip file and read 
sourcefile <- unzip(temp)
hpc <- fread(sourcefile[[1]])
unlink(sourcefile)

#subsetting data required + change the class of variable
hpc_subset <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"), ]
GlobalActivePower <- as.numeric(hpc_subset$Global_active_power)
datetime <- strptime(paste(hpc_subset$Date,hpc_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#plot the chart as required
plot(datetime, GlobalActivePower, type = "l" , xlab = "", ylab = "Global Active Power (kilowatts)" )

#copy the line chart from graphic device to png file
dev.copy(png, file = "plot2.png")
dev.off()

