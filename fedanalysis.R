#setting working directory, reading in data
rm(list=ls())
setwd("C:\\Users\\aftab\\Desktop\\")
df = read.csv("data.csv")

#get grandslam matches
grandslams = c("Australian Open","FO - RG","Wimbledon","US Open")
dfgrandslam = df[which(df$tournament %in% grandslams),]
dfnongrandslam = df[which(!(df$tournament %in% grandslams)),]

#setting the variable which says grandslam or not
grandslam = 1;

if(grandslam == 1)
{
	df = dfgrandslam
}else
{
	df = dfnongrandslam
}

toremove = c()
toimpute = c()

for(i in 1:ncol(df))
{
	NApercentage = round((length(which(is.na(df[,i])))/nrow(df))*100)
	cat(paste("NA percentage in",names(df)[i],"==",NApercentage,"\n"))
	
	if(NApercentage > 30)
		toremove = c(toremove,names(df)[i])
		
	if(NApercentage > 0 && NApercentage <= 30)
		toimpute = c(toimpute,names(df)[i])
}

for(i in 1:length(toremove))
{
	col = toremove[i]
	cat(paste("Removing",col,"\n"))
	df[,which(names(df) == col)] = NULL
}

for(i in 1:length(toimpute))
{
	col = toimpute[i]
	
	players = c("Roger Federer","Novak Djokovic")
	
	for(j in 1:length(players))
	{
		mean = round(summary(df[which(df$player_fullname == players[j]),which(names(df) == col)])["Mean"])
		cat(paste("For",players[j],": Imputing",col,"with mean == ",mean,"\n"))
		
		NArows = c(which(is.na(df[which(df$player_fullname == players[j]),col])),which(df[which(df$player_fullname == players[j]),col] == 0))
		cat(paste(NArows,"\n"))
		
		df[which(df$player_fullname == players[j])[NArows],col] = mean
	}
}

for(i in 1:nrow(df))
{
	#finding successful first serve percentage for each match for each player
	df[i,"PERCENTAGE_FIRSTSERVESUCCESS"] = round((df[i,"serve_1st_total"]/df[i,"serve_1st_attempts"])*100)
	
	#finding points won percentage for each match for each player
	df[i,"PERCENTAGE_TOTALPOINTSWON"] = round((df[i,"points_won"]/df[i,"total_points"])*100)	

	#finding first serve points won percentage for each match for each player	
	df[i,"PERCENTAGE_FIRSTSERVEPOINTSWON"] = round((df[i,"serve_1st_won"]/df[i,"serve_1st_total"])*100)

	#finding second serve points won percentage for each match for each player	
	df[i,"PERCENTAGE_SECONDSERVEPOINTSWON"] = round((df[i,"serve_2nd_won"]/df[i,"serve_2nd_total"])*100)

	#finding return points won percentage for each match for each player
	df[i,"PERCENTAGE_RETURNPOINTSWON"] = round((df[i,"return_points_won"]/df[i,"return_points_total"])*100)

	#finding break points won percentage for each match for each player	
	df[i,"PERCENTAGE_BREAKPOINTSWON"] = round((df[i,"return_break_points_won"]/df[i,"return_break_points_total"])*100)
}

#remove suspicious data
#3/2016 Australian Open    SF

################################################################################################################################
################################################################################################################################
######################################################ANALYSIS##################################################################
################################################################################################################################
################################################################################################################################
#1.add decision tree prediction here
if(grandslam == 1)
{
	predictors = c("player_fullname","aces","double_faults","winners","unforced_errors","serve_speed_fastest","serve_speed_1st_avg","serve_speed_2nd_avg","PERCENTAGE_FIRSTSERVESUCCESS","win")
}else
{
	predictors = c("player_fullname","aces","double_faults","PERCENTAGE_FIRSTSERVESUCCESS","win")
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

confusionMatrix(df$win,df$prediction)

#2.performing stats based analysis
#gettting individual data frames
dffedwin = df[which(df$player_fullname == "Roger Federer" & df$win == 1),]
dffedlose = df[which(df$player_fullname == "Roger Federer" & df$win == 0),]
dfnovakwin = df[which(df$player_fullname == "Novak Djokovic" & df$win == 1),]
dfnovaklose = df[which(df$player_fullname == "Novak Djokovic" & df$win == 0),]

#printing out summary information
summary(dffedwin[,predictors])
summary(dffedlose[,predictors])
summary(dfnovakwin[,predictors])
summary(dfnovaklose[,predictors])

#3.varImp - variable importance - http://stats.stackexchange.com/questions/215204/how-can-i-find-the-field-which-most-affects-or-contributes-to-decision-making-in?noredirect=1#comment408424_215204
if(grandslam == 1)
{
	predictors = c("player_fullname","aces","double_faults","winners","unforced_errors","serve_speed_fastest","serve_speed_1st_avg","serve_speed_2nd_avg","PERCENTAGE_FIRSTSERVESUCCESS","win")
}else
{
	predictors = c("player_fullname","aces","double_faults","PERCENTAGE_FIRSTSERVESUCCESS","win")
}

# Regression Tree Example
library(rpart)

# grow tree 
model <- rpart(win~., method="anova", data=df[,predictors])
varImp(model)

#4.correlation of each feature with target variable
#gettting individual data frames
dffedwin = df[which(df$player_fullname == "Roger Federer" & df$win == 1),]
dffedlose = df[which(df$player_fullname == "Roger Federer" & df$win == 0),]
dfnovakwin = df[which(df$player_fullname == "Novak Djokovic" & df$win == 1),]
dfnovaklose = df[which(df$player_fullname == "Novak Djokovic" & df$win == 0),]

if(grandslam == 1)
{
	correlators = c("aces","double_faults","winners","unforced_errors","serve_speed_fastest","serve_speed_1st_avg","serve_speed_2nd_avg","PERCENTAGE_FIRSTSERVESUCCESS","win")
}else
{
	correlators = c("aces","double_faults","PERCENTAGE_FIRSTSERVESUCCESS","win")
}

df = rbind(dffedwin,dffedlose)[,correlators]

library(corrplot)
colno = which(names(df) == "win")
cor(df)[,colno]
corrplot(cor(df))

#5.information gain
library("FSelector")

#gettting individual data frames
dffedwin = df[which(df$player_fullname == "Roger Federer" & df$win == 1),]
dffedlose = df[which(df$player_fullname == "Roger Federer" & df$win == 0),]
dfnovakwin = df[which(df$player_fullname == "Novak Djokovic" & df$win == 1),]
dfnovaklose = df[which(df$player_fullname == "Novak Djokovic" & df$win == 0),]

if(grandslam == 1)
{
	correlators = c("aces","double_faults","winners","unforced_errors","serve_speed_fastest","serve_speed_1st_avg","serve_speed_2nd_avg","PERCENTAGE_FIRSTSERVESUCCESS","win")
}else
{
	correlators = c("aces","double_faults","PERCENTAGE_FIRSTSERVESUCCESS","win")
}

df = rbind(dffedwin,dffedlose)[,correlators]

weights <- information.gain(win~., df)
print(weights)
subset <- cutoff.k(weights, 1)
f <- as.simple.formula(subset, "win")
print(f)
subset <- cutoff.k.percent(weights, 0.75)
f <- as.simple.formula(subset, "win")
print(f)
subset <- cutoff.biggest.diff(weights)
f <- as.simple.formula(subset, "win")
print(f)

#6.gain ratio
weights <- gain.ratio(win~., df)
print(weights)
subset <- cutoff.k(weights, 1)
f <- as.simple.formula(subset, "win")
print(f)
subset <- cutoff.k.percent(weights, 0.75)
f <- as.simple.formula(subset, "win")
print(f)
subset <- cutoff.biggest.diff(weights)
f <- as.simple.formula(subset, "win")
print(f)

#7.factor analysis
#gettting individual data frames
dffedwin = df[which(df$player_fullname == "Roger Federer" & df$win == 1),]
dffedlose = df[which(df$player_fullname == "Roger Federer" & df$win == 0),]
dfnovakwin = df[which(df$player_fullname == "Novak Djokovic" & df$win == 1),]
dfnovaklose = df[which(df$player_fullname == "Novak Djokovic" & df$win == 0),]

if(grandslam == 1)
{
	correlators = c("aces","double_faults","winners","unforced_errors","serve_speed_fastest","serve_speed_1st_avg","serve_speed_2nd_avg","PERCENTAGE_FIRSTSERVESUCCESS","win")
}else
{
	correlators = c("aces","double_faults","PERCENTAGE_FIRSTSERVESUCCESS","win")
}

df = rbind(dffedwin,dffedlose)[,correlators]

library("princomp")
pca = princomp(df,scores=TRUE,cor=TRUE)

loadings(pca)

plot(pca)

screeplot(pca, type="line", main="Scree Plot")

biplot(pca)

pca$scores[1:10,]

fa = factanal(df, factor=3)

#winner to unforced_errors ratio
df = df[,c("player_fullname","winners","unforced_errors","win")]
dffed = df[which(df$player_fullname == "Roger Federer"),]
dfnovak = df[which(df$player_fullname == "Novak Djokovic"),]

plot(dffed$winners, dffed$unforced_errors, main="Roger Federer Winner to Unforced error ratio", xlab = "Winners", ylab = "Unforced errors", pch=19)
plot(dfnovak$winners, dfnovak$unforced_errors, main="Novak Djokovic Winner to Unforced error ratio", xlab = "Winners", ylab = "Unforced errors", pch=19)

cor(dffed$winners,dffed$unforced_errors)
cor(dfnovak$winners,dfnovak$unforced_errors)

summary(dffed$winners)
summary(dfnovak$winners)
summary(dffed$unforced_errors)
summary(dfnovak$unforced_errors)

#study : net points df5
load("C:\\Users\\aftab\\Desktop\\gamestatmatchdata\\tennis_MatchChartingProject-master\\mens\\datasets.RData")

#for Roger
#match ids of Fed-Djokovic matches
fedplayer1matchid = as.character(df1[which(df1$Player.1 == "Roger Federer" & df1$Player.2 == "Novak Djokovic"),"match_id"])
fedplayer2matchid = as.character(df1[which(df1$Player.2 == "Roger Federer" & df1$Player.1 == "Novak Djokovic"),"match_id"])

#see rally count split
df = df5[which(df5$match_id %in% fedplayer1matchid),]
dfroger = df[which(df$player == 1),]
dfnovak = df[which(df$player == 2),]

df = df5[which(df5$match_id %in% fedplayer2matchid),]
dfroger = rbind(dfroger,df[which(df$player == 2),])
dfnovak = rbind(dfnovak,df[which(df$player == 1),])

summary(dfroger)
summary(dfnovak)

#study : rally length df7
load("C:\\Users\\aftab\\Desktop\\gamestatmatchdata\\tennis_MatchChartingProject-master\\mens\\datasets.RData")

#for Roger
#match ids of Fed-Djokovic matches
fedplayer1matchid = as.character(df1[which(df1$Player.1 == "Roger Federer" & df1$Player.2 == "Novak Djokovic"),"match_id"])
fedplayer2matchid = as.character(df1[which(df1$Player.2 == "Roger Federer" & df1$Player.1 == "Novak Djokovic"),"match_id"])

#see rally count split
df = df7[which(df7$match_id %in% fedplayer1matchid & df7$row %in% c("1-3","4-6","7-9","10")),c("match_id","row","pts","pl1_won","pl1_winners","pl1_forced","pl1_unforced")]
dffedsecond = df7[which(df7$match_id %in% fedplayer2matchid & df7$row %in% c("1-3","4-6","7-9","10")),c("match_id","row","pts","pl2_won","pl2_winners","pl2_forced","pl2_unforced")]
library("plyr")
dffedsecond = rename(dffedsecond, c("pl2_won"="pl1_won","pl2_winners"="pl1_winners","pl2_forced"="pl1_forced","pl2_unforced"="pl1_unforced"))
df = rbind(df,dffedsecond)

#get aggregate grouped by row (1-3,4-6,7-9,10)
df$row = as.character(df$row)
df$PERCENTAGE_pl1_won = round((df$pl1_won/df$pts)*100)
df = aggregate(PERCENTAGE_pl1_won~row, data=df, summary)
#tapply(df$PERCENTAGE_pl1_won, df$row, mean)
rallyLength = df[,1]
winPercentage = as.data.frame(df[,2])[,"Mean"]
df = data.frame(rallyLength,winPercentage)

#for Novak
#match ids of Fed-Djokovic matches
novakplayer1matchid = as.character(df1[which(df1$Player.1 == "Novak Djokovic" & df1$Player.2 == "Roger Federer"),"match_id"])
novakplayer2matchid = as.character(df1[which(df1$Player.2 == "Novak Djokovic" & df1$Player.1 == "Roger Federer"),"match_id"])

#see rally count split
df = df7[which(df7$match_id %in% novakplayer1matchid & df7$row %in% c("1-3","4-6","7-9","10")),c("match_id","row","pts","pl1_won","pl1_winners","pl1_forced","pl1_unforced")]
dfnovaksecond = df7[which(df7$match_id %in% novakplayer2matchid & df7$row %in% c("1-3","4-6","7-9","10")),c("match_id","row","pts","pl2_won","pl2_winners","pl2_forced","pl2_unforced")]
library("plyr")
dfnovaksecond = rename(dfnovaksecond, c("pl2_won"="pl1_won","pl2_winners"="pl1_winners","pl2_forced"="pl1_forced","pl2_unforced"="pl1_unforced"))
df = rbind(df,dfnovaksecond)

#get aggregate grouped by row (1-3,4-6,7-9,10)
df$row = as.character(df$row)
df$PERCENTAGE_pl1_won = round((df$pl1_won/df$pts)*100)
df = aggregate(PERCENTAGE_pl1_won~row, data=df, summary)
#tapply(df$PERCENTAGE_pl1_won, df$row, mean)
rallyLength = df[,1]
winPercentage = as.data.frame(df[,2])[,"Mean"]
df = data.frame(rallyLength,winPercentage)

#study : depth analysis

#important Wimbledon matches
#Wimbledon 2012 - 20120706-M-Wimbledon-SF-Roger_Federer-Novak_Djokovic
#Wimbledon 2014 - 20140706-M-Wimbledon-F-Novak_Djokovic-Roger_Federer
#Wimbledon 2015 - 20150710-M-Wimbledon-SF-Roger_Federer-Andy_Murray
#Wimbledon 2015 - 20150712-M-Wimbledon-F-Roger_Federer-Novak_Djokovic

#TODO
#1. serve direction - from among 2014 wimbledon and 2015 wimbledon finals, points won and their directions
#2. rally count - points won in 2014 wimbledon and 2015 wimbledon finals by rally count
#3. contributors - from among federer djokovic matches,
#4. relation between unforced errors and winners