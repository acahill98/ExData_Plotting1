#Read in data and put date and time in the required formats

power<-read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses="character")
power$combined<-as.factor(paste(power$Date, power$Time, sep=" "))

power$times<-strptime(power$combined, "%d/%m/%Y %H:%M:%S")

power$thedate<-as.Date(power$times, "%d/%m/%Y")

dates<-subset(power, power$thedate %in% as.Date(c("2007-02-01", "2007-02-02")))

#Open png device and create file in working directory
png(file="plot4.png", width = 480, height = 480)

#Graph 4
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))

with(dates, plot(times, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

with(dates, plot(times, Voltage, type="l", xlab="", ylab="Voltage"))

with(dates, plot(times, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black"))
lines(dates$times, dates$Sub_metering_2, col="red")
lines(dates$times, dates$Sub_metering_3, col="blue")
legend("topright", inset=c(0,0.05), lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(dates, plot(times, Global_reactive_power, type="l", xlab="", ylab="Global Re-Active Power"))

#Close the png device
dev.off()