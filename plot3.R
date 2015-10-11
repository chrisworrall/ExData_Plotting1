# household power consumption dataset from UCI Machine Learning Repository
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# zipped dataset:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip to working directory before running this script.

# subset the data to the two days we're using
system('cat household_power_consumption.txt | grep ^[12]/2/2007 > feb.txt')
# variables:
# date - d/m/yyyy
# time - hh:mm:ss
# active - household global minute-averaged active power (in kilowatt)
# reactive - household global minute-averaged reactive power (in kilowatt)
# voltage - minute-averaged voltage (in volt)
# intensity - household global minute-averaged current intensity (in ampere)
# sub1, 2, 3 -- energy sub-metering (in watt-hour of active enery)
# sub1 - the kitchen, containing mainly a dishwasher, an oven
#     and a microwave (hot plates are not electric but gas powered).
# sub2 - the laundry room, containing a washing-machine, a tumble-drier,
#     a refrigerator and a light.
# sub3 - an electric water-heater and an air-conditioner.
power <- read.csv(file='feb.txt',
                  sep = ';',
                  col.names = c('date','time','active','reactive',
                                'voltage','intensity','sub1','sub2','sub3')
)
power$date <- as.Date(power$date, format="%d/%m/%Y")
power$time <- strptime(paste(power$date, power$time), format="%Y-%m-%d %H:%M:%S")

png(file='plot3.png', bg = 'transparent',
    width = 480, height = 480, units = "px")
plot(x=power$time, 
     y=power$sub1,
     type='l',
     xlab='',
     ylab='Energy sub metering')
points(x=power$time, y=power$sub2, col='red', type='l')
points(x=power$time, y=power$sub3, col='blue', type='l')
legend('topright',
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lwd=1, col= c('black', 'red', 'blue'))
dev.off()