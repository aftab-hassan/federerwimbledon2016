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
df[which(df$match_stats_id =="3513543"),"winners"] = 33
df[which(df$match_stats_id =="3513543"),"unforced_errors"] = 20
df[which(df$match_stats_id =="3513544"),"winners"] = 34
df[which(df$match_stats_id =="3513544"),"unforced_errors"] = 51