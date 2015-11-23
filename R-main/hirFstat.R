##### HierFST ####
# some functions to use
boot.ppfst # performs bootstrapping over loci of pairwise Fst
basic.stats # basic statistics
allelic.richness # estimate
allele.count # count
eucl.dist #
g.stats #
g.stats.glob #
write.fstat # write Fstat data file
write.struct # write file for running in structure

library(dplyr)
library(reshape2)
library(tidyr)
library(stringr)

### Practice ###

library(hierfstat)

data(yangex)
varcomp(yangex)
data("gtrunchier")
allele.count(gtrunchier[,-2])
varcomp()

varcomp.glob(data.frame(Locality = gtrunchier$Locality,Patch = gtrunchier$Patch), gtrunchier[,-c(1,3)])


Booger <- read.table("data/boing.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE,na.strings = "0")

Booger<- Booger[,2:20]
Booger<- Booger[,-c(3)]
Booger %>% tbl_df

allele.count(Booger[,-2])
allelic.richness(Booger[,-2])
g.stats.glob(Booger[,-2])
basic.stats(Booger[,-2])


varcomp.glob(data.frame(Locality = Booger$Locality, Patch = Booger$Patch), Booger[,-c(1,2)])

loc<- data.frame(Booger[,c(3:18)])
lev<- data.frame(Booger[,c(1,2)])


allele.count(Booger[,-1])


