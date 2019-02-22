dataset = read.csv('50_Startups.csv')

dataset$State = factor(dataset$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1, 2, 3))

library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

regressor = lm(formula = Profit ~ .,
               data = training_set)

y_pred = predict(regressor, newdata = test_set)

ggplot()+
  geom_point(aes(x=training_set$R.D.Spend, y=training_set$Profit), 
             colour='red')+
  geom_line(aes(x=training_set$R.D.Spend, y=predict(regressor, newdata=training_set)),
            colour='blue')+
  ggtitle("Profit vs R D Spend (Training Set)")+
  xlab("R D Spend")+
  ylab("Profit")

ggplot()+
  geom_point(aes(x=test_set$R.D.Spend, y=test_set$Profit),
             colour='red')+
  geom_line(aes(x=training_set$R.D.Spend, y=predict(regressor, newdata=training_set)),
            colour='blue')+
  ggtitle("Profit vs R D Spend (Test Set)")+
  xlab("R D Spend")+
  ylab("Profit")
