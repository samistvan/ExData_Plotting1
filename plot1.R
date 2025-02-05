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
hist(trimmed$Global_active_power, main = "Global Active Power", col = "Red", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
# creating 1st plot, histogram of Global active power, and saving it to png file

