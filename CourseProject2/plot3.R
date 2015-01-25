
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
                # get data based on Emissions Type
                balti.fips.emtyp.gdt<-data.table(NEI)[fips=="24510", list(Emissions.MT = Emissions/1000) ,by = list(type,year)]
                return(balti.fips.emtyp.gdt)
        }
 # write to png
        writeToPNG<- function(filename,baltiDT){
                png(filename)
                # get a palette
                my.cols <- brewer.pal(4, "Dark2")
                pal <- colorRampPalette(my.cols) # there was no effect using this??

                #Make the base layer
                balti.scat_plot<-ggplot( baltiDT,aes(year, Emissions.MT))
                #make the titles on x axis rotate by 90deg.
                balti.scat_plot<-balti.scat_plot + theme(axis.text.x = element_text(angle = 90, hjust = 1))
                #change the point size, color, color transparency, adjust the fill colors manually,
                # fix the seq of the x axis and y axis labels
                # add a box line to the scatter for comparison
                balti.scat_plot<-balti.scat_plot + geom_point(aes( color = type),size = 10,alpha=0.1) + scale_color_manual(values=my.cols)+ facet_grid(.~type,space="free_y") + scale_x_continuous(breaks = seq(1997, 2010, by =2 )) + scale_y_continuous(breaks = seq(0, 1.2, by = 0.2)) + geom_smooth(size = 0.5, color = "blue", linetype = 1, method = "lm",se = FALSE)
                print(balti.scat_plot)
                dev.off()
        }
        balti.dt<-readData()
        #make plot2.png for Balitmore city Emissions
        #write the graph to png file
        writeToPNG("plot3.png",balti.dt)

