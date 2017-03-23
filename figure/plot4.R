## Set Dir
setwd("~/Documents/Data_Science/John_Hopkins/Explanatory_Data_Analisys/R/")

## Import file
file = "household_power_consumption.txt"
dataset <- read.table(file = file, header = TRUE, sep = ";", na.strings = "?", 
                      colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

##Mutating Date
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

## Filter data set
dataset <- subset(dataset,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
dataset <- dataset[complete.cases(dataset),]

## Combine Date and Time column
dateTime <- paste(dataset$Date, dataset$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
dataset <- dataset[ ,!(names(dataset) %in% c("Date","Time"))]

## Add DateTime column
dataset <- cbind(dateTime, dataset)

## Format dateTime Column
dataset$dateTime <- as.POSIXct(dateTime)

## Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dataset, {
        plot(Global_active_power~dateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~dateTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~dateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~dateTime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

## Save file and close device
setwd("~/Documents/Data_Science/John_Hopkins/Explanatory_Data_Analisys/R/ExData_Plotting1/figure")
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
