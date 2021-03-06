# Import, working with dates and subset data
# Import
rm(list = ls())
Data <- read.table(file = "household_power_consumption.txt", sep = ";", header = T)
# Subset 
Subset_Data <- subset(Data, Data$Date=="1/2/2007" | Data$Date=="2/2/2007") 
names(Subset_Data)
attach(Subset_Data)
# Working with dates
Subset_Data$Date <- as.Date(Subset_Data$Date, format="%d/%m/%Y")
Subset_Data$Time <- strptime(Subset_Data$Time, format="%H:%M:%S")
Subset_Data[1:1440,"Time"] <- format(Subset_Data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
Subset_Data[1441:2880,"Time"] <- format(Subset_Data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# Plot 4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
# Plot (1,1)
plot(Subset_Data$Time, as.numeric(Global_active_power),
     type="l", xlab="", ylab="Global Active Power")
# Plot (1,2)
plot(Subset_Data$Time, as.numeric(Voltage),
     type="l", xlab="datetime", ylab="Voltage")
# Plot (2,1)
plot(Subset_Data$Time, as.numeric(Sub_metering_1),
     type="l", xlab="", ylab="Energy sub metering", col="black")
lines(Subset_Data$Time, as.numeric(Sub_metering_2), col="red")
lines(Subset_Data$Time, as.numeric(Sub_metering_3), col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Plot (2,2)
plot(Subset_Data$Time, as.numeric(Global_reactive_power),
     type="l", xlab="datetime", ylab="Global reactive power", col="black")
dev.off()
