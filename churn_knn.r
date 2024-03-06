## build knn method by file churn

library(tidyverse)
library(caret)
library(ggplot2)
library(reshape2)

## import CSV file dataset
churn_df <- read_csv("churn.csv")


## split model
train_test_split <- function(data) {
  set.seed(42)
  n <- nrow(data)
  train_id <- sample(1:n, 0.8*n)
  train_df <- data[train_id, ]
  test_df <- data[-train_id, ]
  return( list(train_df, test_df))
}

## prepare data for train and test
prep_df <- train_test_split(churn_df)                        

## train model
ctrl <- trainControl(method = "cv",
                     number = 5)

### set method "glm" (Generalized Linear Model) for classifacation 
model <- train(churn ~ internationalplan + voicemailplan
               + totaldaycharge + numbercustomerservicecalls,
               data = prep_df[[1]],
               method = "knn",
               trControl = ctrl)

## score model 
pred_churn <- predict(model, newdata = prep_df[[2]])

## evaluate
conf <- confusionMatrix(pred_churn, 
                        factor(prep_df[[2]]$churn),
                        positive = "No",
                        mode = "prec_recall")

## perview
print(model)
