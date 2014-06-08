# r = dataset
# subr = subset of dataset

## Loading libraries needed for executionlibrary(data.table) ## load data.table library to read file
## read a table, user must specify the location of file with file.choose()
r<-read.table(file.choose(),header=T,sep=";")

## Creates DateTime vector from Date and Time columns
r$DateTime <- paste(r$Date, r$Time) ## correctly paste the date times in new column as char class
r$DateTime <- as.Date(r$DateTime, format= "%d/%m/%Y %H:%M:%S") ## coerces field to Date but removes the time

subr <- subset(r, r$DateTime == "2007-02-01" |  r$DateTime == "2007-02-02")

## creates png file and sends it to a working dir
png(filename = "Plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

## creates a histogram
hist(as.numeric(as.character(subr$Global_active_power)),
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency",
     ylim=c(0, 1200), xlim=c(0,5))


dev.off() ## Close the PNG device

