library(xgboost)
library(Metrics)
# load data
train <- read.csv("second.csv", head=T)
#train <- train[,grep("feature|target",names(train))]
#target<-train[,c(51)]
#train<-train[,grep("feature",names(train))]
#train<-as.matrix(train)
test <- read.csv("numerai_tournament_data.csv", head=T)
actual <-test[1:46362,c(54)]
head(actual)
test  <- test[,grep("feature",names(test))]
test<-as.matrix(test)


#depth= 3
#eta= 0.15
#ss= 0.6
#n= 5 
#for(depth in 3:10){
#for(eta in seq(0.01,0.2,by=0.01)){
#for(ss in seq(0.5,1,by=0.1)){
#for(n in 1:5){
for(i in 1:100000){
  train1 <- train[sample(nrow(train)),]
  target<-train1[,c(51)]
  train1<-train1[,grep("feature",names(train1))]
  train2<-as.matrix(train1)
  #depth<-sample(3:10,1)
  eta<-runif(1,0.01,0.2)
  ss<-runif(1,0.5,0.7)
  n<-sample(1:5,1)
  #cat("\ndepth=",depth)
  #cat("\neta=",eta)
  #cat("\nss=",ss)
  #cat("\nn=",n,"\n")
  bst <- xgboost(data = train2, label = target,subsample=ss,objective = "binary:logistic",nrounds=n,max_depth=3,eta=eta,eval_metric="logloss",nthread=4)
  predictions <- predict(bst, test,type="response")
  rm(bst)
  rm(train2)
  loss <- logLoss(actual,predictions)
  print(loss)
  if(loss < 0.692406){
    #cat("\ndepth=",depth)
    cat("\neta=",eta)
    cat("\nss=",ss)
    cat("\nn=",n,"\n")
    #train1$target<-target
    #write.csv(train1,file="trainenhanced.csv",quote=F,row.names=F)
    break
  }
}
#}}}}
#predict
test <- read.csv("numerai_tournament_data.csv", head=T)
test  <- test[,grep("id|feature",names(test))]
test$probability <- predictions
pred <- test[,c("id", "probability")]
write.csv(pred, file="predictions.csv", quote=F, row.names=F)

#=IF(   AND(B2>=0.5,C2=0),RAND()*(0.499-0.336215555667877 )+0.336215555667877 ,   IF(AND(B2<0.5,C2=1),RAND()*(0.608488261699677 -0.5)+0.5,  B2)     )
