#study : rally length df7
load("C:\\Users\\aftab\\Desktop\\gamestatmatchdata\\tennis_MatchChartingProject-master\\mens\\datasets.RData")

unloadNamespace("dplyr")
library("plyr")

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
Federer_WinPercentage = as.data.frame(df[,2])[,"Mean"]
dffed = data.frame(rallyLength,winPercentage)

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
dfnovak = data.frame(rallyLength,winPercentage)
Djokovic_WinPercentage = dfnovak[,2]

df = data.frame(rallyLength,Federer_WinPercentage,Djokovic_WinPercentage)
df = rbind(df[1,],df[3,],df[4,],df[2,])
df