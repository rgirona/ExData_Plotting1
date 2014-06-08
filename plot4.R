## Set up the grid 2x2
par(mfrow = c(2, 2), mar=c(4,3.8,2,2.5), cex=0.65)
## png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
## WARNING: In plot4.png the days of the week are in Spanish due to the OS language 


## Read the file with dapar(mar=c(4,3.8,2,2.5))ta.table functions
options(warn = -1)
data <- fread("household_power_consumption.txt")
## Select rows
data <- subset(data,Date == "1/2/2007" | Date == "2/2/2007" )
## Generate Time object column
Time <- strptime(paste(data[,Date],data[,Time]),format="%d/%m/%Y %H:%M:%S")
## Paste Time column with current dataframe, discard current Time and Date columns in string format
data <- data.frame(Time,subset(data, select = c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")))


## Graph on the top left (1,1)
plot(data$Time,as.numeric(data$Global_active_power),type="l",xlab="",ylab="Global Active Power")


## Graph on the top right (1,2)
plot(data$Time,as.numeric(data$Voltage),type="l",xlab="datetime",ylab="Voltage")


## Graph on the bottom left (2,1)
with (data,
      plot(Time,Sub_metering_1, type = "l",ylab="",xlab="")
      )
with (data,
      lines(Time,Sub_metering_2, col = "red")
      )
with (data,
      lines(Time,Sub_metering_3, col = "blue")
      )
title(ylab="Energy sub metering")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c(1,2,4), lty = 1, bty = "n")

## Graph on the bottom right (2,2)
plot(data$Time,as.numeric(data$Global_reactive_power),type="l",xlab="datetime",ylab="Global_reactive_power")

## Copy to png and close the PNG device! 
dev.copy(png, file = "plot4.png") 
dev.off() 
