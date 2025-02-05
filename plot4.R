library(dplyr)
# load dplyr

consump <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
consump$Date <- as.Date(consump$Date, "%d/%m/%Y")
# read in full dataset, format first column as a Date

trimmed <- consump %>% filter(Date == "2007-02-01" | Date == "2007-02-02")
trimmed$Date <- strptime(paste(trimmed$Date, trimmed$Time), "%Y-%m-%d %H:%M:%S")
trimmed <- trimmed %>% rename("Date/Time" = Date) %>% select(!Time)
# trim datset to include only the 2 days we are looking at, then combine the Date and Time columns

trimmed$Global_active_power <- as.numeric(trimmed$Global_active_power)

par(mfrow = c(2,2))
plot(trimmed$`Date/Time`, trimmed$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "", xaxt = "n")
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), "days"), format = "%A")
# recreating plot1 for 1st plot in window 

plot(trimmed$`Date/Time`, trimmed$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), "days"), format = "%A")
# creating 2nd plot in window

plot(trimmed$`Date/Time`,trimmed$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "", xaxt = "n")
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), "days"), format = "%a")
lines(trimmed$`Date/Time`, trimmed$Sub_metering_1, type = "l")
lines(trimmed$`Date/Time`, trimmed$Sub_metering_2, type = "l", col = "red")
lines(trimmed$`Date/Time`, trimmed$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 0.75, bty = "n")
# recreating plot3 for 3rd plot in window. Resizing legend

with(trimmed, plot(`Date/Time`, Global_reactive_power, type = "l", xlab = "datetime", xaxt = "n"))
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), "days"), format = "%A")
# creating 4th plot in window

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
#saving plot 4