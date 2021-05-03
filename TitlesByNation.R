# library
library(ggplot2)

source("./Functions/Reader.R")
source("./Functions/Nationality.R")

db <- ParallelReader()

stat <- titlesByNation()

stat <- head(stat, 10)

# basic histogram
ggplot(stat, aes(db, y=N, fill=db)) + geom_bar(stat="identity") +
  geom_text(aes(label=N), vjust=0) +
  ggtitle("ATP Titles by Nation")
