###################################################
### Logik und Datenstrukturen
###################################################

## Zufallszahlen
sample(1:12)
sample(12)
?sample
sample(100, size = 10)
x <- sample(1:2, size = 100, replace = TRUE)
table(x)
tabulate(x)
y <- sample(c(1, 3, 4), size = 100, replace = TRUE)
table(y)
tabulate(y)
x <- sample(1:2, size = 100, replace = TRUE, prob = c(1, 5))
table(x)
y <- sample(c("a", "A"), size = 100, replace = TRUE)
table(y)

?Distributions
z <- rnorm(10)
z
?rnorm
rnorm(10, mean = 10, sd = 0.01)

set.seed(1234)
rnorm(2)
set.seed(1234)
rnorm(2)

## Logik
4 < 3
(3 + 1) != 3
-3 < -2

1:5 < 4
1:5 <= 4

1:5 == 4
1:5 != 4
!1:5 == 4
!(1:5 == 4)

1:6 < 2:3

(3 >= 2) && (4 == (3 + 1))

set.seed(1234)
z <- rnorm(10)
sum(z > -1 & z < 1)
z

z1 <- rnorm(10)
all(z == z1)
any(z == z1)

c(TRUE, FALSE) & c(FALSE, FALSE)
c(TRUE, FALSE, TRUE) | c(FALSE, FALSE, TRUE)

c(TRUE, FALSE) && c(FALSE, FALSE)
c(TRUE, FALSE) || c(FALSE, FALSE)

FALSE & TRUE
FALSE & sqrt(-1)
FALSE && sqrt(-1)

TRUE == T
!F
F <- TRUE
!F

## Fehler:
## FALSE <- TRUE

TRUE + FALSE
FALSE + TRUE + FALSE
TRUE + TRUE + FALSE
TRUE - FALSE - TRUE
which(z > 1)
sum(z > 1)

x <- NA
str(NA)
y <- c(3, x)
str(y)

x < 3
TRUE & x
TRUE | x

x <- c(5, 7, NA, 22)
x == NA
is.na(x)
is.na(x[1]) <- TRUE
x

mean(x)
mean(x, na.rm = TRUE)
na.omit(x)


## Datentypen
(x <- pi)
mode(x)
typeof(x)
(y <- as.integer(x))
mode(y)
typeof(y)

logical(2)
numeric(2)
integer(2)
complex(2)
character(2)

y
str(y)
is.logical(y)
is.numeric(y)
is.integer(y)
is.character(y)

x <- c(-2, 3, 1.4, -4.2, 0)
as.logical(x)
as.numeric(as.logical(x))
as.character(x)

as.logical(-3:3)
!-3:3
x <- -3:3
!x

x <- c("abc", "def")
x
str(x)
mode(x)

## Fehler:
## !x

!as.numeric("1.2")

## Fehler:
## !"1.2"

c(TRUE, FALSE, 3, 6)
c(TRUE, FALSE, 3, 6, "abc")

(x <- c(4.1, 5.0, 6.35))
(x <- c(7.9, x, 2))
(y <- c("Hallo", "Leser"))
(y <- c("Hallo", TRUE, x))
length(y)

c(WertA = 5, WertB = 99)

z <- rnorm(20)
z[3]
z[c(20, 3)]
z[z > 1]
z[-c(1:15)]

x <- c(a = 1, b = 2)
x
x["b"]

x <- c(3, 6, 9, 8, 4, 1, 2)
x[9:10] <- 10:9
x
x[] <- 2
x
(x <- 2)

z <- rnorm(20)
dim(z) <- c(4, 5)
z
z[1, ]
dim(z) <- NULL
z
dim(z) <- c(2, 2, 5)
z


