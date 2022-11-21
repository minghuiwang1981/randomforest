library(RCurl)
library(mlbench)
library(caret)
library("e1071")
library(randomForest)
library(ROCR)
library("pROC")

set.seed(20180503)

read.table("maize_CO_training_data_norm.txt",header=T)->tgn
tgn$class <- factor(ifelse(tgn$class==0, 'Zero', 'One'))

control <- rfeControl(functions=rfFuncs, 
                        method = "repeatedcv",
                        repeats =10, 
                        number = 10,
                       )
trainctrl <- trainControl(method = "repeatedcv",
                            number = 10,
                            repeats = 10,
			     classProbs= TRUE,
                            summaryFunction = twoClassSummary)

result_tgn <- rfe(tgn[, 1:(length(tgn)-1)],         # features
                tgn[, length(tgn)],                    # classification
                sizes=1:41,  
                rfeControl=control,
                 trControl = trainctrl
                )
				
