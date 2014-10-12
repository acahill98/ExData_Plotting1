#Read in data and put date and time in the required formats

power<-read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses="character")
power$combined<-as.factor(paste(power$Date, power$Time, sep=" "))

power$times<-strptime(power$combined, "%d/%m/%Y %H:%M:%S")

power$thedate<-as.Date(power$times, "%d/%m/%Y")

dates<-subset(power, power$thedate %in% as.Date(c("2007-02-01", "2007-02-02")))

#Open png device and create file in working directory
png(file="plot1.png", width = 480, height = 480)
#Graph 1
dates$Global_active_power<-as.numeric(dates$Global_active_power)
hist(dates$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

#Close the png device
dev.off()

