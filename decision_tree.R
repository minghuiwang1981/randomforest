library(RCurl)
library(mlbench)
library(caret)
library("e1071")
library(randomForest)
library(ROCR)
library("pROC")
library("PRROC")

read.table("maize_DSB_training_data_norm.txt",header=T)->tgn
control <- trainControl(method = "repeatedcv",number = 10, repeats =10,savePredictions = TRUE,classProbs = TRUE,summaryFunction = twoClassSummary)
seed <- 20180503
set.seed(seed)
decision_default<-train(class~., data=tgn, method="rpart", trControl=control,metric = "ROC")
plot(roc(decision_default$pred$obs, decision_default$pred$Zero),col="red",xlab="1 - Specificity",xaxt = 'n',axes = 0,cex.lab=1.5,lwd=3)
axis(side = 1,at=c(1,0.8,0.6,0.4,0.2,0), labels=c(0,0.2,0.4,0.6,0.8,1),cex.axis=1.25)
axis(side = 2,at=c(0,0.2,0.4,0.6,0.8,1), labels=c(0,0.2,0.4,0.6,0.8,1),cex.axis=1.25)
