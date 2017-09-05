

# A 3.1 #######################################################################

a <- sample(c(-3:4),20, replace = TRUE)
b <- sample(letters, 8, replace = TRUE)

gerade <- 1:20
gerade <- gerade[gerade%%2==0]
gerade

l <- list(a,b,gerade)
names(l) <- c("Zufall", "Buchstaben", "Gerade")

# Möglichkeiten des Zugriffs
elem2 <- l[2] # gibt Liste zurück.  
elem2$Buchstaben
elem2[["Buchstaben"]]

elem12 <- l[c(1,2)]
elem12

# A 3.2 #######################################################################

m <- matrix(seq(1,199,by = 2), nrow = 10, ncol = 10)
m

x1 <- m[c(1:10)%%2 == 0,c(1:10)%%2 == 0 ]
x2 <- m[c(1:10)%%2 != 0,c(1:10)%%2 != 0 ]

sum <- rowSums(x1)
sum

as.matrix(x2[2,c(1,2)]) 
# Transponierte Ausgabe. Mit byrow = true ein Matrix Object erzeugen und 
# as.matrix zuweisen...

x2[2,c(1,2), drop = FALSE]

# A 3.3 #######################################################################

cars
dim(cars) # 2 Variablen, 50 Beobachtungen
cars[c(3,10,12),]

cars$dist

cars[c(1:3),]$dist

# A 3.4 #######################################################################
str(cars)
cars$zaehler <- 1:50 
str(cars)


rbind(colMeans(cars),cars) # Eintrab am Beginn des Datensatzes

# A 3.5 #######################################################################
chickwts
dim(chickwts)
sset <- subset(chickwts, feed == c("horsebean", "linseed"))
# Warning: horsebean und linsseed haben unterschiedliche Anzahl an Einträgen
str(set)

summary(chickwts$weight)
tapply(chickwts$weight, chickwts$feed, summary)
# function over array
          