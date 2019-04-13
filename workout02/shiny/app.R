#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

#' @title Future Value
#' @description calcululate the future value of an investment
#' @param amount initial invested amount
#' @param rate annual rate of return
#' @param years numbers of years
#' @return computed future value
future_value <- function(amount, rate, years) {
  return(amount * (1+rate) ^ years)
}


#' @title Future Value of Annuity
#' @description calcululate the future value of an investment
#' @param contrib contributed amount
#' @param rate annual rate of return
#' @param years numbers of years
#' @return computed future value
annuity <- function(contrib, rate, years) {
  return((contrib * ((1+rate)^years - 1)/rate))
}


#' @title Future Value of Growing Annuity
#' @description calcululate the future value of an investment
#' @param contrib contributed amount
#' @param rate annual rate of return
#' @param growth annual growth rate
#' @param years numbers of years
#' @return computed future value of growing annuity
growing_annuity <- function(contrib, rate, growth, years) {
  return((contrib * ((1+rate)^years - (1+growth)^years)/(rate-growth)))
}


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Workout02-David-Choi"),
   
   fluidPage(
     fluidRow(
       column(4, sliderInput("initAmount",
                             "Initial Amount",
                             min = 0,
                             max = 100000,
                             value = 1000,
                             step = 500,
                             pre = "$"),
              sliderInput("AnnCont",
                          "Annual Contribution",
                          min = 0,
                          max = 50000,
                          value = 2000,
                          step = 500,
                          pre = "$")),
       column(4, sliderInput("rRate",
                             "Return Rate (in %)",
                             min = 0,
                             max = 20,
                             value = 5,
                             step = 0.1),
              sliderInput("gRate",
                          "Growth Rate (in %)",
                          min = 0,
                          max = 20,
                          value = 2,
                          step = 0.1)),
       column(4, sliderInput("year",
                             "Years",
                             min = 0,
                             max = 50,
                             value = 20,
                             step = 1),
              selectInput("facet", 
                          "Facet?",
                          choice = c("No", "Yes")))
     )
     # Show a plot of the generated distribution
   ),
   hr(),
   column(12, h4("Timelines"),
          plotOutput("distPlot")),
   column(12, h4("Balances"),
          verbatimTextOutput("summary"))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  df_modal <- reactive({
    year <- 0:input$year
    init <- input$initAmount
    ann <- input$AnnCont
    rate <- input$rRate/100
    
    no <- c(init)
    fixed <- c(init)
    growing <- c(init)
    for(i in 1:input$year) {
      fv <- future_value(init, rate, i)
      fva <- annuity(ann, rate, i)
      fvga <- growing_annuity(ann, rate, input$gRate/100, i)
      no <- c(no, fv)
      fixed <- c(fixed, fv+fva)
      growing <- c(growing, fv+fvga)
    }
    modalities <- data.frame(year = year, no_contrib = no, fixed_contrib = fixed, growing_contrib = growing)
    return(modalities)
  })
  
   output$distPlot <- renderPlot({
     lbs <- c("no_contrib", "fixed_contrib", "growing_contrib")
     t <- factor(1:3, labels = lbs)
     
     year <- df_modal()$year
     no <- df_modal()$no_contrib
     fixed <- df_modal()$fixed_contrib
     growing <- df_modal()$growing_contrib
     
     df <- data.frame(
       year = rep(year, 3),
       value = c(no, fixed, growing),
       variable = rep(t, each = length(year))
     )
     if (input$facet == "No") {
       df %>% ggplot(aes(x = year, y = value, group = variable)) + geom_path(aes(color = variable), size = 1) + geom_point(aes(color = variable)) + ggtitle("Three modes of investing") + scale_color_discrete(labels = c("no_contrib", "fixed_contrib", "growing_contrib"))
     } else {
       df %>% ggplot(aes(x = year, y = value, group = variable)) + geom_path(aes(color = variable), size = 1) + geom_point(aes(color = variable)) + geom_area(aes(fill = variable), alpha = 0.4) + ggtitle("Three modes of investing") + scale_color_discrete(labels = lbs) + scale_fill_discrete(labels = lbs) + facet_wrap(df$variable) + theme_bw()
     }
   })
   output$summary <- renderPrint({
     df_modal()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

