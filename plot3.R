unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")

hh_consump <- read.delim('household_power_consumption.txt', sep=";")
hh_consump$Date <- format(as.Date(hh_consump$Date, format='%d/%m/%Y'), '%d/%m/%Y') 
hh_consump$Time <- format(strptime(hh_consump$Time, format='%H:%M:%S'), '%H:%M:%S')

require(dplyr)

df <- hh_consump %>%
  subset(Date %in% c('01/02/2007', '02/02/2007')) %>%
  mutate(Date_time=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"),
         Sub_metering_1=as.numeric(as.character(Sub_metering_1)),
         Sub_metering_2=as.numeric(as.character(Sub_metering_2)),
         Sub_metering_3=as.numeric(as.character(Sub_metering_3))
  )

png(file="plot3.png",
    width = 480, height = 480, units = "px")
plot(df$Date_time, df$Sub_metering_1, type="l",
     ylab="Energy sub metering",
     xlab=NA)
lines(df$Date_time, df$Sub_metering_2, col="red")
lines(df$Date_time, df$Sub_metering_3, col="blue")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

