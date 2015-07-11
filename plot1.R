
#Given text file "household_power_consumption.txt" is in the run dir, will create a histogram of Global Active Power
plot1 <- function(){
  #Read in the data and select data between 2007-02-01 and 2007-02-02
  data <- read.csv("household_power_consumption.txt", sep=";")
  data[,"Date"] <- as.Date(data[,"Date"], "%d/%m/%Y")
  data <- data[data[,"Date"] >=  as.Date("2007-02-01") & data[,"Date"] <= as.Date("2007-02-02"),] 
  
  #Convert the global active power column to numeric format and save a histogram to file "plot1.png"
  data[,"Global_active_power"] <- as.numeric(as.matrix(data[,"Global_active_power"]))
  hist(data[,"Global_active_power"], col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  dev.copy(png, "plot1.png", width=480, height=480, units="px")
  dev.off()
}