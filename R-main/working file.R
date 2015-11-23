### som other useful scripts that helped me get data ready for Mantel tests
### I started with a Siletz 3 digit file that had new sample ID's ~ SIDR001~

library(dplyr)
library(plyr)
library(reshape2)
library(tidyr)
library(stringr)

Once <- read.table("data/Data.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
OnceAgain<- read.table("data/DataToAdd.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(Once)<- c("DNAId")

Getit <- Once %>%
  mutate(DNAId = str_replace_all(DNAId, "SI_12_", ""))
  
Getit2<- join(Getit, OnceAgain, by = "DNAId")

TestAgain <- cbind(Getit2, Once)

## 1 ##add data to vectors - is this termonology correct?

    #data I want to add latlong to 
booger <- read.table("FILE.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

    #file with location and Original ID (SI_11_3000) with latlong
booger2 <- read.table("data/reach_New.ID.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

      #file with sampleID and newID only; OR ; original ID SI_11_3000 to new ID SIDRA001
booger3 <- read.table("data/New.ID_pooledID.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

      #mash up the two files so that the latlongs are associated with the NEWID 
Snot3 <- merge(booger, Snot2, by = "ReachID")
Snot4<-join(Snot3, booger, left)
 names(snot)<- c("OldID", "Lat", "Long", "Sample.ID") #change the names of the columns so the Sample.ID is the new ID and will match the column in the data file(booger)


     #now mash up to bring the latlongs into the datased matched on the new sample id's SIDR001
supersnot<- as.data.frame(join(booger, Snot2, type = "left"))
 
        #write supersnot to file      
write.table(Snot3, file = "neuG1_latlong.txt", sep = "\t")

    # file with Lat and Long from GIS associated with Reach ID 
Booger4 <- read.table("File.txt", numerals = "no.loss", header = TRUE, sep ="\t", stringsAsFactors = FALSE)
Booger5<- read.table("File.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
Test1<- merge(Booger5, Booger4, by = "ReachID", all = TRUE, sort=FALSE)
write.table(Test1, file = "File.txt", sep = "\t")

## 2 ### REACH ID's all modifications similar to those above codes ########
  ### There are NA's that are associated with specific samples that were added during the "reconsrudtion" 
  ### So I need to go back to the reach id's from Jitesh 
  ### 1) I mash up the missing reach id/DNAID to Old sample ID 
  ### 2) then mash up to new sample ID 
  ### 3) then mash up to the datafile

    ## File with the Readh ID's, subset so only DNA ID and Reach are listed
booger6 <- read.table("FILE.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
sub <- subset(booger2, select = c("Sample.ID"))
sub$RiverYear <- c("SI_11_") # a specific year
sub$Sample.ID<- paste(sub$RiverYear,sub$DNAId) ## also create Old sample id using the DNAID


sub2 <- sub %>%
  subset(select= -c(DNAId,RiverYear)) %>%
  mutate(Sample.ID = str_replace_all(Sample.ID, " ", ""), 
  as.data.frame(Phlemsub))

   ## File with reachID and DNAId and pair with lat/long from Jitesh file
Gag <- merge(sub2, supersnot, by = "Sample.ID")
names(Gag)<- c("Old.name", "Lat", "Long", "Sample.ID")

  ### mash up lat long with Data file 
  ## note when a new reachID_latlong file is added there are double location points that need to be removed. This is done in ArcGis, usually the points farthest downstream but chekc CDDv3:53##
ahem <- read.table("File.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
latlong<- read.table("File.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
ReachSamp<- read.table("File.txt", header = TRUE, sep = ",", stringsAsFactors = FALSE)

colnames(latlong)<- c("New.ID", "Sample.ID")

Temp <-  left_join(ahem, latlong, by = "New.ID")
Temp2<- left_join(Temp, latlong, by = "ReachID")
write.table(Temp2, "data/neu_lat_long_G2.txt", sep= "\t")

    ###  mash up lat long with Data file - do this only once and each iteration of the Reach Id's will add on below
ahem <- read.table("File.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
ahem2 <- join(ahem, Gag, by = "Sample.ID")
ahem2<- ahem2 %>%
  subset(select = -c(Old.name))

write.table(ahem2, file = "threedigit_neu_locale.txt", sep = "\t")

    ### spring 2013 - the 9000's
ahem12sp<- join(ahem2, Gag, by = "Sample.ID")
ahem12sp<- ahem12sp %>%
  subset(select = -c(Old.name))

write.table(ahem12sp, file = "threedigit_neu_locale.txt", sep = "\t")

    ### Fall 2012 the 3000's
ahem12fa<- join(ahem, Gag, by = "Sample.ID")
ahem12fa<- ahem12fa %>%
  subset(select = -c(Old.name))

write.table(ahem12fa, file = "threedigit_neu_locale.txt", sep = "\t")

 

## 3 ############## Removing individulas from functional list based on neutral list ######

    # file with sample names that are to be removed 
Snot <- read.table("data/Deleted_genotpyes_by_file.txt", header= TRUE, stringsAsFactors = FALSE, sep = "\t")

    # file of genotypes for functional genes
Snot2 <- read.table("data/threedigit_neu2_localeAll.txt", header = TRUE, stringsAsFactors = FALSE, sep = "\t")

    # extract just sample names from deleted genotypes
Samples<- Snot$Sample.ID

    # delete rows from Snot2 based on Samples
Test2<-subset(Snot3, !Snot3$Old.ID %in% Samples)
write.table(Test, "threedigits_funct_lessneu.txt", sep = "\t")

    # Lump Fall, Spring, LRE by year
Booger7 <- read.table("FILE.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
Booger8 <- read.table("FILE.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
#names(Booger8$Sample.ID)<- c("New.ID", "Sample.ID")
colnames(Booger9$Sample.ID)<- c("New.ID")
Booger9 <- join(Booger8, Booger7, type = "right")
Booger10 <- subset(Booger9, select = -c(Sample.ID))
colnames(Booger10)[1] <- c("Sample.ID")

write.table(Booger10, "data/threedigits_functG2.txt", sep = "\t")

## 4 ######  ERIC THINGS, practice code n such for making a square matrix from waterway distance between points that I got from Arc GIS ####################################
# reshaping data example:
# make some data to reshape:
# 2 cols (first is like "a b", second is like 65.3 )
#x <- t(combn(letters[1:5], 2))
x <- expand.grid(letters[1:5], letters[1:5])
DF <- data.frame(
  Pairs = paste(x[,1], x[,2]),
  Values = rnorm(nrow(x)),
  stringsAsFactors = FALSE
)

  # first break the first column up
DF %>% 
  separate(Pairs, sep = " ", into = c("Place1", "Place2")) %>%
  spread(Place2, Values)
  ## the above code but for the network data exported from ArcMap###
Loogie <- read.table("./data/Network_distances_101015.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

tmp<- 
  Loogie %>% 
  separate(Name, sep = "_", into = c("Population_a", "Population_b")) %>%
  #write.table(Loogie, "/data/seperated_network.txt", sep = "\t")
  spread(Population_a, Total.Length)

write.table(tmp, "ND_matrix_square2.txt", sep = "\t")


## 5 ## convert popgen to arlequin ####
library(PopGenKit)
gentoarq<-read.table("data/genos_genepop_SiletzneuG2.gen", sep = "\t", header = TRUE, stringsAsFactors = FALSE)
convert(gentoarq, ndigit = 3)


  ##### pull out sib famlies from the Colony run #######
sibshipfam<- read.table("FILE.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
G2 <- read.table("FILE.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE) 

temp <- sibshipfam %>%
  subset(select = c("member4", "Member2", "Member3"))
  
Test <- subset(ahem, !(ahem$New.ID %in% temp$member4))
Test2 <- subset(Test, !(Test$New.ID %in% temp$Member2))
Test3 <- subset(Test2, !(Test2$New.ID %in% temp$Member3))

write.csv(Test3,"Siletz_neuG2_lesssibship.txt")


## 6 ### adding various samples.ID's to the latlong_G2 file ####

latlong<- read.table("data/G1_nosibship_no.70_110415_pop.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
transformed<- read.table("data/Latlong_SampID_reach_order.txt",header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(transformed) <- c("Mid.ID", "Sample.ID")
temp <- merge(latlong, transformed, by = "Mid.ID")
colnames(transformed)[1]<- c("Mid.ID")
temp2<- merge(temp, transformed, by = "Mid.ID")

write.table(temp2, "G1_nosibship_no70_110415_latlong.txt", sep = "\t")
## 7  Cddv3:68 #### G1 latlong BasinReach Structure assignment modification ####
# GOAL: pull the spring fish that were assigned to Fall > .70 and Same for Fall assigned to spring

Booger11 <- read.table("data/Structure_assignment_G1_latlong_BasinReach.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
Snot <- Booger11 %>%
  subset(str_detect(New.ID, "SISP"))%>%
  #subset(str_detect(New.ID, "SIFA"))%>%
  #subset(Infer > .70) 
  subset(red.clusters <.70)
Temp <- paste(Snot$New.ID)
 
  #use Temp file to pull samples from the dataset
#Booger12 <- read.table("G1_latlong_BasinReach.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
Booger12<- read.table("data/G1_LL_Reach_noSFall_Nosibship_110315_INFILE.txt")
Temp2 <- Booger12 %>%
  subset(!Booger12$V1 %in% Temp)

#### here is how I truncated the functional file ##
# first import the G2 functional file (#1 see ahem and latlong)
# then subset with the sibship file used to subset the neutral marker file (#6)
# then use the Structure file to subset for both "falls" and "Springs" (#7)
# and I removed DR with the [-c(),] thing below

Temp6 <- Temp5 %>%
  subset(!Temp5$New.ID %in% Temp)
write.table(Temp6, "G2_funct_no.70_nosibships.txt", sep="\t")  
Temp4[-c(1:24),]
 
Booger13 <- read.table("data/LatLong_SampID.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
Booger14<- Booger13 %>%
  subset(select=c("Sample.ID", "ReachID", "Latitude", "Longitude"))%>%
  join(Booger12, type = "left", match = "all")%>%
  subset(!Booger14$New.ID %in% Temp)
write.table(Booger14, "G1_latlong_Reach_110215.txt",sep = "\t")
write.table(Temp2, "G1_nosibship_no.70_110415.txt", sep = "\t")

### 8 code to reduce dataset by those individuals ID'd by Colony as related ### 
Booger15<- read.table("data/G1_latlong_Reach_noSFall_110215.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
Booger16 <- read.table("data/Sibling_famlies_G2test1.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
TheSamples<- c(Booger16$Member2, Booger16$Member3, Booger16$member4)
Phlem<- subset(Booger15, !New.ID %in% TheSamples)
write.table(Phlem, "G1_LL_Reach_noSFall,Nosibship_110315.txt", sep = "\t")


##### 9 Work to reduce microsats buy polymorphism, is LD resuced by limiting the # of polymorphic loci### 
Booger17 <- read.table("data/G1_nosibship_no.70_110415.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
Marker_50 <- c("Ots209",  "Ots209.1", "OtsG409.1","OtsG409","Ots253.1", "Ots253")
Marker_40 <- c("Ots107", "Ots107.1", "Ots209", "Ots209.1", "OtsG409.1","OtsG409", "DWROts215.1", "DWROts215","OtsG83", "OtsG83.1","Ots253", "Ots253.1")
Marker_30 <-c("Ots107", "Ots107.1", "Ots209", "Ots209.1", "OtsG409.1","OtsG409", "DWROts215.1","DWROts215", "OtsG83", "OtsG83.1","Ots253", "Ots253.1", "Oki100", "Oki100.1", "Ots208", "Ots208.1", "Ots249", "Ots249.1")

Booger17_50<- Booger17[,-which(names(Booger17) %in% Marker_50)]
Booger17_40<-Booger17[,-which(names(Booger17) %in% Marker_40)]
Booger17_30<-Booger17[,-which(names(Booger17) %in% Marker_30)]


##file manipulations - Genepop needs to have the file manipulated so that after every individual there is a break and "pop"#####
Booger18<- read.table("data/G1_nosibship_no70_latlong_Genepop.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
Testit <- new %>%
  adply(new,1,function(x)
    
    paste(x[seq(2,)])
        apply(df,1,function(x) sum(x[seq(3,length(x),2)]))
new <- Booger18[rep(1:nrow(Booger18),1,each=2),] #repeats the line I want blank or with my work
new[c(seq(2, dim(new)[1], by=2)), ] <- ""
new[c(seq(2, dim(new)[1], by=2)), 1] <- "Pop"

write.table(new,"G1_neu_no70_nosib_individualpop.txt", sep = "\t")

### example short stream with nodes ###
# This should be the matrix manipulations you need!


##### fix my SNP file to go into analysis #####
# 1 = major allele homozygote
# 0 = heterozygote
# 2 = minor allele homozygote

## data output from NMFS SWFSC lab SNP calls####
rawDATA<- read.table("FILE.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
binarySNPdata <- rawDATA %>%
  replace(rawDATA == "XX", 1)%>%
  replace(rawDATA == "XY", 0)%>%
  replace(rawDATA == "YY", 2)%>%
  replace(rawDATA == "No Call", 99)

### Now I have a table that has SNP calls translated into binary codes ###

## this is the data file that tracks new plate ID and sample ID.  However the NMFS plate ID is in three columns make it one
NMFSdata<- read.table("FILE.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
##### the binary file has a long ID, the other file does not so bind the pieces together 
NMFS_ID<- paste(NMFSdata$NMFS_DNA_ID, "_", NMFSdata$BOX_ID, "_", NMFSdata$BOX_POSITION, sep = "")
head(NMFS_ID)
##### bind the two files together so that there is a column in the datafile that has each part seperate
Temp <- cbind(NMFS_ID, NMFSdata)
##Replace the column to match with the same heading in both files
colnames(binarySNPdata)[1]<- c("NMFS_ID")
##Pull my sample ID's and the elongated NMFS_ID
Temp2 <- Temp %>%
  subset(select = c(NMFS_ID, SAMPLE_ID))
###join the files together by the matching column
Final <- join(binarySNPdata, Temp2, by = "NMFS_ID")
## write the final file to output folder
write.table(Final, "FILE.txt", sep = "\t")


###### add sample ID"s for pipeline code, add reach ID's, lat long, ####
Test1<- join(Final, booger2, by="New.ID") # booger 2 file is sampleID transformed 1303
colnames(Test1)[98]<- c("OriginalsID") #change column names as I build file to maker sure joins work correctly
Test2 <- join(Test1, booger3, by = "New.ID") #booger3 file is New.ID_pooledId
#Test3<- join(Test2, booger2, by = "New.ID") # booger 2 file is reach_NewID
#Test3 <- join(Test2, booger2, by = "New.ID", type = "left")

# r <- solve(t(X) %*% X) %*% t(X) %*% D