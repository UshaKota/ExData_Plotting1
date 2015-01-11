
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
                png(filename)
                plot(myDT$DateTime, myDT$Sub_metering_1,type='l', lwd=2, xlab="",ylab="Energy sub metering")
                lines(myDT$DateTime, myDT$Sub_metering_2,col = "red")
                lines(myDT$DateTime, myDT$Sub_metering_3, col="blue")
                legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black", "red", "blue"))
                dev.off()

        }
        #Assumption is that the data file is in the working dir
        filename<-("household_power_consumption.txt")

        #get the data set
        myDT<-readData(filename,date1<-c("2007-02-01"),date2<-c("2007-02-03"))

        #write the graph to png file
        writeToPNG("plot3.png",myDT)
