###################################################
### Ein- und Ausgabe von Daten
###################################################

## ASCII-Dateien
list.files(pattern = "Mappe1.csv")
x <- read.csv2("Mappe1.csv")
x
str(x)
x$Geschlecht <- factor(x$Geschlecht, 0:1, c("m", "w"))
x
str(x)

?read.table
y <- read.table("Mappe1.csv", header = TRUE, sep = ";", dec = ",")
y
str(y)

write.table(iris, file = "iris.txt")
write.table(iris, file = "iris.txt",
            row.names = FALSE, quote = FALSE)
write.csv2(iris, file = "iris.csv")

list.files(pattern = "pima.*data")
pima <- read.csv("pima-indians-diabetes.data")
head(pima)
dim(pima)

pima <- read.csv("pima-indians-diabetes.data", header = FALSE)
dim(pima)

summary(pima)
pima$V9 <- factor(pima$V9, 0:1, c("no", "yes"))
summary(pima)

is.na(pima$V3[pima$V3 == 0]) <- TRUE
summary(pima)

## Binaerdaten
library("foreign")

demo <- read.spss("demo.sav")
class(demo)
str(demo)

demo <- read.spss("demo.sav", to.data.frame = TRUE)
str(demo)
dim(demo)
head(demo)
summary(demo)
attr(demo, "variable.labels")

demo <- read.spss("demo.sav", use.value.labels = FALSE, to.data.frame = TRUE)
summary(demo)

## R Objekte
levels(iris$Species) <- toupper(levels(iris$Species))
summary(iris)
save(iris, file = "iris.rda")

rm(iris)
summary(iris)

load("iris.rda")
summary(iris)
