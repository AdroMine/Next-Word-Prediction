
require(shiny)
require(data.table)
require(quanteda)
load("data/ngrams.Rdata")
source("getNextWords.R",local = TRUE)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
     output$predict <- renderText({
          if(input$str=="")
               return("You haven't entered anything yet!")
          predictions <- nextWord(input$str,input$n)
          paste0(1:input$n,".",predictions,"\n")
     })
})
