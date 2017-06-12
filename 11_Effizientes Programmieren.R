###################################################
### Effizientes Programmieren
###################################################

## Programmierstil
wuerfel <- function() {
  x <- sample(1:10, 100, replace = TRUE)
  sum(x == 8)
}
wuerfel()

wuerfel <- function(Seiten, N, Augenzahl) {
  stopifnot(is.numeric(Seiten), Seiten > 1)
  stopifnot(is.numeric(N), N >= 1)
  stopifnot(is.numeric(Augenzahl))
  # Generieren von N WÃ¼rfen eines WÃ¼rfels mit "Seiten" Seiten:
  x <- sample(1:Seiten, N, replace = TRUE)
  # ZÃ¤hlen, wie oft die Augenzahl "Augenzahl" vorkommt:
  sum(x == Augenzahl)
}
wuerfel(10, 100, 8)
wuerfel(6, 1000, 6)

wuerfel<-function(){x<-sample(1:10,100,replace=TRUE)
sum(x==8)}


## Laufzeiten bestimmen
anteil <- function(x, p) {
  j <- 0
  for (i in 1:(length(x))) {
    if (x[i] < p) {
      j <- j+1
    }
  } # for
  return(j/length(x))
}

x <- rnorm(100000)
start <- proc.time()
anteil(x, 0.6)
end <- proc.time()
end - start

system.time({
  anteil(x, 0.6)  
})

anteil2 <- function(x, p) {
  mean(x < p)
}
system.time({
  anteil2(x, 0.6)  
})

system.time({h <- x + 2})
mean(h)

system.time({
  h <- NULL
  for (i in seq_along(x)) {
    h <- c(h, x[i] + 2)
  }  
})
mean(h)

system.time({
  h <- vector("numeric", length(x))
  for (i in seq_along(x)) {
    h[i] <- x[i] + 2
  }  
})
mean(h)

x <- matrix(rnorm(1000), nrow = 100)
m <- vector("numeric", length = ncol(x))
for (i in 1:ncol(x)) {
  m[i] <- mean(x[, i])  
}
m

all.equal(colMeans(x), m)
identical(colMeans(x), m)


## apply() und Co
apply(x, 2, mean)
apply(x, 2, sd)
apply(x, 1, sd)
apply(x, 2, function(y) c(m = mean(y), sd = sd(y)))

apply(iris[, 1:4], 2, function(y) c(m = mean(y), sd = sd(y)))
apply(iris, 2, function(y) c(m = mean(y), sd = sd(y)))

head(as.matrix(iris))
head(as.matrix(iris[, 1:4]))

apply(iris, 2, class)
apply(iris, 2, is.vector)
mean(c("1", "2"))
var(c("1", "2"))

lapply(iris, function(x) if (is(x, "factor")) table(x) else mean(x))
lapply(iris, function(x) if (is(x, "factor")) names(which.max(table(x))) else mean(x))
sapply(iris, function(x) if (is(x, "factor")) names(which.max(table(x))) else mean(x))

with(iris, tapply(Sepal.Length, Species, mean))
sapply(split(iris, iris$Species), dim)
str(split(iris, iris$Species))


