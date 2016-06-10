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