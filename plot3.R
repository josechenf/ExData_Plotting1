############### IMPORTANT NOTES ########################

## Before running this code:
## Make sure that the working folder contains the 
## household_power_consumption.txt file

## Run the getwd() command to see your current working directory
## Run the setwd("~[addresshere]") to change the working directory

## The file is formatted into 9 columns separated by semicolons (;)

## If the PNG is copied off the screen graphics device(dev.copy), the image may not
## resize properly. This is why we make the plot directly on the PNG graphics.
########################################################



############### Setting Work Directory ########################

setwd("~/Desktop/0. Studies/Coursera/DataScienceSpecialization/Exploratory Data Analysis/Project 1/ExData_Plotting1")

###############################################################


############# Reading data from text file #################

mydata <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

#if na.strings is not defined, values will be read wrong.

###########################################################


################# Adding a new column with the Date & time####################

mydata[,1] <- as.Date(as.character(mydata[,1]), "%d/%m/%Y") ##Change to date format
mydata[,2] <- as.character(mydata[,2])  ##Change to characters

Datetime <- paste(mydata[,1], mydata[,2]) #Make a string
Datetime <- strptime(Datetime, "%Y-%m-%d %H:%M:%S") #convert string to date format

mydata$Datetime<-Datetime ## Added a new column with the date and time

###############################################################################


############### Make a new data frame with only the dates requested ###############

SpecificDaysData<-which(as.Date(mydata$Datetime) >= "2007-02-01" & as.Date(mydata$Datetime) <= "2007-02-02")
#obtained indexes for required dates
#could have also been done with subset(mydata, subset=(Datetime=="2007-02-01"...etc...)) function

SpecificDaysData<- mydata[SpecificDaysData,]
#obtained data for the specific dates, i.e. 2007-02-01 & 2007-02-02

###############################################################################



############### Make a Plot of the Energy Sub metering vs Date ###############


##initialize PNG image
png (file="plot3.png", height=480, width=480)

##to control background color
par(bg = "transparent")

plot(SpecificDaysData$Datetime, as.numeric(SpecificDaysData$Sub_metering_1), 
     type = "n", main = "", xlab = "", ylab = "Energy sub metering", bg = "white")
##First create the plot without anything

##add sub metering 1
points(SpecificDaysData$Datetime, as.numeric(SpecificDaysData$Sub_metering_1), 
       type = "l", col = "black")

##add sub metering 2
points(SpecificDaysData$Datetime, as.numeric(SpecificDaysData$Sub_metering_2), 
       type = "l", col = "red")

##add sub metering 3
points(SpecificDaysData$Datetime, as.numeric(SpecificDaysData$Sub_metering_3), 
       type = "l", col = "blue")

##add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black","red", "blue"), lwd = c(1,1,1), cex = 1)
##cex controls legend size

dev.off()
## close PNG
###############################################################################


############### Alternatively, copy to png, but image may change ###############

#dev.copy(png, file="plot3.png", height=480, width=480)
#dev.off()

###############################################################################


