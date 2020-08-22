setwd("E:/Users/Colin/Documents/Homework/ISDS 577")
data = read.csv('CountyPertussisData.csv', stringsAsFactors=T, head=T)
library(rpart)
library(rpart.plot)
set.seed(1)
fit = rpart(Cases ~ n + n2 + nDTP + nDTP2 + nPME + nPME2, method = "anova", data = data, cp = 2e-3)
rpart.plot(fit, main = 'Regression Tree') #Standard Regression Tree
pfit = prune(fit, cp = fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])
rpart.plot(pfit, main = 'Minimum Error Regression Tree') #Minimum Error Tree
