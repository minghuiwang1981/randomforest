library(RCurl)
library(mlbench)
library(caret)
library("e1071")
library(randomForest)
library(ROCR)
library("pROC")


set.seed(20180503)
read.table("maize_DSB_training_data_norm.txt",header=T)->tgn
tgn$class <- factor(ifelse(tgn$class==0, 'Zero', 'One'))
control <- rfeControl(functions=rfFuncs, 
                        method = "repeatedcv",
                        repeats =10, 
                        number = 10,
                       )
logistic_default<-train(class~., data=tgn, method="glm", family=binomial, trControl=control,metric = "ROC")
auc(roc(logistic_default$pred$obs, logistic_default$pred$Zero))
plot(roc(logistic_default$pred$obs, logistic_default$pred$Zero),col="red",xlab="1 - Specificity",xaxt = 'n',axes = 0,cex.lab=1.5,lwd=3)


########################linear relationship between variables and recombination classes#####################
library(RCurl)
library(mlbench)
library(caret)
library("e1071")
library(randomForest)
library(ROCR)
library("pROC")

read.table("maize_DSB_training_data_norm.txt",header=T)->tgn
mod <- glm(class~mCG, family="binomial",data=tgn)
nullmod <- glm(class~1, family="binomial",data=tgn)
R2<-1-logLik(mod)/logLik(nullmod)
modsum = summary(mod)
my.p = modsum$coefficients[2,1]

x <- seq(-0.5, 1.5, 0.01)
plot(tgn$mCG,tgn$class,xlab="Normalized DNA methylation (CG)",cex.lab=1.5,xlim=c(-0.3,1.3) ,cex.axis=1.5,ylab="Probability",col="blue",pch = 20, type = 'p', las = 1)
newdata = data.frame(mCG = seq(-0.5,1.5,0.01))
lines(seq(-0.5,1.5,0.01),predict(mod, newdata,type="response"),col="red",lwd=3)
rp = vector('expression',2)
Coef = -29.894
rp[1] = substitute(expression(italic(R)^2 == MYVALUE), 
		list(MYVALUE = format(R2,dig=3)))[2]
rp[2] = substitute(expression(italic(B ) == MYOTHERVALUE), 
		list(MYOTHERVALUE = format(my.p, digits = 4)))[2]
legend(0.6,0.85, legend = rp, bty = 'n',cex=1.2)
