################################################################################################################################
################################################################################################################################
######################################################ANALYSIS##################################################################
################################################################################################################################
################################################################################################################################
#1.add decision tree prediction here
if(grandslam == 1)
{
	predictors = c("aces","double_faults","winners","unforced_errors","serve_speed_fastest","serve_speed_1st_avg","serve_speed_2nd_avg","PERCENTAGE_FIRSTSERVESUCCESS","win")
}else
{
	predictors = c("aces","double_faults","PERCENTAGE_FIRSTSERVESUCCESS","win")
}

# Regression Tree Example
library(rpart)

# grow tree 
model <- rpart(win~., method="anova", data=df[,predictors])

printcp(model) # display the results 
plotcp(model) # visualize cross-validation results 
summary(model) # detailed summary of splits

# create additional plots 
par(mfrow=c(1,2)) # two plots on one page 
rsq.rpart(model) # visualize cross-validation results  	

# plot tree 
plot(model, uniform=TRUE, main="Regression Tree for predicting Winner")
text(model, use.n=TRUE, all=TRUE, cex=.8)

library("rpart.plot")
library(RColorBrewer)
library(rattle)
fancyRpartPlot(model)

#prediction
pred = predict(model,df[,predictors])
prediction = which(pred >= 0.5)

df$prediction = 0
df[prediction,"prediction"] = 1

library("caret")
confusionMatrix(df$win,df$prediction)

#2.varImp - variable importance - http://stats.stackexchange.com/questions/215204/how-can-i-find-the-field-which-most-affects-or-contributes-to-decision-making-in?noredirect=1#comment408424_215204
if(grandslam == 1)
{
	predictors = c("aces","double_faults","winners","unforced_errors","serve_speed_fastest","serve_speed_1st_avg","serve_speed_2nd_avg","PERCENTAGE_FIRSTSERVESUCCESS","win")
}else
{
	predictors = c("aces","double_faults","PERCENTAGE_FIRSTSERVESUCCESS","win")
}

# Regression Tree Example
library(rpart)

# grow tree 
model <- rpart(win~., method="anova", data=df[,predictors])

#printing result
result = round(varImp(model)*100)
factors = rownames(result)
contribution_to_match_outcome = round(varImp(model)*100)[,1]
result = data.frame(factors,contribution_to_match_outcome)

library("dplyr")
arrange(result,desc(contribution_to_match_outcome))