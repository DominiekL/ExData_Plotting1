plot4 <- function(file="household_power_consumption.txt"){
  
  ## subpress warnings that occur during the loading of the file
  options(warn=-1)
  library("data.table")
  ## read the file, NA values are equal to "?"
  z<-fread(file,na.strings="?")
  ## add a datetime column, based on the text values for date and time
  z[,datetime:=as.POSIXct(strptime(paste(z$Date,z$Time),"%d/%m/%Y %H:%M:%S"))]
  ## only take values for a specific time period
  z<-subset(z,datetime %between% c("2007-02-01","2007-02-03"))
  
  ## plot histogram to png file
  png("plot4.png")
  par(mfrow=c(2,2))
  plot(z$datetime,z$Global_active_power,type="line",xlab="",ylab="Global Active Power")
  plot(z$datetime,z$Voltage,type="line",xlab="datetime",ylab="Voltage")
  plot(z$datetime,z$Sub_metering_1,type="line",xlab="",ylab="Energy sub metering")
  points(z$datetime,z$Sub_metering_2,type="line",col="red")
  points(z$datetime,z$Sub_metering_3,type="line",col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1,lty=1,bty="n")
  plot(z$datetime,z$Global_reactive_power,type="line",xlab="datetime",ylab="Global_reactive_power")
  x<-dev.off()
}