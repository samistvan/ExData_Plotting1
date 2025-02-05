library(dplyr)
# load dplyr

consump <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
consump$Date <- as.Date(consump$Date, "%d/%m/%Y")
# read in full dataset, format first column as a Date

trimmed <- consump %>% filter(Date == "2007-02-01" | Date == "2007-02-02")
trimmed$Date <- strptime(paste(trimmed$Date, trimmed$Time), "%Y-%m-%d %H:%M:%S")
trimmed <- trimmed %>% rename("Date/Time" = Date) %>% select(!Time)
# trim datset to include only the 2 days we are looking at, then combine the Date and Time columns

plot(trimmed$`Date/Time`,trimmed$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "", xaxt = "n")
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), "days"), format = "%a")
# creating shell for 3rd plot and recreating Date/Time axis from last plot

lines(trimmed$`Date/Time`, trimmed$Sub_metering_1, type = "l")
lines(trimmed$`Date/Time`, trimmed$Sub_metering_2, type = "l", col = "red")
lines(trimmed$`Date/Time`, trimmed$Sub_metering_3, type = "l", col = "blue")
# creating data series for plot 3

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
# creating legend for plot 3

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
# saving plot 3