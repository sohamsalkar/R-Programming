library(tidyverse)
list.files(path = "~/College/DMBI")
fig <- function(width, heigth){
  options(repr.plot.width = width, repr.plot.height = heigth)
}
library(pacman)
pacman::p_load(pacman,dplyr, ggplot2, rio, gridExtra, scales, ggcorrplot, caret, e1071)
df <- import("~/College/DMBI/data.csv")
head(df)
names(df)
str(df)
corr <- round(cor(df), 8)
ggcorrplot(corr)
fig(18, 16)

df$blue <- as.numeric(df$blue)
df$dual_sim <- as.numeric(df$dual_sim)
df$four_g <- as.numeric(df$four_g)
df$price_range <- as.numeric(df$price_range)
smp_size <- floor(0.75 * nrow(df))

# set the seed to make our partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(df)), size = smp_size)

train <- df[train_ind, ]
test <- df[-train_ind, ]

x_train <- subset(train, select = -price_range)
y_train <- train$price_range
x_test <- subset(test, select = -price_range)
y_test <- test$price_range
model <- svm(x_train, y_train, type = 'C-classification', 
             kernel = 'linear') 

print(model)
summary(model)

pred <- predict(model, x_test)

pred <- as.factor(pred)
y_test <- as.factor(y_test)
confusionMatrix(y_test, pred)