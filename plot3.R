par(cex.lab = .55, cex.axis = .55)
read <- read.table("household_power_consumption.txt", sep = ";",
                   col.names = c("Date","Time", "Global_active_power",
                                 "Global_reactive_power","Voltage",
                                 "Global_intensity","Sub_metering_1",
                                 "Sub_metering_2","Sub_metering_3"),
                   skip = 66637, nrows = 2880, colClasses = "character")

#66,636 minutes from 16 Dec to 1 Feb; 2880 min in 2 days

date <- as.Date(read$Date, "%d/%m/%Y")
dateTime <- strptime(paste(date, read$Time), "%Y-%m-%d %H:%M:%S")

power <- data.frame(dateTime, read[3:9])

png("plot3.png", width = 480, height = 480)

plot(dateTime, as.numeric(power[[6]]), type = "n", ylab = "Energy sub metering")
lines(dateTime, as.numeric(power[[6]]))
lines(dateTime, as.numeric(power[[7]]), col = "red")
lines(dateTime, as.numeric(power[[8]]), col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"), lty = c(1, 1, 1),
       col = c("black", "red", "blue"), cex = .8)

dev.off()