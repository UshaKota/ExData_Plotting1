
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
                gdt<-data.table(NEI)[, list(total=round((sum(Emissions/1000)),2)), by= year]
                return(gdt)
        }
 # write to png
        writeToPNG<- function(filename,dataTable){
                png(filename)
                pri.barplot <-qplot(x=year, y=total,data=dataTable, geom="bar", width = 1.5, main = "Yearly Emissions-PM2.5(M.T) ", fill = total, stat="identity",position="dodge",xlab="year",ylab="Emissions (M.T)")
                print(pri.barplot)
                dev.off()
        }
        bar.dt<-readData()
        #make plot1
        #write the graph to png file
        writeToPNG("plot1.png",bar.dt)

