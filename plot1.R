library(data.table)
library(dplyr)

#create a temporary file + download file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = temp)

# unzip file and read 
sourcefile <- unzip(temp)
hpc <- fread(sourcefile[[1]])

#subsetting data required + change the class of variable
hpc_subset <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"), ]
hpc_subset$Global_active_power <- as.numeric(hpc_subset$Global_active_power)

#plot hist as required
hist(hpc_subset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     freq = 200, col = "red")

#copy the hist from graphic device to png file
dev.copy(png, file = "plot1.png")
dev.off()
