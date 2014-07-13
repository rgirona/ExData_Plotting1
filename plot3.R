## Read the file with data.table functions
options(warn = -1)
Sys.setlocale("LC_TIME", "C")
data <- fread("household_power_consumption.txt")
## Select rows
data <- subset(data,Date == "1/2/2007" | Date == "2/2/2007" )
## Generate Time object column
Time <- strptime(paste(data[,Date],data[,Time]),format="%d/%m/%Y %H:%M:%S")
## Paste Time column with current dataframe, discard current Time and Date columns in string format
data <- data.frame(Time,subset(data, select = c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")))
## Open device, print the graph and close device
## In plot2.png the days of the week are in Spanish due to the OS language 
png(file = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
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
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c(1,2,4), lty = 1, cex=0.75)
dev.off()