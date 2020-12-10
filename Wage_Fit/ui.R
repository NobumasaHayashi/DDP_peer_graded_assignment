library(shiny)

shinyUI(fluidPage(
    titlePanel("Predict Wage from Three parameters"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("slideAge", "What is your age?", 18, 80, value = 50),
            radioButtons("radio1", label = "Choose your job class",
                         choices = list("Industrial" =1, "Infomation"=2),
                         selected = 1),
            radioButtons("radio2", label = "Choose your highest education",
                         choices = list("< HS Grad" =1, 
                                        "HS Grad"=2,
                                        "Some College"=3,
                                        "College Grad"=4,
                                        "Advanced Degree"=5),
                         selected = 1),
            submitButton("Submit") #New
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Wage from Model:"),
            textOutput("pred1")
        )
    )
    
))