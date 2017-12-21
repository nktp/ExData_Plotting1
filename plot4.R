unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")

hh_consump <- read.delim('household_power_consumption.txt', sep=";")
hh_consump$Date <- format(as.Date(hh_consump$Date, format='%d/%m/%Y'), '%d/%m/%Y') 
hh_consump$Time <- format(strptime(hh_consump$Time, format='%H:%M:%S'), '%H:%M:%S')

require(dplyr)

df <- hh_consump %>%
  subset(Date %in% c('01/02/2007', '02/02/2007')) %>%
  mutate(Datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"),
         Sub_metering_1=as.numeric(as.character(Sub_metering_1)),
         Sub_metering_2=as.numeric(as.character(Sub_metering_2)),
         Sub_metering_3=as.numeric(as.character(Sub_metering_3)),
         Global_active_power=as.numeric(as.character(Global_active_power)),
         Voltage=as.numeric(as.character(Voltage)),
         Global_reactive_power=as.numeric(as.character(Global_reactive_power))
  )

png(file="plot4.png",
    width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
plot1 <- plot(df$Datetime, df$Global_active_power, type="l", 
              ylab="Global Active Power (kilowatts)", 
              xlab=NA)
plot2 <- plot(df$Datetime, df$Voltage, type="l",
              ylab="Voltage",
              xlab="datetime")
plot3 <- plot(df$Datetime, df$Sub_metering_1, type="l", 
              ylab="Energy sub metering",
              xlab=NA)
lines(df$Datetime, df$Sub_metering_2, col="red")
lines(df$Datetime, df$Sub_metering_3, col="blue")
legend("topright", bty="n", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot4 <- plot(df$Datetime, df$Global_reactive_power, type="l",
              ylab="Global_reactive_power",
              xlab="datetime")
dev.off()
