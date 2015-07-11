library(lubridate)
#Given text file "household_power_consumption.txt" is in the run dir, will plot submetering against Date
plot3 <- function(){
  #Read in the data and select data between 2007-02-01 and 2007-02-02
  data <- read.csv("household_power_consumption.txt", sep=";")
  data["Date2"] <- as.Date(data[,"Date"], "%d/%m/%Y")
  data <- data[data[,"Date2"] >=  as.Date("2007-02-01") & data[,"Date2"] <= as.Date("2007-02-02"),] 
  data["DateTime"] <- paste(data[,"Date"], data[,"Time"])
  data["DateTime"] <- dmy_hms(data[,"DateTime"])
  
  #Convert the energy sub metering columns to numeric format and save a plot of this against the date to file "plot3.png"
  data[,"Sub_metering_1"] <- as.numeric(as.matrix(data[,"Sub_metering_1"]))
  data[,"Sub_metering_2"] <- as.numeric(as.matrix(data[,"Sub_metering_2"]))
  data[,"Sub_metering_3"] <- as.numeric(as.matrix(data[,"Sub_metering_3"]))
  plot(data[,"DateTime"], data[,"Sub_metering_1"], main="", ylab="Energy Sub Metering", xlab="", type="l", col="black")  
  lines(data[,"DateTime"], data[,"Sub_metering_2"], col="red")
  lines(data[,"DateTime"], data[,"Sub_metering_3"], col="blue")
  legend("topright", pch="-", col = c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #Had to make this wider to accommodate the legend
  dev.copy(png, "plot3.png", width=700, height=480, units="px")
  dev.off()
}