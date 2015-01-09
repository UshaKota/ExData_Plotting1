
        library(data.table)
        ## is there an elegant way to set the global var filename??


        readData <- function(filename, var1, var2){

                dtime <- difftime(as.POSIXct(var2), as.POSIXct(var1),unit="mins")
                numRows <- as.numeric(dtime)

                DT <- fread(filename, skip="1/2/2007", nrows = numRows, na.strings = c("?", ""))
                ##set the colnames
                setnames(DT, colnames(fread(filename, nrows=0)))
                return(DT)


        }

        filename<-("household_power_consumption.txt")
        myDT<-readData(filename,date1<-c("2007-02-01"),date2<-c("2007-02-03"))
        #plot1 graph
        par(mar=c(2,2,2,2))
        hist(myDT$Global_active_power,col="red",main="Global Active Power",breaks=seq(0,8,by=0.5),xlab="Global_active_power(kilowatts)")



