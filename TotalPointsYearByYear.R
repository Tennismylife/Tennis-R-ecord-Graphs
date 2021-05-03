library(tibble)
source("./Functions/Reader.R")


db <- ParallelReader()

PointsYearByYear <- function(player){

stat <- subset(db, winner_name == player)
stat <- stat[, wpoints:=(w_1stWon + w_2ndWon) + (l_svpt - (l_1stWon + l_2ndWon))]
#extract year from tourney_date
stat$year <- stringr::str_sub(stat$tourney_id, 0 ,4)
wins <- stat[,c("year", "winner_name", "wpoints")]


stat <- subset(db, loser_name == player)
stat <- stat[, lpoints:=(l_1stWon + l_2ndWon) + (w_svpt - (w_1stWon + w_2ndWon))]
#extract year from tourney_date
stat$year <- stringr::str_sub(stat$tourney_id, 0 ,4)
losses <- stat[,c("year", "loser_name", "lpoints")]


names(wins)[2] <- names(losses)[2] <- "Player"
names(wins)[3] <- names(losses)[3] <- "Points"

## merge the tables by "name"
res <- rbind(wins, losses)

#calculate sum by year
pointsyear <-aggregate(res$Points, by = list(year = res$year), FUN = sum, na.rm = TRUE)

pointsyear <- add_column(pointsyear, player, .after = "x")

}

players <- c("Roger Federer", "Rafael Nadal", "Novak Djokovic")

stat2 <- NULL

for(i in 1:length(players)){
  
stat <- PointsYearByYear(players[i])

stat2 <- rbind(stat2, stat)

}
print(stat2)


ggplot(data = stat2, aes(year, x, fill = player)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(nudge_y = 1, label = stat2$x) +
  xlab("year") + ylab("points") +
  ggtitle("Points won by Big 3 year by year")
