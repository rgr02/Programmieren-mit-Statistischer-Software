###################################################
### Weitere Details der Sprache, Vergleich von Objekten
###################################################

## Vergleich von Objekten
x <- c(1, 2, 3)
y <- c("1", "2", "3")
x == y
identical(x, y)
as.integer(y)
identical(x, as.integer(y))

y <- 1:3
identical(x, y)
str(x)
str(y)
identical(as.integer(x), y)

identical(as.integer(x), y)
all.equal(x, y)
y <- c("1", "2", "3")
all.equal(x, y)
isTRUE(all.equal(x, y))
isTRUE(TRUE)

a <- sqrt(2)
a * a
identical(a * a, 2)
a * a == 2
all.equal(a * a , 2)
a * a - 2
abs(a * a - 2) < .Machine$double.eps^0.5

## Umgang mit Sprachobjekten
round(12.3456, digits = 2)

(mycall <- call("round", 12.3456, digits = 2))
mode(mycall)
eval(mycall)

do.call("round", list(12.3456, digits = 2))

quote(round(12.3456, digits = 2))

(zeichen <- "round(12.3456, digits = 2)")
mode(zeichen)
(ausdruck <- parse(text = zeichen))
mode(ausdruck)
eval(ausdruck)

deparse(call("round", 12.3456, digits = 2))

(myexpr <- expression(x <- 12.3456, round(x, digits = 2)))
mode(myexpr)
eval(myexpr)
(call1 <- myexpr[[1]])
mode(call1)
print(eval(call1))

## Objektorientiertes Programmieren: S3-Methoden und -Klassen
x <- matrix(1:12, nrow = 4)
x
attributes(x)
attr(x, "dim")
attr(x, "dim") <- c(6, 2)
as.vector(x)

print
methods(print)
print.default
exists("print.xtabs")
getS3method("print", "xtabs")

gender <- factor(sample(0:1, 10, replace = TRUE), 0:1, c("m", "w"))
print(gender)
print.default(gender)
print.factor(gender)

mean
methods(mean)
methods(class = "factor")

S3objekt <- structure(list(), class = "klasse")
S3objekt <- list()
class(S3objekt) <- "klasse"

class(S3objekt)
inherits(S3objekt, "klasse")

erzeuge.S3objekt <- function(x) {
  if (!is.numeric(x)) stop("X must be numeric")
  structure(list(x), class = "klasse")
}
erzeuge.S3objekt(1:10)

gender
class(gender)
class(gender) <- "klasse"
gender
str(gender)

f <- function(x) UseMethod("f")
f.a <- function(x) "Class a"
a <- structure(list(), class = "a")
class(a)
f(a)
mean.a <- function(x) "a"
mean(a)

mean.default
mean(S3objekt)


