###################################################
### Statistik mit R
###################################################

## Grundlegende Funktionen

x <- c(5, 7, 2, 7, 8, 9)
sort(x)
sort(x, decreasing = TRUE)
rev(sort(x))

(index <- order(x))
x[index]

X <- data.frame(x = c(2, 2, 1, 1), y = c(1, 2, 2, 1))
(temp <- order(X[,1], X[,2]))
X[temp, ]

rank(x)
rank(c(1, 4, NA, 4))
rank(c(1, 4, NA, 4), na.last = FALSE)
rank(c(1, 4, NA, 4), ties.method = "first")
rank(c(1, 4, NA, 4), ties.method = "last")
rank(c(1, 4, NA, 4), ties.method = "random")
rank(c(1, 4, NA, 4), ties.method = "max")
rank(c(1, 4, NA, 4), ties.method = "min")

duplicated(x)
unique(x)

## Lage-, Streu- und Zusammenhangsmasse
x <- runif(100)
mean(x)
median(x)
quantile(x)
summary(x)
mad(x)
range(x)
diff(range(x))
var(x)
sd(x)
IQR(x)

y <- runif(100)
cor(x, y, method = "pearson")
cor(x, y, method = "spearman")
cov(x, y)

head(trees)
trees <- as.matrix(trees)
set.seed(1234)
cor(trees)
is.na(trees[sample(length(trees), 10)]) <- TRUE
head(trees)
cor(trees)
cor(trees, use = "complete.obs")
cor(trees, use = "pairwise.complete.obs")


## Weitere nuetzliche Helfer
x <- c(3, 5, 7, 6)
cumsum(x)
cumprod(x)

choose(6, 4)
factorial(6) / (factorial(4) * factorial(2))
gamma(7) / (gamma(5) * gamma(3))

set.seed(123)
x <- rnorm(10)
(xd <- cut(x, breaks = c(-Inf, -2, -0.5, 0.5, 2, Inf)))
table(xd)

## Tests
head(sleep)
boxplot(extra ~ group, data = sleep)

test.output <- t.test(extra ~ group, data = sleep)
test.output
str(test.output)

t.test(extra ~ group, data = sleep, paired = TRUE)

sleep.wide <- reshape(sleep, idvar = "ID", timevar = "group",
                      v.names = "extra", direction = "wide")   
head(sleep.wide)   
head(reshape(sleep.wide, direction = "long"))
plot(extra.2 ~ extra.1, data = sleep.wide,
     xlim = range(sleep$extra), ylim = range(sleep$extra))
abline(a = 0, b = 1, lty = 2)

with(sleep.wide, boxplot(extra.2 - extra.1))
abline(h = 0, lty = 2)

with(sleep.wide, t.test(extra.1, extra.2, paired = TRUE))
with(sleep.wide, t.test(extra.1 - extra.2))

with(sleep.wide, wilcox.test(extra.1 - extra.2))

HairEyeColor
HairGender <- margin.table(HairEyeColor, c(3, 1))
chisq.test(HairGender)

prop.table(HairGender, 1)
mosaicplot(HairGender, shade = TRUE)

HairEye <- margin.table(HairEyeColor, c(2, 1))
chisq.test(HairEye)

prop.table(HairEye, 1)
mosaicplot(HairEye, shade = TRUE)
