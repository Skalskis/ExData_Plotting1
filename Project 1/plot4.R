# r = dataset
# subr = subset of dataset

## Loading libraries needed for execution
library(data.table) ## load data.table library to read file
library(chron) ## library to deal with times and dates

## read a table, user must specify the location of file with file.choose()
r<-read.table(file.choose(),header=T,sep=";")

## Creates DateTime vector from Date and Time columns
r$DateTime <- paste(r$Date, r$Time) ## correctly paste the date times in new column as char class
r$DateTime <- strptime(r$DateTime, format= "%d/%m/%Y %H:%M:%S") ## coerces field to Date but removes the time

##subsets relevant data
subr <- subset(r, as.Date(r$DateTime) == "2007-02-01" |  as.Date(r$DateTime) == "2007-02-02")

png(filename = "Plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

## creates 2x2 plot grid
par(mfcol = c(2, 2))

## creates 1st plot
plot(as.POSIXlt(subr$DateTime), as.numeric(as.character(subr$Global_active_power)), 
     type = "l", 
     ylab="Global Active Power (kilowatts)", xlab="")

## creates 2nd plot
with(subr, plot(as.POSIXlt(subr$DateTime), subr$Sub_metering_1, 
                ylab="Energy sub metering", xlab="", 
                type = "n"))
with(subr, points(as.POSIXlt(subr$DateTime), subr$Sub_metering_1, type="l", col = "black"))
with(subr, points(as.POSIXlt(subr$DateTime), subr$Sub_metering_2, type="l", col = "blue"))
with(subr, points(as.POSIXlt(subr$DateTime), subr$Sub_metering_3, type="l", col = "red"))

legend(x = "topright",  
       bty = "n",
       y.intersp = 1, 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),   
       lty=c(1, 1, 1),   
       lwd=c(2.5, 2.5, 2.5),  
       col=c("black", "red", "blue"),  
       pt.cex=0.75,  
       cex=0.5,
)

## creates 3rd plot
plot(as.POSIXlt(subr$DateTime), subr$Voltage, 
     type = "l", 
     ylab="Voltage", xlab="datetime")

## creates 4rth plot
plot(as.POSIXlt(subr$DateTime), as.numeric(as.character(subr$Global_reactive_power)), 
     type = "l", 
     ylab="Global Reactive Power (kilowatts)", xlab="datetime")

dev.off() ## Close the PNG device