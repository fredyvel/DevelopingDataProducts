library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Slider App"),

    sidebarLayout(
        sidebarPanel(
            h1("Muevele aqui"),
            sliderInput("slider2","Slide Me!",0,100,0)
        ),
        # Show a plot of the generated distribution
        mainPanel(
            h3("Slider Value:"),
            textOutput("text1")
            
        )
    )
))
