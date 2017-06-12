###################################################
### Mehr zu Daten in R
###################################################

## Matrizen
x <- 1:12
x
X <- matrix(x, nrow = 3)
X

X1 <- matrix(x, nrow = 3, byrow = TRUE)
X1

matrix(1:11, nrow = 3, ncol = 4)
X

dim(X)
nrow(X); ncol(X)

x <- 1:12
x
dim(x) <- c(4, 3)
x
str(x)

x <- 1:12
as.matrix(x)

X[2, 3]
X[2, ]
X[1:2, ]
X[1, , drop = FALSE]
X[1, 2, drop = FALSE]

X
Y <- matrix(rnorm(length(X)), nrow = nrow(X))
Y
X
X + Y
X - Y
X * Y
X^2
X / X
X * 1:3
## X * matrix(1:3, nrow = 3, ncol = 2)

t(X)
cbind(X, 1:3)
rbind(X, 1:4)
rbind(X, 1)

## Arrays
A <- array(1:12, dim = c(2, 2, 3))
A

A[1, 2, 3]
A[1, , ]

Titanic
str(Titanic)
dimnames(Titanic)
Titanic["1st", "Female", , ]
Titanic["3rd", "Male", , ]
ftable(Titanic)

## Listen
str(dimnames(Titanic))

ll <- list(a = 1:10, b = letters)
ll

ll$a
ll$b
ll <- c(ll, list(rnorm(3)))
ll
ll[[3]]
ll[[1]]
ll[["a"]]

ll[1]
ll[c(1, 3)]

## Faktoren
geschlecht <- sample(1:2, 10, replace = TRUE)
geschlecht
geschlecht <- factor(geschlecht, levels = 1:2, labels = c("m", "w"))
geschlecht
str(geschlecht)
table(geschlecht)
summary(geschlecht)
factor(sample(1:3, 10, replace = TRUE), 1:3,
       c("schlecht", "mittel", "gut"), ordered = TRUE)

## Data frames
cbind(alter = rnorm(10, 45), geschlecht = geschlecht)
list(alter = rnorm(10, 45), geschlecht = geschlecht)
df <- data.frame(alter = rnorm(10, 45), geschlecht = geschlecht)

df[1, ]
df$alter
df[df$alter > 45, ]
subset(df, alter > 45)


