## Read the file with data.table functions
options(warn = -1)
data <- fread("household_power_consumption.txt")
## Select rows
data <- subset(data,Date == "1/2/2007" | Date == "2/2/2007" )
## Generate Time object column
Time <- strptime(paste(data[,Date],data[,Time]),format="%d/%m/%Y %H:%M:%S")
## Paste Time column with current dataframe, discard current Time and Date columns in string format
data <- data.frame(Time,subset(data, select = c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")))
## Open device, print the graph and close device
png(file = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
hist(as.numeric(data$Global_active_power), main="Global Active Power", xlab="Global Active Power (Kilowatts)", col="red")
dev.off()