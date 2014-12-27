## @knitr ui
require(shiny)
require(rCharts)
require(rjson)
df2 = read.csv("foursquare_checkin.csv", stringsAsFactors = FALSE)

df2$colors = brewer.pal(6, 'RdYlGn')[as.numeric(as.factor(df2$Category))]
mean_lat <- mean(df2$venue_lat) # outcome: 50.90956
mean_lon <- mean(df2$venue_lng) # outcome: 7.576119

require(rCharts)
dat_list <- toJSONArray2(df2,json = F)
fluidPage(
  tags$head(
    tags$style(HTML("    
                    p {
                    font-size: 90%;
                    line-height: 1.1;
                    font-family: Arial;
                    }
                    
                    h1{
                    font-size: 120%;
                    line-height: 1.1;
                    font-weight:400;
                    font-family:Arial;
                    }  
                    
                    
                    
                    "))
    ),
  #application title
  titlePanel(
    "Foursquare Check-in"
  ), 
  
  h1("This visualization i"),
 
  p(
    "Powered by",
    a("Shiny", 
      href = "http://www.rstudio.com/shiny")," and",
    a("RCharts.",
      href = "http://www.r-project.org/"),"Factor analysis and visualization by ",
    a("Mengying Li",
      href="http://mengyingli.github.io")),
  hr(),
  sidebarPanel( 
    checkboxGroupInput("Category",
                       label = "",
                       choices = list("Food & Cafe","Bar","Entertainment & Others",
                                      "Transportation","Shopping","Office"),
                       selected = "Food &  Cafe"
    ),
    actionButton("Uncheck", label="Reset")
  ),
  mainPanel(chartOutput('map_container','leaflet'))
  
)

