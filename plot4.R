
        library(data.table)
        ## is there an elegant way to set the global var filename??


        readData <- function(filename, var1, var2){

                dtime <- difftime(as.POSIXct(var2), as.POSIXct(var1),unit="mins")
                numRows <- as.numeric(dtime)

                DT <- fread(filename, skip="1/2/2007", nrows = numRows, na.strings = c("?", ""))
                ##set the colnames
                setnames(DT, colnames(fread(filename, nrows=0)))
                DT$DateTime = as.POSIXct(paste(DT$Date, DT$Time),format = "%d/%m/%Y %H:%M:%S")
                return(DT)


        }


        writeToPNG<- function(filename,dataTable){
                #set the margin
                png(filename)
                par(mfrow=c(2,2),oma = c(0,0,0,0) + 0.1,mar=c(4,4,1,1))

                plot(dataTable$DateTime, dataTable$Global_active_power,type='l',xlab="",ylab="Global Active Power(kilowatts)")

                plot(dataTable$DateTime, dataTable$Voltage, type ='l',xlab="Datetime", ylab="Voltage")

                plot(dataTable$DateTime, dataTable$Sub_metering_1,type='l', lwd=2, xlab="",ylab="Energy sub metering")
                lines(dataTable$DateTime, dataTable$Sub_metering_2,col = "red")
                lines(dataTable$DateTime, dataTable$Sub_metering_3, col="blue")
                legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",lty=c(1,1,1),col=c("black", "red", "blue"),cex=0.5)
                plot(dataTable$DateTime, dataTable$Global_reactive_power, type ='l', xlab="Datetime",ylab="Global Reactive Power")



                #rug(dataTable$DateTime,side=1)
                dev.off()

        }
        #Assumption is that the data file is in the working dir
        filename<-("household_power_consumption.txt")

        myDT<-readData(filename,date1<-c("2007-02-01"),date2<-c("2007-02-03"))

        #write the graph to png file
        writeToPNG("plot4.png",myDT)
