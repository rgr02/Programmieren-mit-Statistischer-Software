###################################################
### Noch mehr Details zur Sprache
###################################################

## Pakete
## install.packages("tm")
help(package = "tm")

vignette(package = "tm")
x <- vignette("tm", package = "tm")

## Datum 
x <- Sys.Date()
x
str(x)
class(x)
unclass(x)
y <- as.Date("2017-01-01")
y <- as.Date("01.01.2017", "%d.%m.%Y")
y

x - y

format(y, "%Y")

time <- "13:27:00"
datetime <- paste(x, time)
datetime
datetime <- strptime(datetime, "%Y-%m-%d %H:%M:%S")
str(datetime)
unclass(datetime)

as.Date(datetime)

## Zeichenketten
x <- c("Hans MÃ¼ller", "Hermann Maier")
x
strsplit(x, split = "")
sapply(strsplit(x, split = ""), table)

x <- tolower(x)
x

toupper(x)

tab <- sapply(strsplit(x, split = ""), function(x) {
  x <- factor(x, c(letters, "Ã¤", "Ã¶", "Ã¼", "ÃŸ", " "))
  table(x)
})
tab

colSums(tab)
nchar(x)

strsplit(x, " ")

grep("Ã¼", x)
grep("a", x)
grep("Ã¶", x)
gsub("Ã¼", "ue", x)

substr(x, 1, 5)


## RegulÃ¤re AusdrÃ¼cke
## Siehe auch auf Wikipedia
## http://de.wikipedia.org/wiki/RegulÃ¤rer_Ausdruck

grep("a.+c", c("abc", "acc", "abb", "ac", "abbc"))
grep("a.*c", c("abc", "acc", "abb", "ac", "abbc"))
grep("ab+c", c("abc", "acc", "abb", "ac", "abbc"))
grep("ab*c", c("abc", "acc", "abb", "ac", "abbc"))
gsub(".* ", "", x)
grep("a", c("abc", "bac"))
grep("^a", c("abc", "bac"))
grep("a$", c("abc", "baca"))
gsub("(^ *| *$)", "", c(" abc ", "  abc  "))
grep(".", c("abc.", "abc"))
grep(".", c("abc.", "abc"), fixed = TRUE)
grep(".$", c("abc.", "ab.c"), fixed = TRUE)
grep("\\.$", c("abc.", "ab.c"))

data("Cars93", package = "MASS")
make <- as.character(Cars93$Make)
make
strsplit(make, " ")[1:10]
firm <- sapply(strsplit(make, " "), "[", 1)
firm
sort(table(firm), decreasing = TRUE)
Cars93$Make <- gsub("Chrylser", "Chrysler", Cars93$Make)
sort(table(firm), decreasing = TRUE)


