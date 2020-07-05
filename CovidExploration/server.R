#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(stringr)
library(ggplot2)
# Define server logic required to draw a histogram-
shinyServer(function(input, output) {
    DataCovid <- read.csv("descarga.csv")
    DataCovid$dateRep<-as.Date(DataCovid$dateRep,format='%d/%m/%Y')
    DataCovid$countriesAndTerritories<-as.character(DataCovid$countriesAndTerritories)
    # unique(DataCovid$countriesAndTerritories)
    data<-DataCovid
    # countrie<-'Guatemala'
    # class(DataCovid)
    #?data.frame
    # data<-DataCovid
    totalCases<-data[0,0]
    countries<-unique(data$countriesAndTerritories)
    
    for(countrie in countries)  {
        
        dataAux<-data[which(data$countriesAndTerritories==countrie),]
        dataAux<-dataAux[order(dataAux$dateRep),]
        dataAux<-cbind(dataAux,0,0)
        
        names<-c(colnames(data),'TotalCase','totalDeath')
        
        colnames(dataAux)<-names
        rownames(dataAux)<-c(1:nrow(dataAux))
        
        for( i in 1:nrow(dataAux)){
            # i=85
            if(i==1) dataAux$totalDeath[i]=dataAux$deaths[i] else dataAux$totalDeath[i]=dataAux$deaths[i]+dataAux$totalDeath[i-1]
        }
        for( i in 1:nrow(dataAux)){
            # i=85
            if(i==1) dataAux$TotalCase[i]=dataAux$cases[i] else dataAux$TotalCase[i]=dataAux$cases[i]+dataAux$TotalCase[i-1]
        }
        dataAux<- dataAux[which(dataAux$TotalCase!=0),]
        dataAux$dayPerInit<-c(1:nrow(dataAux))
        totalCases<-rbind(totalCases,dataAux)
  
    }
    
    
    
    
    output$plotConfirmados <- renderPlot({
        
        # generate bins based on input$bins from ui.R
        dataset<-  totalCases
        # dataset<-resultTotales
        # cty<-'Italy'
        # name<-unique(as.character(resultTotales$countriesAndTerritories))[1:3]
        
        countriData<-dataset[0,0]
        for(cty in input$Ciudades){
            dataAux<-dataset[which(dataset$countriesAndTerritories==cty),]
            countriData<-rbind(countriData,dataAux)
            # View(countriData)
        }
        gg1<-ggplot(countriData,aes(x=dayPerInit,y=TotalCase))
        gg1<-gg1+geom_line(aes(color=countriesAndTerritories,linetype=countriesAndTerritories))
        gg1<-gg1+ylab("Total Confirmed Cases")+ylab("Days Fince First Confirmed Case")
        gg1
        
    })
    output$plotMuertes <- renderPlot({
        
        # generate bins based on input$bins from ui.R
        dataset<-  totalCases
        # dataset<-resultTotales
        # cty<-'Italy'
        # name<-unique(as.character(resultTotales$countriesAndTerritories))[1:3]
        
        countriData<-dataset[0,0]
        for(cty in input$Ciudades){
            dataAux<-dataset[which(dataset$countriesAndTerritories==cty),]
            countriData<-rbind(countriData,dataAux)
            # View(countriData)
        }
        gg1<-ggplot(countriData,aes(x=dayPerInit,y=totalDeath))
        gg1<-gg1+geom_line(aes(color=countriesAndTerritories,linetype=countriesAndTerritories))
        gg1<-gg1+ylab("Total Death")+ylab("Days Fince First Confirmed Case")
        gg1
        
    })
    
    #output$out1 <- renderText(dataAux$year[1])
        
})
