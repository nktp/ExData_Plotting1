unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")

hh_consump <- read.delim('household_power_consumption.txt', sep=";")
hh_consump$Date <- format(as.Date(hh_consump$Date, format='%d/%m/%Y'), '%d/%m/%Y') 
hh_consump$Time <- format(strptime(hh_consump$Time, format='%H:%M:%S'), '%H:%M:%S')

require(dplyr)

df <- hh_consump %>%
  subset(Date %in% c('01/02/2007', '02/02/2007')) %>%
  mutate(Global_active_power=as.numeric(as.character(Global_active_power)), 
         Date_time=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")
)

png(file="plot2.png",
    width = 480, height = 480, units = "px")
plot(df$Date_time, df$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)",
     xlab=NA)
dev.off()

