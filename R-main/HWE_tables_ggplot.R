#### Make a few graphs from HWE output in the pipleine ####

# load a few packages in case you need the##
library(ggplot2)
library(tidyr)
library(reshape2)
library(dplyr)


HWE_funct_pop <- read.table("data/HWE_perc_signif_tests_popsfunctG2.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

HWE_funct_pop_select <- HWE_funct_pop %>%
  select(HWD.at.001,HWD.at.05, Pop) 


#transform if necessary into long format to do plotting
Snot<- HWE_funct_pop_select %>%
  gather(HWD, Percent_sig, -Pop)  %>%
  select(Pop, HWD, Percent_sig)

ggplot(Snot, aes(x = Pop, y = Percent_sig, fill = Pop)) + 
  facet_grid( ~ HWD, scales = "free_x") +
  geom_bar(stat = "identity") +
  geom_hline(yintercept = 10, color= "black") +
  geom_hline(yintercept = 40, color = "red") +
  ggtitle("HWE percent significant comparisons: \nfunctional G2 genes by locus") + 
  theme(plot.title = element_text(lineheight = .8, face = "bold"))

ggsave(file = "HWE_functG2_pop_vis.pdf")



### the loci file ####
HWE_funct_loci <- read.table("data/HWE_perc_signif_tests_locs_functG2.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

HWE_funct_loci_select <- HWE_funct_loci %>%
  select(HWD.at.001,HWD.at.05, Locus) 

#transform if necessary into long format to do plotting
Snot2<- HWE_funct_loci_select %>%
  gather(HWD, Percent_sig, -Locus)  %>%
  select(Locus, HWD, Percent_sig)
  
ggplot(Snot2, aes(x = Locus, y = Percent_sig, fill = Locus)) + 
  facet_grid( ~ HWD, scales = "free_x") +
  geom_bar(stat = "identity") +
  geom_hline(yintercept = 10, color= "black") +
  geom_hline(yintercept = 40, color = "red") +
  ggtitle("HWE percent significant comparisons: \nfunctional G2 genes by loc") + 
  theme(plot.title = element_text(lineheight = .8, face = "bold"))

ggsave(file = "HWE_functG2_locs_vis.pdf")
