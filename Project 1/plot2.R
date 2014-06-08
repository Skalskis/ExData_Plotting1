# r = dataset
# subr = subset of dataset

## Loading libraries needed for executionlibrary(data.table) ## load data.table library to read file
library(chron) ## library to deal with times and dates

## read a table, user must specify the location of file with file.choose()
r<-read.table(file.choose(),header=T,sep=";")

## Creates DateTime vector from Date and Time columns
r$DateTime <- paste(r$Date, r$Time) ## correctly paste the date times in new column as char class
r$DateTime <- strptime(r$DateTime, format= "%d/%m/%Y %H:%M:%S") ## coerces field to Date but removes the time

##subsets relevant data
subr <- subset(r, as.Date(r$DateTime) == "2007-02-01" |  as.Date(r$DateTime) == "2007-02-02")

## png(filename = "Plot2.png",
##    width = 480, height = 480, units = "px", pointsize = 12,
##    bg = "white")

## creates plot
plot(as.POSIXlt(subr$DateTime), as.numeric(as.character(subr$Global_active_power)), 
     type = "l", 
     ylab="Global Active Power (kilowatts)", xlab="")

## dev.off() ## Close the PNG device