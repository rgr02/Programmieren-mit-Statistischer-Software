###################################################
### Konstrukte
###################################################

## Bedingte Anweisungen
x <- 5
if (x == 5) {
  x <- x + 1
  y <- 3
} else {
  y <- 7
}
c(x = x, y = y)

if (x < 99) print("x ist kleiner als 99")

ifelse(x == c(5, 6), c("A1", "A2"), c("B1", "B2"))

set.seed(1234)
x <- rnorm(10)
ifelse(x > 0, log(x), 0)

?switch
switch(2, a = 11, b = 12, cc = 13, d = 14)
switch("c", a = 11, b = 12, cc = 13, d = 14)
switch("cc", a = 11, b = 12, cc = 13, d = 14)

switch("c", a = 11, b = 12, cc = 13, d = 14, "default")

## Schleifen
i <- 0
repeat {
  i <- i + 1
  if (i == 3) break
}
i

i <- 0
repeat {
  i <- i + 1
  if (i < 3) next
  print(i)
  if (i == 3) break
}
i

i <- 0
while (i < 3)
  i <- i + 1
i

for (i in 1:10) {
  print(i)
  if (i < 3) next
  i <- i + 1
  print(i)
}

x <- c(3, 6, 4, 8, 0)
for (i in x) {
  print(i^2)
}


## Zeichenketten
x <- 8.25
cat("Das Objekt x hat den Wert:", x, "\n", sep = "\t")

paste("Datei", 1:3, ".txt", sep = "")
paste0("Datei", 1:3, ".txt")

x <- "Hermann MÃ¼ller"
strsplit(x, " ")
y <- "Hans_Meier"
grep("Hans", c(x, y))
sub("Ã¼", "ue", c(x, y))
sub("Ã¼", "ue", "LÃ¼lÃ¼")
gsub("Ã¼", "ue", "LÃ¼lÃ¼")
nchar(x)
toupper(x)

"Eine 'Zeichenkette' in einer Zeichenkette"
"Eine \"Zeichenkette\" in einer Zeichenkette"
'Eine "Zeichenkette" in einer Zeichenkette'
'Eine \'Zeichenkette\' in einer Zeichenkette'

paste("Eine", dQuote("Zeichenkette"), "in einer Zeichenkette")
oop <- options(useFancyQuotes = FALSE)
paste("Eine", dQuote("Zeichenkette"), "in einer Zeichenkette")
options(oop)

`1x / 5y` <- 3
`1x / 5y`

get("1x / 5y")


