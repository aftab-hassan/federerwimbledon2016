#study : winner to unforced_errors ratio
df = df[,c("player_fullname","winners","unforced_errors","win")]
dffed = df[which(df$player_fullname == "Roger Federer"),]
dfnovak = df[which(df$player_fullname == "Novak Djokovic"),]

plot(dffed$winners, dffed$unforced_errors, main="Roger Federer Winner to Unforced error ratio", xlab = "Winners", ylab = "Unforced errors", pch=19)
plot(dfnovak$winners, dfnovak$unforced_errors, main="Novak Djokovic Winner to Unforced error ratio", xlab = "Winners", ylab = "Unforced errors", pch=19)

cat(paste("Federer's correlation b/w Winners and Unforced errors : ",round(cor(dffed$winners,dffed$unforced_errors)*100),"%"))
cat(paste("Djokovic's correlation b/w Winners and Unforced errors : ",round(cor(dfnovak$winners,dfnovak$unforced_errors)*100),"%"))
summary(dffed$winners)
summary(dfnovak$winners)
summary(dffed$unforced_errors)
summary(dfnovak$unforced_errors)