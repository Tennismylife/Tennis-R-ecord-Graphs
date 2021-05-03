library(stringr)

CountOverallRound <- function(stage) {

  db <- removeTeamEvents(db)

  if(stage == 'W')
    db <- db[!str_detect(db$score, "WEA") & !str_detect(db$score, "ABN")]
  
  dbm <- db  
  
  if(stage != 'W')
    dbm <- dbm[round == stage]
  
  if(stage == 'W')
    dbm <- dbm[round == 'F' & !str_detect(dbm$score, "WEA")]

  ## wins
  wins <- dbm[,.N, by=winner_name]
  names(wins)[1] <- "name"
  names(wins)[2] <- "wins"
  
  #losses
  if(stage != 'W')
  {
  losses <- dbm[,.N, by= loser_name]
  names(wins)[1] <- names(losses)[1] <- "name"
  }
  
  if(stage != 'W')
  names(losses)[2] <- "losses"
  
  if(stage != 'W')
    res <- merge(wins, losses, by = c("name"), all=TRUE)
  else
    res <- wins
  
  ## get rid of NAs, have 0 instead
  res[is.na(res)] <- 0
  
  ## sum the wins and losses into a new column played
  if(stage != 'W')
    res <- res[, played:=wins+losses]
  
  print(res)
  
  ## order by decreasing total matches
  if(stage != 'W')
    setorder(res, -played)
  else
    setorder(res, -wins)
  
  if(stage != 'W')
  res <- res[,c('name', 'played')]
   else
  res <- res[,c('name', 'wins')]
  
  #res <- res[1:100,]
  
  print(res)
}


CountSurfaceRound <- function(court, stage) {
  
  db <- db[surface == court]
  
  if(stage != 'W')
    db <- db[round == stage]
  
  if(stage == 'W')
    db <- db[round == 'F' & !str_detect(db$score, "ABN") & !str_detect(db$score, "WEA")]
  
  ## wins
  wins <- db[,.N, by=winner_name]
  names(wins)[1] <- "name"
  names(wins)[2] <- "wins"
  
  #losses
  if(stage != 'W')
  {
    losses <- db[,.N, by= loser_name]
    names(wins)[1] <- names(losses)[1] <- "name"
  }
  
  if(stage != 'W')
    names(losses)[2] <- "losses"
  
  if(stage != 'W')
    res <- merge(wins, losses, by = c("name"), all=TRUE)
  else
    res <- wins
  
  ## get rid of NAs, have 0 instead
  res[is.na(res)] <- 0
  
  ## sum the wins and losses into a new column played
  if(stage != 'W')
    res <- res[, played:=wins+losses]
  
  ## order by decreasing total matches
  if(stage != 'W')
    setorder(res, -played)
  else
    setorder(res, -wins)
  
  if(stage != 'W')
    res <- res[,c('name', 'played')]
  else
    res <- res[,c('name', 'wins')]
  
  #res <- res[1:20,]
  print(res)
}


CountCategoryRound <- function(category, stage) {

  db <- db[tourney_level == category]
  
  #extract year from tourney_date
  db$year <- stringr::str_sub(db$tourney_id, 0 ,4)
  
  #set range years
  db <- db[year > 2001]

  if(stage != 'W')
    db <- db[round == stage]
  
  if(stage == 'W')
    db <- db[round == 'F' & !str_detect(db$score, "ABN") & !str_detect(db$score, "WEA")]
  
  ## wins
  wins <- db[,.N, by=winner_name]
  names(wins)[1] <- "name"
  names(wins)[2] <- "wins"
  
  #losses
  if(stage != 'W')
  {
    losses <- db[,.N, by= loser_name]
    names(wins)[1] <- names(losses)[1] <- "name"
  }
  
  if(stage != 'W')
    names(losses)[2] <- "losses"
  
  if(stage != 'W')
    res <- merge(wins, losses, by = c("name"), all=TRUE)
  else
    res <- wins
  
  ## get rid of NAs, have 0 instead
  res[is.na(res)] <- 0
  
  ## sum the wins and losses into a new column played
  if(stage != 'W')
    res <- res[, played:=wins+losses]
  
  ## order by decreasing total matches
  if(stage != 'W')
    setorder(res, -played)
  else
    setorder(res, -wins)
  
  if(stage != 'W')
    res <- res[,c('name', 'played')]
  else
    res <- res[,c('name', 'wins')]
  
  
  #res <- res[1:20,]
  print(res)
}


CountTourRound <- function(id, stage) {
  
  ## only select matches of a tournament
  db$tourney_id <- sub("^[^-]*", "", db$tourney_id)
  
  db <- db[tourney_id == id]
  
  if(stage != 'W')
    db <- db[round == stage]
  
  if(stage == 'W')
    db <- db[round == 'F' & !str_detect(db$score, "ABN") & !str_detect(db$score, "WEA")]
  
  ## wins
  wins <- db[,.N, by=winner_name]
  names(wins)[1] <- "name"
  names(wins)[2] <- "wins"
  
  #losses
  if(stage != 'W')
  {
    losses <- db[,.N, by= loser_name]
    names(wins)[1] <- names(losses)[1] <- "name"
  }
  
  if(stage != 'W')
    names(losses)[2] <- "losses"
  
  if(stage != 'W')
    res <- merge(wins, losses, by = c("name"), all=TRUE)
  else
    res <- wins
  
  ## get rid of NAs, have 0 instead
  res[is.na(res)] <- 0
  
  ## sum the wins and losses into a new column played
  if(stage != 'W')
    res <- res[, played:=wins+losses]
  
  print(res)
  
  ## order by decreasing total matches
  if(stage != 'W')
    setorder(res, -played)
  else
    setorder(res, -wins)
  
  if(stage != 'W')
    res <- res[,c('name', 'played')]
  else
    res <- res[,c('name', 'wins')]
  
  res <- res[1:20,]
  print(res)
}
