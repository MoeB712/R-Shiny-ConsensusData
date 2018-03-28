## Project
##### "Shiny Web Application using Census Employment and Earnings Data in Michigan"

## Summary
Everyone has been talking about how the economy is slowly improving and the number of jobs 
available is going up. I got curious and found data related to Employment and Earnings from
2010 to 2015 for different states. I will be focusing on Michigan specifically for this
project. Using this data, I can issolate the data by total employement, individual employment,
employment by firms, and total earnings. I can even differentiate this data by groups such as
time, firm size and age, and worker characterictics such as age, race, gender, and ethnicity.

My goal is to turn this data from tables, to visualizations by using the Shiny web application
framework. Shiny is a framework for R and works with Rstudio. I will use R and Rstudio to
learn Shiny and create interactive web applications so that it will be easier to visualize
the data and see how employment and earning are affected within the last 5 and in particular
see which groups are affected the most.



## Tools and Languages
 * R
 * Rstudio
 * Shiny Framework


## Data Needs and Sources
The data that I'll be working with is found on the census.gov website here:
"https://qwiexplorer.ces.census.gov/static/explore.html"

The first challenge that I'll probably come across is figuring out how to structure the data
and combine the files into a "master" spreadsheet to work with. Since there are so many groups
and the data can be filtered in many ways, I would need to figure out exactly what I'm looking
for in this data and prepare it appropriately so that it'll be easier to analyze it.

My next big challenge will definitely be the Shiny framework. R is fairly new to me but I do
have a general understanding of the language. However on top of R and Rstudio, I'll have to
learn the Shiny framework. The main website "https://shiny.rstudio.com/" has some pretty 
useful tutorials that I'll use before I start working with my data.

Some other challenges are probably common to anyone who is doing data analysis. Figuring out
what and how exactly I'm going to graph, chart, and model the data to answer my questions.
I will probably try to come up with questions and ways to visualize the answers before working
with the Shiny framework (maybe create bullet point notes in Word to outline my data?).

A small challenge might be getting the Shiny framework working with my Rstudio since I'm be
doing this in Linux on a virtual machine. But I'm sure the Shiny website will have
instructions on how to get it setup on the machine.

These are some, but I'm sure there will probably be more challenges that come up...



## Personal Learning Objectives
I will continue to get a better understanding of R and Rstudio. I will also have to learn the
general modeling techniques so that my data and graphs aren't random and they help visualize
my data coherently so that they make sense. These concepts will also be applicable to any
data analysis regardless of the software (Rstudio, Excel, etc.) or language (R, Python, etc.)
I use.

My biggest learning object though is to learn the Siny framework on top of R to make my
visualizations more interactive.



## Prep Instructions
1) Packages needed to be installed:

* install.packages("shiny")

Note: It took me a while to get Choroplethr packages to work and installed. These packages are for plotting maps. However I couldn't get them to work. So no need to install them. I've tried to use leaflet as well, however I couldn't get that to work either..The code is in the server function.

* install.packages("choroplethr")
* install.packages("choroplethrMaps")

2) Run `RStudio_Files.Rproj` to load Rstudio and see the code.

3) The web application can be run in a separate window, in a browser, or inside the Rstudio viewer panel. This option is available right next to the `Run App` button.



That's it!!

I've also includes some supporting files I've typed up when I was learning to use Shiny. The files can be found in `/SupportingFilesAndNotes`.

