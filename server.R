
#
#library(plyr)
library(shiny)
#library(lattice)
library(ggplot2)
library(data.table)

#library(plotly)
library(DT)

source("SEITS_scabies.R")


shinyServer(function(input, output, session) {
  startyear=2007
  result<-reactive({
    
    newParam=DefaultParameters
    newParam$efficacy1d=input$efficacy1d
    
    result=scabies(updateParam = newParam)
    result$time=as.Date((strptime(paste0(startyear+floor((result$time*7)/365),"/",(result$time*7)%%365),"%Y/%j")))+newParam$lag
    result$Scabiesdata=SmIncid.O[starttraintime:maxtraintime]
    return(result)
  })
  
  ## Draw the curves
  output$curvePlot<-renderPlot({
    data=result()
    #print(data)
    p<-ggplot(data=data, aes(time)) 
    p<- p + geom_line(aes(y=newInf, colour="Model"),size=2, position=position_jitter(width= 0, height= 0)) 
    p<- p + geom_line(aes(y=Scabiesdata, colour="Data"), size=2,linetype="dotted", position=position_jitter(width= 0, height= 0))
    p<- p +   theme(legend.position = "top") + 
    guides(color=guide_legend(title="")) + xlab("") +
    scale_y_continuous(name='New scabies infection per week')
    p
  })

})