
#Declare Libraries
        library(plyr)
        library(dplyr)
        library(lattice)
        library(scales)
        library(ggplot2)
        library(RColorBrewer)
        library(data.table)
        library(stringi)


# read massive data
        NEI <- readRDS("summarySCC_PM25.rds")
        SrcClsTbl <- readRDS("Source_Classification_Code.rds")

 #read data required for the plot
        readData <- function(){
                fips.gdt<-data.table(NEI)[, list(total=round((sum(Emissions/1000)),2)), by= list(fips,year)]
                balti.gdt<-fips.gdt[(which(fips=="24510")),]
                return(balti.gdt)
        }
 # write to png
        writeToPNG<- function(filename,baltiDT){
                png(filename)
                balti.barplot <-qplot(x=year, y=total,data=baltiDT, geom="bar", width = 1.5, main = "Yearly Total Emissions-PM2.5(M.T) in Baltimore City ", fill = total, stat="identity",position="dodge",xlab="year",ylab="Emissions (M.T)")
                print(balti.barplot)
                dev.off()
        }
        balti.dt<-readData()
        #make plot2.png for Balitmore city Emissions
        #write the graph to png file
        writeToPNG("plot2.png",balti.dt)

