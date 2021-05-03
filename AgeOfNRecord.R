# library
library(ggplot2)
library(forcats)

source("./Functions/Reader.R")
source("./Functions/Example.R")

db <- ParallelReader()

stat <- AgeOfNTitle()

stat <- stat[,c("winner_name", "winner_age")]

stat <- head(stat, 10)

## order by decreasing
stat %>% mutate(winner_name = fct_reorder(winner_name, winner_age)) %>%
  ggplot( 
            # keep all aesthetics in one place
    aes(x = winner_name, y = winner_age, color = winner_name, fill = winner_name, label = winner_age)) +
  # replacement of geom_bar(stat = "identity")
  geom_col() +
  # avoid overlap of text and bar to make text visible as bar and text have the same colour 
  geom_text(nudge_y = 1) + 
  # alternatively, print text inside of bar in discriminable colour
  # geom_text(nudge_y = -1, color = "black") + 
  ggtitle("Youngest player to win ATP title") +
  xlab("Winner") + ylab("Age") +
  theme_bw() + theme(legend.position = "none") + 
  theme(plot.title = element_text(hjust = 0.5))

