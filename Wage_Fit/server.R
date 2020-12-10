library(shiny)
library(caret)
library(ISLR)
data(Wage)

# Split the original data set into training and testing data set
set.seed(100)
inTrain <- createDataPartition(y=Wage$wage,
                               p = 0.7, list = FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]

# Build a linear regression model 
modFit <- train(wage ~ age + jobclass + education,
                method = "lm", data = training)
jobclass_choice <-c("1. Industrial", "2. Information")
education_choice <-c("1. < HS Grad ",
                     "2. HS Grad",
                     "3. Some College",
                     "4. College Grad",
                     "5. Advanced Degree")

shinyServer(function(input, output) {
    model1pred <- reactive({
        df <- data.frame(age = input$slideAge,
                         jobclass = factor(levels(training$jobclass)[as.numeric(input$radio1)],
                                           levels = levels(training$jobclass)),
                         education = factor(levels(training$education)[as.numeric(input$radio2)],
                                            levels = levels(training$education)))
        predict(modFit, newdata=df)
        # education_choice[as.numeric(input$radio2)]
        # jobclass_choice[as.numeric(input$radio1)]
    })
    output$plot1 <- renderPlot({
        plot(Wage$age, Wage$wage, xlab = "Age",
             ylab = "Wage", bty = "n", pch = 16,
             xlim = c(10, 90))
        points(input$slideAge, model1pred(), col="red", pch = 19, cex=2)
        legend(70, 250, c("Training Data", "Predicted Wage"), pch = c(16,19),
                          col = c("black", "red"), cex = 1.1)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })

})
