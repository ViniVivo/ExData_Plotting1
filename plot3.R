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

## Create Plot 3
with(dataset, {
        plot(Sub_metering_1~dateTime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save file and close device
setwd("~/Documents/Data_Science/John_Hopkins/Explanatory_Data_Analisys/R/ExData_Plotting1/figure")
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
