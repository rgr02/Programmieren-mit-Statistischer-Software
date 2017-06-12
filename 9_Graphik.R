###################################################
### Graphik
###################################################

## Base graphics
x <- seq(-pi, pi, length.out = 20)
y <- rnorm(length(x), 3 * sin(x))
plot(x, y)
lines(x, 3 * sin(x), col = 2)

plot(y ~ x)
points(x, 3 * sin(x), col = 2, type = "b")

x <- seq(-5, 5, length.out = 100)
plot(x, dnorm(x), type = "l")

curve(dnorm, from = -5, to = 5)
curve(dnorm(x, 0, 1.5), from = -5, to = 5, 
      col = 2, add = TRUE)
curve(dnorm(x, 0, 2), from = -5, to = 5, 
      col = 3, add = TRUE)
legend("topright", legend = paste0("sd = ", c(1, 1.5, 2)),
       lty = 1, col = 1:3)

## Visualisierung von Daten
## Metrische Variablen 
head(iris)

hist(iris$Sepal.Width)
hist(iris$Sepal.Width, freq = FALSE)

summary(iris$Sepal.Width)
hist(iris$Sepal.Width, breaks = seq(2, 5, length.out = 10),
     include.lowest = TRUE)

hist(iris$Sepal.Width, 10)
hist(iris$Sepal.Width, 100)

boxplot(iris$Sepal.Width)
fivenum(iris$Sepal.Width)
summary(iris$Sepal.Width)

boxplot(subset(iris, Sepal.Width > 2.5)$Sepal.Width)
summary(subset(iris, Sepal.Width > 2.5)$Sepal.Width)

boxplot(Sepal.Width ~ Species, data = iris)
boxplot(Sepal.Width ~ Species, data = iris, notch = TRUE)
boxplot(Sepal.Width ~ Species, data = iris[-c(1:20), ],
        notch = TRUE, varwidth = TRUE)

plot(Sepal.Width ~ Sepal.Length, data = iris, col = iris$Species)

coplot(Sepal.Width ~ Sepal.Length | Species, data = iris)

pairs(iris)
plot(iris)
pairs(iris[, 1:4], col = iris$Species)

hist(iris$Petal.Width, freq = FALSE)
lines(density(iris$Petal.Width), col = 2)

## Kategorielle Variablen
plot(iris$Species)

tab <- table(iris$Species)
tab
class(tab)
plot(tab)

barplot(table(iris$Species))

sl <- cut(iris$Sepal.Length, seq(4, 8, by = 1))
table(sl)
sw <- cut(iris$Sepal.Width, seq(2, 5, by = 1), 
          include.lowest = TRUE)
table(sw)
tab <- table(sl, sw)
plot(tab)

barplot(tab)
barplot(tab, legend = TRUE)
barplot(tab, beside = TRUE)
barplot(tab, beside = TRUE, legend = TRUE)

he <- margin.table(HairEyeColor, c(1, 2))
he
plot(he)

barplot(he)
barplot(he, legend = TRUE)
barplot(he, beside = TRUE, legend = TRUE)

hep <- prop.table(he, 2)
barplot(hep)
barplot(hep, legend = TRUE)


