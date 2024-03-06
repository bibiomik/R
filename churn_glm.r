## build glm method by file churn in R

library(tidyverse)
library(caret) ## use for Supervised Learning Model

## use churn.csv to build model with glm method
## with 4 steps basic ML workflow

## read churn.csv file return into dataframe first
churn_df <- read_csv("churn.csv")

## view dataframe
churn_df

## 1. split data Train 80% Test 20%
## build split data template
set.seed(42) ## lock random sampling
n <- nrow(churn_df) ## count sample size
train_id <- sample(1:n, size = 0.8 * n) ## random sampling
train_df <- churn_df[train_id, ] ## train data
test_df <- churn_df[-train_id, ] ## test data
return(list(train_df, test_df)) ## return 2 split data into list

## return split data template into value function()
train_test_split <- function(data) {
  set.seed(42)
  n <- nrow(data)
  train_id <- sample(1:n, size = 0.8 * n)
  train_df <- data[train_id, ]
  test_df <- data[-train_id, ]
  return(list(train_df, test_df))
}

## then try to use split data function
train_test_split(churn_df)

## and return split data into function
prep_split_df <- train_test_split(churn_df)

## preview split data train & test by subset[[]]
prep_split_df[[1]] ## this is train data
prep_split_df[[2]] ## this is test data

## 2. train model
## by use train() function
## with 4 features(x) and use K-fold Re-sampling K=10

## build K-fold control value
ctrl_kfold <- trainControl(method = "CV",
                           number = 5)

## build train model
train_model <- train(churn ~ totaldayminutes + totaldaycalls + totalnightminutes +  totalnightcalls + numbercustomerservicecalls,
                     data = prep_split_df[[1]],
                     method = "glm",
                     trControl = ctrl_kfold)

## try train model
print(train_model)

## 3. score model
## or take train model use predict test data
## with predict() function
predict_test <- predict(train_model, newdata = prep_split_df[[2]])

## try predict test data
print(predict_test)

## 4. evaluate model
## or find error metric ( MAE, RMSE ) or Accuracy from Test data

## if use method = “lm” >>> use error ( MAE, RMSE )
## if use method = “glm” >>> use Accuracy

## for compare Train vs Test model

## create actual test data
actual_test <- prep_split_df[[2]]$churn
## preview actual test data
actual_test

## find accuracy = mean(predict test data == catual test data)
acc_test_model <- mean(actual_test == predict_test)

### end with compare accuracy Train vs Test Model
print(train_model)

print( acc_test_model )
