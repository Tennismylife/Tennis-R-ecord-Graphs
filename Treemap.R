# library
library(ggplot2)
library(treemap)

source("./Functions/Reader.R")
source("./Functions/Nationality.R")
source("./Functions/Counter.R")

db <- ParallelReader()

stat <- CountCategoryRound('M', 'W')

# Create data
group <- stat[,c('name')]
value <- stat[,c('wins')]

names(group)[1] <- 'group'
names(value)[1] <- "value"

data <- data.frame(group, value)

data$group <- paste0(data$group, "\n ", data$value)

# treemap
treemap(data, index=c("group"), vSize=c("value"))

