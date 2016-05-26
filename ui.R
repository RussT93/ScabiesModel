
# This is the user-interface definition of a Shiny web application.

library(shiny)
library(DT)

shinyUI(fluidPage(
  # Application title
  #titlePanel("Peramivir impact modelling in pandemic situation"),
  fluidRow(column(8,h1("Scabies Model")), 
           column(4,
                  img(src='ScabiesModel.png', align = "left", height="200px" ))
  ),
  fluidRow(
    # Sidebar with a slider input for number of bins
    column(4, tabsetPanel(
      tabPanel("Epidemiology",wellPanel(
        sliderInput("a nice variable",
                    "myvar",
                    min = 1,
                    max = 2,
                    value = 1.6, animate=animationOptions(interval=2000), step=0.1)
      )),

      tabPanel("Treatment",wellPanel(
        sliderInput("efficacy1d",
                    "Efficacy of one round of treatment",
                    min = 0,
                    max = 0.5,
                    value = 0.3, animate=T)
      )))),
    # Show a plot of the generated distribution
    column(8,tabsetPanel(
      tabPanel("Epidemiological results",
               tabsetPanel(
                 tabPanel("Epidemic curves", 
                          fluidRow(column(12,plotOutput("curvePlot"))),
                          hr(),
                          fluidRow(column(12,verbatimTextOutput("summaryIncid"))) 
                 ), 
                 tabPanel("Download results", 
                          hr(),
                          fluidRow(downloadButton('downloadData', 'Download')),
                          hr()#,
                          #tableOutput('table')
                 )
               )
      )
      )
    )
    )
  )
)

