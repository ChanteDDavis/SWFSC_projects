#### working to change data from wide to long using Rrrrr ####

library (tidyr)
library(plyr)
library(dplyr)
library(reshape2)
library(ggplot2)
library(stringr)
#1) import data
Snot <- read.table("data/threedigit_090915.txt", sep = "\t", header = TRUE, stringsAsFactors= FALSE) %>%
  tbl_df
View(Snot)

Snot <- read.table("data/threedigit_tidyfunct_090915.txt", sep = "\t", header = TRUE, stringsAsFactors= FALSE) %>%
  tbl_df
View(Snot)

# Make missing data NAs
Snot[Snot == 0] <- NA


#2) transform data from wide to long
Snot2<- Snot %>%
  gather(Loci_Name, Allele, -Sample.ID)  %>%
  mutate(Locus = str_replace_all(Loci_Name, "\\.1$", ""), 
         Pop = str_replace_all(Sample.ID, "[0-9]*", ""))  %>% # deal with locus names and the .1's and get pop names
  select(Pop, Sample.ID, Locus, Allele)


Snot3 <- Snot2 %>% # cb:EA
  filter(!is.na(Allele)) %>% # cb:EA
  group_by(Pop, Locus, Allele) %>% # cb:EA
  tally() # cb:EA

# Snot3 is now grouped by Pop and Locus
totals = Snot3 %>%
  tally() %>%
  rename(tot = n)
View(totals)
# now this might be inelegant but it works
df <- Snot3 %>%
  inner_join(totals) %>%
  mutate(freq = n/tot)

# to position sample size text we need to know the approximate extent of the
# x-axes
df <- df %>%
  group_by(Locus) %>%
  summarize(middle = (max(Allele) + min(Allele))/2) %>%
  inner_join(df, .)

# now df is the data frame we want for plotting.
ggplot(df, aes(x = Allele, y = freq, fill = Pop, colour = Pop)) + 
  facet_grid(Pop ~ Locus, scales = "free_x") + 
  geom_bar(stat = "identity") +
  geom_text(aes(x = middle, y = 0.75, label = tot), colour = "black")
  
ggsave(file = "crazyfunct.pdf", width = 40, height = 18)



  
  
 
 

