
library(ade4)

#### mantel test using ade4
m1 <- read.csv(file="silgeog.csv", header = T, sep=",")
m1square <- m1[,-1017]
m1dist <- as.dist(m1square)

m2 <- read.csv(file = "silgen.csv", header = T, sep = ",")
m2square <- m2[,-1017]
m2dist <- as.dist(m2square)

mantel.rtest(m1dist, m2dist, nrepet = 999)

### I only want one marker at a time



GD515 <- read.csv(file = "Ots515gene.csv", header = T, sep = ",")
GD515dist <- as.dist(GD515)
GGD515 <- read.csv (file = "Ots515geog.csv", header = T, sep = ",")
GGD515dist <- as.dist(GGD515)

GDUW<- read.csv(file = "UWgene.csv", header = T, sep = ",")
GDUWdist <- as.dist(GDUW)
GGDUW <- read.csv (file = "UWgeog.csv", header = T, sep = ",")
GGDUWdist <- as.dist(GGDUW)

FbxGD<- read.csv(file = "Fbxgene.csv", header = T, sep = ",")
ncol(FbxGD)
x <- FbxGD[-1,]
y <- x[-1,]
z<- y[,-1016]
ncol(z)
nrow(z)
GDFbxdist <- as.dist(z)
FbxGGD <- read.csv (file = "fbxgeog.csv", header = T, sep = ",")
ncol(FbxGGD)
x <- FbxGGD[-1,]
y <- x[-1,]
z<- y[,-1016]
GGDFbxdist <- as.dist(z)

CryGD<- read.csv(file = "Crygene.csv", header = T, sep = ",")
GDCrydist <- as.dist(CryGD)
CryGGD <- read.csv (file = "Crygeog.csv", header = T, sep = ",")
GGDCrydist <- as.dist(CryGGD)

ClockGD<- read.csv(file = "Clockgene.csv", header = T, sep = ",")
ncol(ClockGD)
x <- ClockGD[-1,]
y <- x[-1,]
z<- y[,-1016]
ncol(z)
nrow(z)
GDClockdist <- as.dist(z)
ClockGGD <- read.csv (file = "Clockgeog.csv", header = T, sep = ",")
ncol(ClockGGD)
x <- ClockGGD[-1,]
y <- x[-1,]
z<- y[,-1016]
ncol(z)
nrow(z)
GGDClockdist <- as.dist(z)


NeuGD<- read.csv(file = "Neugene.csv", header = T, sep = ",")
GDNeudist <- as.dist(NeuGD)
NeuGGD <- read.csv (file = "Neugeog.csv", header = T, sep = ",")
GGDNeudist <- as.dist(NeuGGD)



sink("silmantel.txt") # write to file and ammend as you go by typing sink() by itself
cat("UW")
cat("\n")
mantel.rtest(GDUWdist, GGDUWdist, nrepet = 999)
cat("*********************")
cat("\n")
cat("\n")
cat("Clock")
cat("\n")
mantel.rtest(GDClockdist, GGDClockdist, nrepet = 999)
cat("*********************")
cat("\n")
cat("Fbxw11")
cat("\n")
mantel.rtest(GDFbxdist, GGDFbxdist, nrepet = 999)
cat("*********************")
cat("\n")
cat("Cry")
cat("\n")
mantel.rtest(GDCrydist, GGDCrydist, nrepet = 999)
cat("*********************")
cat("\n")
cat("")
cat("\n")
mantel.rtest(GD515dist, GGD515dist, nrepet = 999)
cat("*********************")
cat("\n")
cat("")
cat("\n")
sink()


mantel.rtest(GDNeudist, GGDNeudist, nrepet = 999)
sink()

file.show("silmantel.txt")




#### ##### ########   #### ##### ########   #### ##### ########

