###################################################
### Mehr zu Graphik
###################################################

demo("graphics")

## Konfigurierbarkeit: par()
?par
example(par)

par("mfrow")
par("mar")
par("oma")
opar <- par(mfrow = c(1, 2))
opar
par()$mfrow
par(opar)
par()$mfrow
par()$oma

oldpar <- par(mfrow = c(2, 2), mar = c(5.1, 4.1, 4.1, 0.1),
              oma = c(0, 0, 4, 0))
for (i in 1:4) {
  x <- rnorm(1000,i,1)
  hist(x, main = paste("mean =", i),
       xlim = c(-1, 7), ylab = "frequency")
}
title("Normalverteilung", outer = TRUE)
par(oldpar)

oldpar <- par(mar = rep(4, 4), oma = rep(2, 4))
plot(Petal.Length ~ Petal.Width, data = iris)
box("figure", lty = 2)
par(oldpar)

oldpar <- par(mar = rep(4, 4), oma = rep(2, 4), mfrow = c(1, 2))
plot(Petal.Length ~ Petal.Width, data = iris)
box("figure", lty = 2, col = 2)
plot(Sepal.Length ~ Sepal.Width, data = iris)
box("figure", lty = 2, col = 3)
box("outer", lty = 1, col = 1)
box("inner", lty = 1, col = 1)
par(oldpar)

oldpar <- par(mfrow = c(1, 2))
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
par(oldpar)

## Low-level Graphik
x <- runif(600, 0, 1)
plot(x, axes = FALSE, xlab = "", ylab = "")
axis(1, c(10, 500), labels = c("10.0", "500.0"))
axis(2)
box()
title(xlab = "index")
text(10, 0, labels = "abcd")
mtext("Werte", 2, 2)
abline(h = mean(x), col = 2, lty = 2, lwd = 2)

plot(Sepal.Length ~ Sepal.Width, data = iris, xlim = c(1, 5),
     ylim = c(4, 8), axes = FALSE, xlab = "", ylab = "")
box()
axis(2)
axis(4)
axis(1, c(2, 4), c("2.0", "4.0"))
mtext("iris", 1, line = 0)
mtext("iris", 1, line = 4)
text(1.5, 7, "abc")

example(title)
example(points)

plot(Sepal.Length ~ Sepal.Width, data = iris)
points(3, 5, pch = 19, col = 4)
lines(c(2, 4), c(4, 7))


## Ausgabe von Graphik: Devices
?Devices
?pdf

pdf("myfig.pdf")
plot(x, pch = 17)
dev.off()

jpeg("myfig.jpeg")
plot(x, pch = 17)
dev.off()

pdf("myfig2.pdf", width = 12, height = 12)
plot(x, pch = 17)
dev.off()

## Farben
?palette
palette()

pie(rep(1, 10), col = 1:10)

palette(grey.colors(12))
pie(rep(1, 10), col = 1:10)
palette("default")

?rainbow
pie(rep(1, 10), col = rainbow(10))

if (!require("colorspace")) {
  install.packages("colorspace")
  library("colorspace")
}

?rainbow_hcl
pie(rep(1, 10), col = rainbow_hcl(10))


