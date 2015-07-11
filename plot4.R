library(lubridate)
#Given text file "household_power_consumption.txt" is in the run dir, will plot 4 graphs
plot4 <- function(){
  #Read in the data and select data between 2007-02-01 and 2007-02-02
  data <- read.csv("household_power_consumption.txt", sep=";")
  data["Date2"] <- as.Date(data[,"Date"], "%d/%m/%Y")
  data <- data[data[,"Date2"] >=  as.Date("2007-02-01") & data[,"Date2"] <= as.Date("2007-02-02"),] 
  data["DateTime"] <- paste(data[,"Date"], data[,"Time"])
  data["DateTime"] <- dmy_hms(data[,"DateTime"])
  
  #Convert the relevant columns to numeric format
  data[,"Sub_metering_1"] <- as.numeric(as.matrix(data[,"Sub_metering_1"]))
  data[,"Sub_metering_2"] <- as.numeric(as.matrix(data[,"Sub_metering_2"]))
  data[,"Sub_metering_3"] <- as.numeric(as.matrix(data[,"Sub_metering_3"]))
  data[,"Global_active_power"] <- as.numeric(as.matrix(data[,"Global_active_power"]))
  data[,"Voltage"] <- as.numeric(as.matrix(data[,"Voltage"]))
  data[,"Global_reactive_power"] <- as.numeric(as.matrix(data[,"Global_reactive_power"]))
    
  #Divide plot into 4 sections
  par(mfcol = c(2,2))
  
  #Plot global active power
  plot(data[,"DateTime"], data[,"Global_active_power"],type="l", col="black", main="", xlab="", ylab="Global Active Power")
  
  #Plot sub metering
  plot(data[,"DateTime"], data[,"Sub_metering_1"], main="", ylab="Energy Sub Metering", xlab="", type="l", col="black")  
  lines(data[,"DateTime"], data[,"Sub_metering_2"], col="red")
  lines(data[,"DateTime"], data[,"Sub_metering_3"], col="blue")
  legend("topright", bty="n", pch="-", col = c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #Plot Voltage
  plot(data[,"DateTime"], data[,"Voltage"],type="l", col="black", main="", xlab="datetime", ylab="Voltage")
  
  #Plot Global reactive power
  plot(data[,"DateTime"], data[,"Global_reactive_power"],type="l", col="black", main="", xlab="datetime", ylab="Global_reactive_power")
  
  #Had to make this wider to accommodate the legend
  dev.copy(png, "plot4.png", width=700, height=480, units="px")
  dev.off()
}