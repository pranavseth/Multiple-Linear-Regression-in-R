# Multiple Linear Regression

# Importing the dataset
dataset = read.csv('50_Startups.csv')

# Encoding categorical data
dataset$State = factor(dataset$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1, 2, 3))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = Profit ~ .,
               data = training_set)

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

ggplot()+
  geom_point(aes(x=training_set$R.D.Spend, y=training_set$Profit), 
             colour='red')+
  geom_line(aes(x=training_set$R.D.Spend, y=predict(regressor, newdata=training_set)),
            colour='blue')+
  ggtitle("Profit vs R D Spend (Training Set)")+
  xlab("R D Spend")+
  ylab("Profit")

#Visualising the test set
ggplot()+
  geom_point(aes(x=test_set$R.D.Spend, y=test_set$Profit),
             colour='red')+
  geom_line(aes(x=training_set$R.D.Spend, y=predict(regressor, newdata=training_set)),
            colour='blue')+
  ggtitle("Profit vs R D Spend (Test Set)")+
  xlab("R D Spend")+
  ylab("Profit")
