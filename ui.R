
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
      tabPanel("Medical Recommendations",wellPanel(
        sliderInput("g",
                    "Proportion of cases well treated (Tw) : Tw = 2 rounds",
                    min = 0,
                    max =1,
                    value =  0.395, animate=T),
     
        sliderInput("e",
                    "Proportion of contact individuals treated with prophylaxis",
                    min = 0,
                    max =1,
                    value =  0.532, animate=T)
      )),

      tabPanel("Treatment",wellPanel(
        sliderInput("efficacy1d",
                    "Efficacy of one round of treatment",
                    min = 0,
                    max = 0.5,
                    value = 0.3, animate=T),
        sliderInput("efficacy2d",
                    "Efficacy of the second round of treatment",
                    min = 0,
                    max = 1,
                    value = 0.95, animate=T)
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

