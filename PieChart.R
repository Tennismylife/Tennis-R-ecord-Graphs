# library
library(ggplot2)

source("./Functions/Reader.R")
source("./Functions/Nationality.R")
source("./Functions/Counter.R")

db <- ParallelReader()

stat <- CountCategoryRound('G', 'W')

stat <- head(stat, 10)

# Basic piechart
ggplot(stat, aes(x="", y=wins, fill=name)) +
  ggtitle("Slammers Pie Chart") +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)
