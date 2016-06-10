#3.performing stats based analysis
#gettting individual data frames
dffedwin = df[which(df$player_fullname == "Roger Federer" & df$win == 1),]
dffedlose = df[which(df$player_fullname == "Roger Federer" & df$win == 0),]
dfnovakwin = df[which(df$player_fullname == "Novak Djokovic" & df$win == 1),]
dfnovaklose = df[which(df$player_fullname == "Novak Djokovic" & df$win == 0),]

#1.add decision tree prediction here
if(grandslam == 1)
{
  predictors = c("player_fullname","aces","double_faults","winners","unforced_errors","serve_speed_fastest","serve_speed_1st_avg","serve_speed_2nd_avg","PERCENTAGE_FIRSTSERVESUCCESS","win")
}else
{
  predictors = c("player_fullname","aces","double_faults","PERCENTAGE_FIRSTSERVESUCCESS","win")
}

#printing out summary information
summary(dffedwin[,predictors])
summary(dffedlose[,predictors])

X = c("In matches Won","In matches lost")
Unforced_Errors = c(round(mean(dffedwin$unforced_errors)),round(mean(dffedlose$unforced_errors)))
Second_Serve_Speed_Average = c(round(mean(dffedwin$serve_speed_2nd_avg)),round(mean(dffedlose$serve_speed_2nd_avg)))
First_Serve_Percentage = c(round(mean(dffedwin$PERCENTAGE_FIRSTSERVESUCCESS)),round(mean(dffedlose$PERCENTAGE_FIRSTSERVESUCCESS)))
Aces = c(round(mean(dffedwin$aces)),round(mean(dffedlose$aces)))
First_Serve_Speed_Average = c(round(mean(dffedwin$serve_speed_1st_avg)),round(mean(dffedlose$serve_speed_1st_avg)))
Winners = c(round(mean(dffedwin$winners)),round(mean(dffedlose$winners)))
Double_Faults = c(round(mean(dffedwin$double_faults)),round(mean(dffedlose$double_faults)))
Fastest_Serve = c(round(mean(dffedwin$serve_speed_fastest)),round(mean(dffedlose$serve_speed_fastest)))

outputdf = rbind(X,Unforced_Errors,Second_Serve_Speed_Average,First_Serve_Percentage,Aces,First_Serve_Speed_Average,Winners,Double_Faults,Fastest_Serve)
outputdf