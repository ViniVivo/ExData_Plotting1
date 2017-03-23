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

## Create Plot 1
hist(dataset$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
setwd("~/Documents/Data_Science/John_Hopkins/Explanatory_Data_Analisys/R/ExData_Plotting1/figure")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

