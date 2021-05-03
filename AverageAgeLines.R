library(ggplot2)

source("./Functions/Reader.R")
source("./Functions/AverageAge.R")


db <- ParallelReader()

avg <- AverageAgeTour('-560', '0')

ggplot(avg, aes(x=year, y=mean_age, group = 1)) +
  geom_line() +
  geom_text(label = avg$mean_age) +
  ggtitle("Average age in Wimbledon")
