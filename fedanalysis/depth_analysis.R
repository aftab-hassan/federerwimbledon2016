#study : depth analysis
load("C:\\Users\\aftab\\Desktop\\gamestatmatchdata\\tennis_MatchChartingProject-master\\mens\\datasets.RData")

#for Roger
#match ids of Fed-Djokovic matches
fedplayer1matchid = as.character(df1[which(df1$Player.1 == "Roger Federer" & df1$Player.2 == "Novak Djokovic"),"match_id"])
fedplayer2matchid = as.character(df1[which(df1$Player.2 == "Roger Federer" & df1$Player.1 == "Novak Djokovic"),"match_id"])

df = rbind(df1[which(df1$match_id %in% fedplayer1matchid),c(1,15)],df1[which(df1$match_id %in% fedplayer2matchid),c(1,15)])
df$win = c(0,1,0,0,1,0,0,1,0,0,1,1,0,1,1,0,1,1,1)

fedwinmatchid = df[which(df$win == 1),"match_id"]
fedlosematchid = df[which(df$win == 0),"match_id"]

dffedwin = df8[which(df8$match_id %in% fedwinmatchid),]
dffedlose = df8[which(df8$match_id %in% fedlosematchid),]

cat(paste("Depth analysis in matches : WON\n"))
df = dffedwin
player1matchid = unique(df[grep("Roger_Federer-Novak_Djokovic",df$match_id),"match_id"])
player1tempdf = df[which(df$match_id %in% player1matchid & df$player==1 & df$row == "Total"),]

df = dffedwin
player2matchid = unique(df[grep("Novak_Djokovic-Roger_Federer",df$match_id),"match_id"])
player2tempdf = df[which(df$match_id %in% player2matchid & df$player==2 & df$row == "Total"),]

df = rbind(player1tempdf,player2tempdf)
df = df[which(df$shallow > 0 | df$deep > 0 | df$very_deep > 0), ]
df$shallow_deep_verydeep = df$shallow + df$deep + df$very_deep
df$PERCENTAGE_SHALLOW = round((df$shallow/df$shallow_deep_verydeep)*100)
df$PERCENTAGE_DEEP = round((df$deep/df$shallow_deep_verydeep)*100)
df$PERCENTAGE_VERYDEEP = round((df$very_deep/df$shallow_deep_verydeep)*100)

mean(df$PERCENTAGE_SHALLOW)
mean(df$PERCENTAGE_DEEP)
mean(df$PERCENTAGE_VERYDEEP)

# Pie Chart with Percentages
slices <- c(mean(df$PERCENTAGE_SHALLOW),mean(df$PERCENTAGE_DEEP),mean(df$PERCENTAGE_VERYDEEP)) 
lbls <- c("Shallow", "Deep", "Very deep")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, main="Depth analysis in matches : WON")

#win
#> mean(df$PERCENTAGE_SHALLOW)
#[1] 19.125
#> mean(df$PERCENTAGE_DEEP)
#[1] 59.125
#> mean(df$PERCENTAGE_VERYDEEP)
#[1] 21.625

cat(paste("Depth analysis in matches : LOST\n"))
df = dffedlose
player1matchid = unique(df[grep("Roger_Federer-Novak_Djokovic",df$match_id),"match_id"])
player1tempdf = df[which(df$match_id %in% player1matchid & df$player==1 & df$row == "Total"),]

df = dffedlose
player2matchid = unique(df[grep("Novak_Djokovic-Roger_Federer",df$match_id),"match_id"])
player2tempdf = df[which(df$match_id %in% player2matchid & df$player==2 & df$row == "Total"),]

df = rbind(player1tempdf,player2tempdf)
df = df[which(df$shallow > 0 | df$deep > 0 | df$very_deep > 0), ]
df$shallow_deep_verydeep = df$shallow + df$deep + df$very_deep
df$PERCENTAGE_SHALLOW = round((df$shallow/df$shallow_deep_verydeep)*100)
df$PERCENTAGE_DEEP = round((df$deep/df$shallow_deep_verydeep)*100)
df$PERCENTAGE_VERYDEEP = round((df$very_deep/df$shallow_deep_verydeep)*100)

mean(df$PERCENTAGE_SHALLOW)
mean(df$PERCENTAGE_DEEP)
mean(df$PERCENTAGE_VERYDEEP)

# Pie Chart with Percentages
slices <- c(mean(df$PERCENTAGE_SHALLOW),mean(df$PERCENTAGE_DEEP),mean(df$PERCENTAGE_VERYDEEP)) 
lbls <- c("Shallow", "Deep", "Very deep")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, main="Depth analysis in matches : LOST")