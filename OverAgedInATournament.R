source("./Functions/Reader.R")


db <- ParallelReader()

id <- '-580'

stage <- 'QF'

## only select matches of a tournament
db$tid <- sub("^[^-]*", "", db$tourney_id)

dbm <- db[tid == id]

if(stage != 'W' & stage != '0'){
  dbm <- dbm[round == stage]
}else if(stage == 'W')
  dbm <- dbm[round == 'F']

#tournaments won
wins <-
  unique(dbm[, c('tourney_id', 'winner_age')])

#tournaments lost
if (stage != 'W')
  losses <-
  unique(dbm[, c('tourney_id', 'loser_age')])

## common name to bind with
names(wins)[2] <- "age"

if (stage != 'W') {
  names(losses)[2] <- "age"
}

## merge the tables by "name"
if (stage != 'W'){
  res <- rbind(wins, losses, fill = TRUE)
}else res <- wins

#extract year from tourney_date
res$year <- stringr::str_sub(res$tourney_id, 0 ,4)

res <- subset(res, age > 30)

require(dplyr)
res<- res %>%
  group_by(year) %>%
  tally()

print(res)


# basic histogram
ggplot(res) +
  ggtitle("Over 30 aged in Australian Open QFs") +
  geom_bar(mapping = aes(x = year, y = n), stat = "identity")
