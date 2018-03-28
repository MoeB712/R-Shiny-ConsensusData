#install packages
#install.packages("shiny")
#install.packages("choroplethr")
#install.packages("choroplethrMaps")

#import libraries
library(shiny)
library(ggvis)
library(dplyr)
#library(choroplethrMaps)
#library(choroplethr)

#Load the data State and County data
EmpCtByState  <- read.csv("data/Country/EmpCountByState.csv", header = TRUE, sep = ",")
HireCtByState <- read.csv("data/Country/HireCountByState.csv", header = TRUE, sep = ",")

#Load Employment Count data
EmpCountByAge <- read.csv("data/EmpCountByAge.csv", header = TRUE, sep = ",")
EmpCountByGender <- read.csv("data/EmpCountByGender.csv", header = TRUE, sep = ",")
EmpCountByEdu <- read.csv("data/EmpCountByEducation.csv", header = TRUE, sep = ",")
EmpCountByFirmSize <- read.csv("data/EmpCountByFirmSize.csv", header = TRUE, sep = ",")

#Load Hire Count data
HireCountByAge <- read.csv("data/HireCountByAge.csv", header = TRUE, sep = ",")
HireCountByGender <- read.csv("data/HireCountByGender.csv", header = TRUE, sep = ",")
HireCountByEdu <- read.csv("data/HireCountByEducation.csv", header = TRUE, sep = ",")
HireCountByFirmSize <- read.csv("data/HireCountByFirmSize.csv", header = TRUE, sep = ",")

#Load Total Hire and Employment Counts
totalCounts <- read.csv("data/TotalEmpAndHireCounts.csv", header = TRUE, sep = ",")

#Get years
year <- totalCounts$Year

# Define UI for application
ui <- fluidPage(
   
   # Application title
   titlePanel("Employment Trend in Michigan Using Shiny"),
   hr(),
   br(),
   
   #New Header
   h3("Project and Data Description"),
   
   p(style="font-size:130%;", "People always wonder about job security and how the economy affect how many employees a firm will hire. The U.S. Census Bureau has published", 
     a(href="https://qwiexplorer.ces.census.gov/", " data "),
     "that shows all of the	employement records from the end of 2011 to early 2016."),
   
   p(style="font-size:130%;", "With this data, we can take a look at the number of employees firms hire over the period of 5 years, ",
     "we can see how many people are employed and how many people are hired over the 5 years, and we can even split the data by different groups, ",
     "including Gender, Age, and Education. With this data, we can pin-point when hires tend to be the lowest or highest, what age are firms ",
     "looks for when hiring, and what kind of education is required nowadays to get employed."),
   
   p(style="font-size:130%;", "Looking at data points that are very close together, such as first quarter and fourth quarter in the same year ",
     "will not give us a very accurate idea as to whether or not the numbers are actually increasing from year to year. That is why we will be ",
     "looking at the 'overall trend' or the data and see if it's going in the positive or negative direction."),
   
   p(style="font-size:130%;", "So much data is available and it can be divided into many groups. So instead of creating multiple plots and charts ",
     "using R, I've decided to create an interractive Web Application so that the user is able to filter the results as desired."),
   br(),
   hr(),
   
   #New Header
   h3("Shiny Web Apps, What is it? How does it work?"),
   
   p(style="font-size:130%;", "Shiny Web Applications is a great way to convert static plots and graphs to make them more interactive. The user ",
     "has the control on how he was to filter the graph what what sort of data he would like to see. This also give a rich more pleasant user ",
     "interface that gives a better experience when sharing or viewing the data."),
   
   p(style="font-size:130%;", "So how exactly does it work? All Shiny Web Apps have a Client/Server type relationship. R scripts are run on a server. ",
     "In this case, we are hosting the application on our computer so our computer 'serves' the web page by running various R scripts that are ",
     "created. When the web page is updated, the computer reruns the scripts to regenerate the graphs."),
   
   p(style="font-size:130%;", "There are two main components to a Shiny Application. First component is the User Interface (UI). This is the web ",
     "page users see and interact with. This is practically an HTML page, however the Shiny R code generates the HTML for us. Using several inputs shown ",
     "below, we can retrieve what the user wants and 'filter' out data. ", br(), br(),
     img(src="typesOfInputs.PNG", align = "center"), br(), br(),
     "And the second componet is the server instructions. This is a set of instructions written in R that tells the server what to do when the user changes ",
     "parameters on the web page. All of the elements on the page that the user interacts with (text boxes, slide bars, etc.) are knows as inputs ",
     "and all elements that get generates (such as graphs and plots) are known as outputs. Using a combination of these components, we create a ",
     "web page that run R scripts so the user is able to interact with it."),
   br(),
   hr(),
   
   #New Header
   h3("Retrieve Data"),
   p(style="font-size:130%;", "Before we can proceed with any work, we have to load the data. Since we have multiple CVS files for data, we'll make ",
     "multiple objects."),
   
   code("EmpCtByState  <- read.csv(\"data/Country/EmpCountByState.csv\", header = TRUE, sep = \",\")"),
   br(),
   code("HireCtByState <- read.csv(\"data/Country/HireCountByState.csv\", header = TRUE, sep = \",\")"),
   br(),
   br(),
   
   #New Header
   h3("Maps"),
   
   fluidRow(
      sidebarPanel(
         selectInput("mapType", "Choose a map:", c("US", "Michigan"), width = 300),
         selectInput("dataToDisplayOnMap", "Choose what to display:", c("Total Employments", "Total Hires"), width = 300),
         hr(),
         sliderInput("mapYear", "Select year to show", min = 2011, max = 2016, value = 2016),
         width=3
      ),
      mainPanel(
         p(style="font-size:130%;", "To first get an idea of a Shiny application, I've created a map of United States showing the total employee and ",
           "hire count by state. The user is able to select to show on the map by States, or map of MI and filter by Counties, they can also filter by year."),
         br(),
         #show map here
         plotOutput("map"),
         br()
###########################
      )
   ),
   br(),
   hr(),
   h3("Deeper Look and Overall Trend"),
   p(style="font-size:130%;", "Now lets take a look at the numbers in detail and try to figure out a trend. The graph below plots various different counts ",
     "divided by different groups like age, gender, education, etc. The user is able to use the filters to view the different data."),
   
   fluidRow(
      column(3,
             wellPanel(
                selectInput("group", "Choose a group to display", c("Age", "Gender", "Education", "Firm Size")),
                hr(),
                selectInput("ageRange", "Age Range", c("14-18" = 1, "19-21" = 2, "22-24" = 3, "25-34" = 4, "35-44" = 5, "45-54" = 6, "55-64" = 7, "65-99" = 8)),
                radioButtons("gender", "Gender", c("Male", "Female"), inline = TRUE),
                selectInput("education", "Education", c("UnderHighschool" = 1, "Highschool" = 2, "Associate" = 3, "Bachelors" = 4, "Underage" = 5)),
                selectInput("firmSize", "Firm Size", c("0-19 Employees" = 1, "20-49 Employees" = 2, "50-249 Employees" = 3, "250-499 Employees" = 4, "500+ Employees" = 5))
             )
      ),
      column(4,
             #Plot graph for Employment Counts
             ggvisOutput("plotEmploymentCounts"),
             br()
      ),
      column(5,
             #Histogram graph for Hire Counts
             ggvisOutput("plotHireCounts")
      )
   ),
   br(),
   
   p(style="font-size:130%;", "Now that we looked at some of the groups, let's take a look at the line graph below and see what the overall trend is for employement ",
     "as well as number of employee hires."),
   br(),
   radioButtons("totalsDisplay", "Totals to display", c("Employment Totals", "Hire Totals"), inline = TRUE),
   plotOutput("lineChartTotals"),
   br(),
   br(),
   br(),
   br(),
   br(),
   br(),
   hr(),
   
   #New Header
   h3("Summary"),
   
   p(style="font-size:130%", "This is just the tip of the iceberg when it comes to Shiny Web Applications. We were able to look at similar data	and filter that data using ",
     "several input methods (like drop down, radio buttons, slider, etc.). Using these inputs we were able to filter the graphs to show the data the user is interested in ",
     "and then make observations. Even though this application was hosted on one computer, it can easily be added to an actual server so that multiple users can have access ",
     "to it."),
   p(style="font-size:130%", "Overall I think this was a great learning experience. Making things convenient and easily understandable is always important when it comes to ",
     "communication in a workplace. I have watch many videos and tutorials before I began	working on the project. Most convenient source was the",
     a(href = "http://shiny.rstudio.com/tutorial/", "Shiny Tutorial page"), " since it outlines all the basic elements of a Shiny Web Application and more in depth ",
     "documentation in the articles	section."),
   
   p(style="font-size:130%", "I haven't accomplished much since I have spent quite a bit of time reading through documentations and learning the tool itself, however if I ",
     "did have more time to work on it, I would've tried to build a few models with other data sets and visually represent them using Shiny. There are many other tools I ",
     "haven't used that are available with this so I would also try to utilize each visualization tool Shiny provides."),
   
   br(),
   br(),
   p(style="font-size:90%", "Data found on: ", a(href = "https://qwiexplorer.ces.census.gov/", "https://qwiexplorer.ces.census.gov/")),
   p(style="font-size:90%", "Shiny documentation: ", a(href = "http://shiny.rstudio.com/", "http://shiny.rstudio.com/"))
)

# Define server logic
server <- function(input, output, session) {
   
   #Plot maps
   output$map <- renderPlot({
      
      #Build a data frame to mape based on year selected
      # if (input$dataToDisplayOnMap == "Total Employments"){
      #    map_df <- data.frame(EmpCtByState[input$mapYear%%10,])
      # }
      # else if(input$dataToDisplayOnMap == "Total Hires"){
      #    map_df <- data.frame(HireCtByState[input$mapYear%%10,])
      # }
      # 
      # #Create a title
      # title = "Employment Counts in US by State"
      # 
      # #Loading progress bar
      # progress = shiny::Progress$new()
      # on.exit(progress$close())
      # progress$set(message = "Creating image. Please wait.", value = 0)
      # 
      # 
      # #Plot the maps
      # if (input$mapType == "US"){
      #    state_choropleth(map_df,
      #                     title = title)
      # }
      # else if(input$mapType == "Michigan"){
      #    county_choropleth(map_df,
      #                     title = title)
      # }
   })
   
   #Plot a scatter plot for employment counts
   output$plotEmploymentCounts <- reactive({
      
      #Store group value the user selected
      group <- input$group
      
      #Build data based on group
      if (group == "Age") {plotData <- EmpCountByAge[,as.numeric(input$ageRange)+2]}
      else if (group == "Gender") {plotData <- EmpCountByGender[,input$gender]}
      else if (group == "Education") {plotData <- EmpCountByEdu[,as.numeric(input$education)+2]}
      else if (group == "Firm Size") {plotData <- EmpCountByFirmSize[,as.numeric(input$firmSize)+2]}
      
      #Create a Data Frame by combining the years and data
      dataDF <- data.frame(Year = year, Data = plotData)
      
      #Plot the data
      dataDF %>%
         ggvis(x = ~Year, y = ~Data) %>%
         layer_points(size := 100, size.hover:= 200,
                      fillOpacity := 0.5, fillOpacity.hover := 1) %>%
         add_axis("x", title = "Years", values = seq(2011, 2016, by = 1)) %>%
         add_axis("y", title = "") %>%
         set_options(width = 400, height = 450) %>% 
         layer_smooths(span = 1, stroke := "red") %>%
         bind_shiny("plotEmploymentCounts")
      
   })
   
   #Plot a histogram for hire counts
   output$plotHireCounts <- reactive({
      
      #Store group value the user selected
      group <- input$group
      
      #Build data based on group
      if (group == "Age") {plotData <- HireCountByAge[,as.numeric(input$ageRange)+2]}
      else if (group == "Gender") {plotData <- HireCountByGender[,input$gender]}
      else if (group == "Education") {plotData <- HireCountByEdu[,as.numeric(input$education)+2]}
      else if (group == "Firm Size") {plotData <- HireCountByFirmSize[,as.numeric(input$firmSize)+2]}
      
      #Create a Data Frame by combining the years and data
      dataDF <- data.frame(Year = year, Data = plotData)
      
      #Plot the data
      dataDF %>%
         ggvis(~Year, ~Data, fill := "white") %>%
         layer_bars(width = 0.9) %>%
         add_axis("x", title = "Years", values = seq(2011, 2016, by = 1)) %>%
         add_axis("y", title = "") %>%
         set_options(width = 400, height = 450) %>% 
         layer_smooths(span = 1, stroke := "red") %>%
         bind_shiny("plotHireCounts")
      
   })
   
   #Plot the line chart for Employment and Hire totals
   output$lineChartTotals <- renderPlot({
      #Get data based on radio input
      chartData <- switch(input$totalsDisplay,
                          "Employment Totals" = totalCounts[,3],
                          "Hire Totals" = totalCounts[,4]
      )
      #Display chart title
      chartTitle <- switch(input$totalsDisplay,
                           "Employment Totals" = "Total Employment Count from 2011 to 2016",
                           "Hire Totals" = "Total Hire Count from 2011 to 2016"
      )
      #Get ranges for X-Axis and Y-Axis
      xrange <- range(year)
      yrange <- switch(input$totalsDisplay,
                       "Employment Totals" = range(totalCounts[,3]),
                       "Hire Totals" = range(totalCounts[,4])
      )
      #Plot the data
      plot(xrange, yrange, type = "n", xlab = "Year", ylab = "Count", main = chartTitle)
      lines(year, chartData, col = "blue", lwd = 3)
   }, height = 500, width = 600)
   
}

# Knit the ui and server, then run the application 
shinyApp(ui = ui, server = server)

