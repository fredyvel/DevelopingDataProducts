#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(stringr)
library(ggplot2)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
        
    download.file('https://opendata.ecdc.europa.eu/covid19/casedistribution/csv','descarga.csv'),
    DataCovid <- read.csv("descarga.csv"),
    DataCovid$countriesAndTerritories<-as.character(DataCovid$countriesAndTerritories),
  
  
    # Application title
    titlePanel("Select Country"),
    selectInput(
        "Ciudades",
        "Variable:",
        unique(DataCovid$countriesAndTerritories),
        multiple = TRUE
    ),
    
              
        mainPanel(
            plotOutput('plotConfirmados'),
            plotOutput('plotMuertes')
    )
))
