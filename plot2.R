library(lubridate)
#Given text file "household_power_consumption.txt" is in the run dir, will plot Global Active Power against Date
plot2 <- function(){
  #Read in the data and select data between 2007-02-01 and 2007-02-02
  data <- read.csv("household_power_consumption.txt", sep=";")
  data["Date2"] <- as.Date(data[,"Date"], "%d/%m/%Y")
  data <- data[data[,"Date2"] >=  as.Date("2007-02-01") & data[,"Date2"] <= as.Date("2007-02-02"),] 
  data["DateTime"] <- paste(data[,"Date"], data[,"Time"])
  data["DateTime"] <- dmy_hms(data[,"DateTime"])
   
  #Convert the global active power column to numeric format and save a plot of this against the date to file "plot2.png"
  data[,"Global_active_power"] <- as.numeric(as.matrix(data[,"Global_active_power"]))
  plot(data[,"DateTime"], data[,"Global_active_power"], main="Global Active Power", ylab="Global Active Power (kilowatts)", xlab="", type="l")
  dev.copy(png, "plot2.png", width=480, height=480, units="px")
  dev.off()
}