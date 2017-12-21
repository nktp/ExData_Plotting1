unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")

hh_consump <- read.delim('household_power_consumption.txt', sep=";")
hh_consump$Date <- format(as.Date(hh_consump$Date, format='%d/%m/%Y'), '%d/%m/%Y') 
hh_consump$Time <- format(strptime(hh_consump$Time, format='%H:%M:%S'), '%H:%M:%S')

require(dplyr)

df <- hh_consump %>%
  subset(Date %in% c('01/02/2007', '02/02/2007')) %>%
  transmute(Global_active_power=as.numeric(as.character(Global_active_power)))

png(file="plot1.png",
    width = 480, height = 480, units = "px")
hist(df$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red",
     breaks=12)
dev.off()
