## SHINY APPLICATIONS TUTORIAL NOTES
### PART 3 - "How to customize appearance"

All code that modified the appearance of the HTML page will be inside the fluidPage() function which creates a UI object.

#### 1) Static Elements

- Shiny proivdes R functions to recreate HTML tags.

	`tags$h1() <=> <h1></h1>`
	`tags$a()  <=> <a></a>`

	Can use `names(tags)` to see all different HTML names that can be associated with a tag.

- Nested tags:
```
	fluidPage(
		tags$p("This is a", tags$string("Shiny"), "app.")
	)
```
- `tags$br()`: Line break
- `tags$hr()`: Horizontal line

- Images:
```
	fluidPage(
		tags$img(height = 100,
			 width = 100,
			 src = "http://www.rstudio.com/images/RStudio.2x.png")
	)
```
	Note - All images (if not taken from the web) should be inside a `www` folder. Then browser will make anything inside
	       that folder accessible to the web browser. Then just use the file name as the src instead of a URL.

Reference: htmlTagFunctions.png for a list of all tags.

#### 2) Layout

- fluidRow(): Divides the page and adds a new 'row container' to the page. This can be used multiple times.
- column():   Works with fluidRow() to place different objects into different columns inside the row container.

	Example: This page have 2 row containers. In the first row, we have 2 columns. In the column function, the first parameter
		 specified the width of the column. So the first column had a width of 3 units, and the second has a width of 5 units.
		 In the second row container, there is also an offset argument which shows how much that column will offset from the
		 start of the row.
	Note: You can't have a column more than 12 units.	
```
	ui <- fluidPage(
		
		fluidRow(
			column(3),
			column(5)),
		fluidRow(
			column(4, offset = 8)
	)
```
- Placing objects inside the containers:

	Example:
```
	fluidPage(
		fluidRow(
			column(3),
			column(5, sliderInput(...))
		)
		fluidRow(
			column(4, offset = 8, plotOutput("hist"))
		)
	)
```


#### 3) Layers of Panels

- wellPanel(): You can group elements using this function if you put the sliderInput, textInput, etc. into this function. This will combine
	the two elements into a nice container automatically adjusting the width of everything to match.

	Reference `panelList.png` for a list of different panels.

