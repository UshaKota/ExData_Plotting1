
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
                par(mar=c(2,4,2,2))
                #par(mfrow=c(2,2),oma = c(0,0,0,0) + 0.1,mar=c(4,4,1,1))
                png(filename)
                hist(dataTable$Global_active_power,col="red",main="Global Active Power",breaks=seq(0,8,by=0.5),xlab="Global_active_power(kilowatts)")

                rug(dataTable$Global_active_power,side=1)
                dev.off()

        }

        filename<-("household_power_consumption.txt")
        myDT<-readData(filename,date1<-c("2007-02-01"),date2<-c("2007-02-03"))
        writeToPNG("plot1.png",myDT)
        #plot1 graph
        #
        #myDT$DateTime<- as.POSIXct(paste(myDT$Date, myDT$Time)



       # par(mfrow=c(2,2),oma = c(0,0,0,0) + 0.1,mar=c(4,4,1,1))
       # par(mar=c(1,4,1,1))
        #plot(myDT$DateTime, myDT$Global_active_power,type='l',xlab="",ylab="Global Active Power(kilowatts)")

        #par(mar=c(4,4,1,1))
#         plot(myDT$DateTime, myDT$Voltag, type ='l',xlab="Datetime", ylab="Voltage")
#         plot(myDT$DateTime, myDT$Sub_metering_1,type='l', lwd=2, xlab="",ylab="Energy sub metering")
#         lines(myDT$DateTime, myDT$Sub_metering_2,col = "red")
#         lines(myDT$DateTime, myDT$Sub_metering_3, col="blue")
#         legend("topright",inset=-0.1,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),bty="n",col=c("black", "red", "blue"),cex=0.5)
#
#
#         plot(myDT$DateTime, myDT$Global_reactive_power, type ='l', xlab="Datetime",ylab="Global Reactive Power")
#
#
#
#
#
#
