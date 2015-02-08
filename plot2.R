plot2 <- function(file="household_power_consumption.txt"){
  
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
  png("plot2.png")
  plot(z$datetime,z$Global_active_power,type="line",xlab="",ylab="Global Active Power (kilowatts)")
  x<-dev.off()
}