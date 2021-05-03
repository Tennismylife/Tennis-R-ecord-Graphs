library(plot3D)

source("./Functions/Timespan.R")
source("./Functions/Reader.R")

db <- ParallelReader()

titles <- TimespanCategoryEntry('G', 'W')
finals <- TimespanCategoryEntry('G', 'F')
semifinals <- TimespanCategoryEntry('G', 'SF')


x <- c("Jimmy connors", "Roger Federer", "Rafael Nadal")
y <- c("Titles", "Finals", "Semifinals")

x <- c(1, 2, 3)
y <- c(1, 2, 3)

## Jimmy Connors

dataConnors <- NULL

titlesConnors <- subset(titles, Player == 'Jimmy Connors')
dataConnors[1] <- titlesConnors[,c("days")]
dataConnors[1] <- gsub('days', '', dataConnors[1])

finalsConnors <- subset(finals, Player == 'Jimmy Connors')
dataConnors[2] <- finalsConnors[,c("days")]
dataConnors[2] <- gsub('days', '', dataConnors[2])

semifinalsConnors <- subset(semifinals, Player == 'Jimmy Connors')
dataConnors[3] <- finalsConnors[,c("days")]
dataConnors[3]  <- gsub('days', '', dataConnors[3])


##  Roger Federer

dataFederer <- NULL

titlesFederer <- subset(titles, Player == 'Roger Federer')
dataFederer[1] <- titlesFederer[,c("days")]
dataFederer[1] <- gsub('days', '', dataFederer[1])

finalsFederer <- subset(finals, Player == 'Roger Federer')
dataFederer[2] <- finalsFederer[,c("days")]
dataFederer[2] <- gsub('days', '', dataFederer[2])

semifinalsFederer <- subset(semifinals, Player == 'Roger Federer')
dataFederer[3] <- finalsFederer[,c("days")]
dataFederer[3]  <- gsub('days', '', dataFederer[3])

##  Rafael Nadal

dataNadal <- NULL

titlesNadal <- subset(titles, Player == 'Rafael Nadal')
dataNadal[1] <- titlesNadal[,c("days")]
dataNadal[1] <- gsub('days', '', dataNadal[1])

finalsNadal <- subset(finals, Player == 'Rafael Nadal')
dataNadal[2] <- finalsNadal[,c("days")]
dataNadal[2] <- gsub('days', '', dataNadal[2])

semifinalsNadal <- subset(semifinals, Player == 'Rafael Nadal')
dataNadal[3] <- finalsNadal[,c("days")]
dataNadal[3]  <- gsub('days', '', dataNadal[3])


dataConnors <- as.integer(dataConnors)
dataFederer <- as.integer(dataFederer)
dataNadal <- as.integer(dataNadal)
  
zval = c(dataConnors[1], dataConnors[2], dataConnors[3],
         dataFederer[1], dataFederer[2], dataFederer[3],
         dataNadal[1], dataNadal[2], dataNadal[3])

# Convert Z values into a matrix.
z = matrix(zval, nrow=3, ncol=3, byrow=TRUE)


hist3D(x,y,z, zlim=c(3000, 8000), theta=40, phi=40, axes=TRUE,label=TRUE, nticks=5,
       ticktype="detailed", space=0.5, lighting=TRUE, light="diffuse", shade=0.5, 
       xlab = "connors | Federer | Nadal",
       ylab ="Titles | Finals | Semifinals")
