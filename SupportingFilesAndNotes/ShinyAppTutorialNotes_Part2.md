## SHINY APPLICATIONS TUTORIAL NOTES
### Part 2 - "How to customize reactions"

#### 1) Reactivity

- How changes in the input objects (intput$x) propagate to the output objects (output$y).

#### 2) Reactive Values

- Also input values like input$x.
- Reactive values should always be paired with reactive functions, such as renderPlot().

	-----------------------------------------------------
	| server <- function(input, output) {
	|	output$hist <- renderPlot({
	|		hist(rnorm(input$num))
	|	})
	| }
	-----------------------------------------------------



#### 3) Reactive Toolkit (7 indispensible functions)

1) render*() function - Displays output like graphs and charts (as described in Part 1).
2) reactive() function - Builds a reactive object to use (reactive expression).

	For example: Build a reactive object to generate random normal values from the input number.
		     Then use that data object inside the render functions.

	-----------------------------------------------------
	| server <- function(input, output) {
	|	data <- reactive({
	|		rnorm(input$num)
	|	})
	|
	|	output$hist <- renderPlot({
	|		hist(data())
	|	})
	| }
	-----------------------------------------------------

3) isolate() function - Returns the result as a non-reactive value.

	For example: If you don't want the title of a graph to update each time you type a letter.
		     In this case we want the title to be non-reactive. So the title is only looked up
		     when the input$num is changed.

	-----------------------------------------------------
	| server <- function(input, output) {
	|	data <- reactive({
	|		rnorm(input$num)
	|	})
	|
	|	output$hist <- renderPlot({
	|		hist(data(), main = isolate({input$title}))
	|	})
	| }
	-----------------------------------------------------

4) observeEvent() function - This is code that is run at the server end so the user never sees this.
			     This is useful for things like reading from and writing to a file.

	[ observeEvent(input$clocks, { print(input$clicks) }) ]

	input$clicks is the reactive value to respond to and anything inside {} is the code block to run
	whenever observer is invalidated.

	-----------------------------------------------------
	| server <- function(input, output) {
	|	observeEvent(input$clicks, {
	|		print(as.numeric(input$clicks))
	|	})
	| }
	-----------------------------------------------------

5) observe() function - Also triggers code to run on the server. Uses same syntax as render*(), reactive(), and isolate().
			This is the same as observeEvent() however the code gets executed each time the values inside are
			updated.

6) eventReactive() function - delay any reactions until the user wants it to happen.

	For example: You many not want the plot to updated after the user moved the slider until they pressed an "update" button.

	-----------------------------------------------------
	| server <- function(input, output) {
	|	data <- eventReactive(input$go, {
	|		rnorm(input$num)
	|	})
	|
	|	output$hist <- renderPlot({
	|		hist(data())
	|	})
	| }
	-----------------------------------------------------

7) reactiveValues() function - Creates a list of reactive values to manipulate programmatically (usually with observeEvent()).
	[ rv <- reactiveValues(data = rnorm(100)) ]













































