# A1 ##########################################################################

set.seed(1234)
zahlen <- rnorm(250, mean = 1, sd = sqrt(2))
innerhalb <- zahlen[0 < zahlen & zahlen < 1 ]
innerhalb
neg <- zahlen[zahlen < -1]
pos <- zahlen[2 > zahlen]
außerhalb <- c(neg, pos)
außerhalb


# A2 ##########################################################################

zf <- sample(c(1,9,7,18,12,15), 100, replace = TRUE)
length(zf)
zf
y <- zf[zf>11]
length(y)
y
z <- zf[zf < 10]
length(Z)
z
gerade <- replace(zf, zf[zf%%2==0], zf[zf%%2==0]/2)
gerade

# A3 ##########################################################################

vec <- 1:100
vec <- vec[vec%%6==0]
length(vec)
vec
vec[1]
vec[length(vec)]
vec <- vec[1:(length(vec)-5)]
vec
let <- letters
let <- let[1:length(vec)]
names(vec) <- let
c(vec["a"],vec["j"],vec["v"] )

# A4 ##########################################################################
jahr <- c(1245, 1789, 2000, 2017)
ifelse(ifelse(jahr %% 4 == 0 | jahr %% 100 == 0|jahr %% 400 == 0,
              TRUE, FALSE) == TRUE & jahr %% 100 == 0, 
            " ist ein SJ & kein Schalttag", " ist ein SJ & Schaltag")

# A5 ##########################################################################
x <- -10:10
sd1 <- sqrt(1/(length(x)-1)*(sum(x^2)-length(x)*mean(x)^2))
sd1
sd(x)

x <- x/10000 + 10000
sd1 <- sqrt(1/(length(x)-1)*(sum(x^2)-length(x)*mean(x)^2))
sd1
sd(x)
