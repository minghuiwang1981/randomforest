library(RCurl)
library(mlbench)
library(caret)
library("e1071")
library(randomForest)
library(ROCR)
library("pROC")
library(doMC)
registerDoMC(cores = 50)

read.table("tair10_co_pos.txt",header=T)->pos   ############tair10 COs ~3000 records
read.table("tair10_co_neg.txt",header=F)->neg   #############tair10 desert regions
colnames(neg)<-colnames(pos)  

List = list()
for (i in 1:100){
set.seed(Sys.time())
index_pos<-sample(dim(pos)[1],2000,replace =F) 
subset_pos<-pos[index_pos,]   
index_neg<-sample(dim(neg)[1],2000,replace =F) 
subset_neg<-neg[index_neg,] 
left_neg<-neg[-index_neg,]
test_neg<-left_neg[sample(dim(left_neg)[1],2000,replace =F),]
train<-rbind(subset_pos,subset_neg)
colnames(train)<-colnames(pos)
colnames(test_neg)<-colnames(pos)

set.seed(20230919)
tgn<-train[,-c(1:3)]

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

predict_out<-predict(result_tgn,test_neg)
acc<-table(predict_out$pred)[2]/2000
List[[length(List)+1]] <-acc
}
df <- data.frame(matrix(unlist(List), nrow=length(List), byrow=TRUE))
write.table(df,file="tair10_co_run_100_accuracy.txt",sep="\t",quote=F,row.names=F)
