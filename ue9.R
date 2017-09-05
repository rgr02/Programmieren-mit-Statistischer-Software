# install.packages("dplyr")
# install.packages("corrplot")
# install.packages("plot3D")


# Kreuztabellen visualisieren
# Mosaikplot, wie unterscheidet sich die Überlebenswahrscheinlichkeit für Frauen
# über Klassen 

library(dplyr)
library(corrplot)
# library(plot3D)

rm(list = ls())

# Aufgabe 1 ##################################################################################
co2 <- as.data.frame(CO2)
str(co2)

Quebec <- filter(co2, co2$Type == "Quebec")
Mississippi <- filter(co2, co2$Type == "Mississippi")
nonchilled <- filter(co2, co2$Treatment == "nonchilled")
chilled <- filter(co2, co2$Treatment == "chilled")

teildaten <-
  as.data.frame(cbind(
    Quebec$uptake,
    Mississippi$uptake,
    nonchilled$uptake,
    chilled$uptake
  ))
names(teildaten) <-
  c("Quebec", "Mississippi", "nonchilled", "chilled")

sapply(teildaten, mean)
sapply(teildaten, sd)

plot(CO2$uptake ~ CO2$Plant, col = co2$Plant)
plot(CO2$uptake ~ CO2$Treatment, col = co2$uptake)
plot(CO2$uptake ~ CO2$conc, col = co2$conc)


# Aufgabe 2 ################################################################################
rm(list = ls())
str(Titanic)


margin.table(Titanic, c(2,4))
prop.table(margin.table(Titanic, c(2,4)))

absolute.nr <- apply(Titanic, c(2, 4), sum)
absolute.nr
prop.table(absolute.nr)
#x/sum(x)
barplot(absolute.nr, beside = TRUE)

absolute.nr <- apply(Titanic, c(1, 2, 4), sum)
prob <- prop.table(ftable(absolute.nr))
prob

barplot(prob, beside = T, horiz = TRUE)
barplot(prob, beside = T, col = c(1,2))
# Class zur Färbung ? 
str(prob)
attributes(prob)

# xtabs(Titanic$Survived ~ Titanic$Sex, data = Titanic)
# table(Titanic$Class, Titanic$Sex)
# gesamt <- sum(Titanic$Freq)

# Aufgabe 3 ################################################################################
rm(list = ls())
library(MASS)
dim(road)
str(road)
summary(road)

plot(road$deaths ~ road$popden)
plot(road$deaths ~ road$rural)
plot(road$deaths ~ road$temp)
plot(road$deaths ~ road$fuel)

pairs(road)

road <- filter(road, (road$popden < 2000) & (road$deaths < 3000) &
               (road$temp > 20) & (road$fuel < 250))

pairs(road)
corr <- cor(road)
corrplot(corr = corr, method = "number")

summary(m <- lm(
  road$deaths ~
    road$popden +
    road$rural +
    road$temp,
  data = road
))

plot(road$deaths ~ road$popden)
plot(road$deaths ~ road$rural)
abline(lm(road$deaths ~ road$rural))
plot(road$deaths ~ road$temp)
plot(road$deaths ~ road$fuel)


# Aufgabe 5 ########################################################################
rm(list = ls())
data <- read.table("D:/R/data/student-mat.csv",sep=";",header=TRUE)
data <- as.data.frame(data)

dim(data)
# 33 Variablen, 395 observations

str(data)
# int: G1, G2, G3 -> correlation

#data %>% select(data$G1, data$G2, data$G3)

sapply(data[,31:33],mean)
boxplot(data[,31:33], horizontal = TRUE)

cor <- cor(data[,31:33], method = "pearson")
corrplot(corr = cor, method = "number")

summary(data$G3)
data$G3ord <- NA
data[data$G3 >= 14,]$G3ord <- 1
data[data$G3 < 14 & data$G3 >= 8,]$G3ord <- 2
data[data$G3 <8,]$G3ord <- 3

data$G3ord <- factor(data$G3ord, labels = c("gut", "mittel", "schlecht"))
str(data)

corrplot(corr = cor, method = "number")

factor.vars <- data[which(sapply(data, is.factor))]
non.factors <- data[which(!data %in% factor.vars)]
str(non.factors)
non.factors$G3ord <- data$G3ord

cor <- cor(x = non.factors, y = data$G3ord, method = "spearman")

# Lesen von Web funktioniert
temp <- tempfile()
download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip",temp)
data <- read.csv2(unz(temp, "student-mat.csv"))
unlink(temp)
