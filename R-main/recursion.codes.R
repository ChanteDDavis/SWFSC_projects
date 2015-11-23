### example short stream with nodes ###
streamorder <- data.frame(matrix(nrow=27, ncol = 3) )  # empty matrix
streamorder[1,]<- c(1, NA, 2)
streamorder[2,]<- c(2, 1, 3)
streamorder[3,]<- c(3, 2, 4)
streamorder[4,]<- c(4, 3, 5)
streamorder[5,]<- c(5, 4, 6)
streamorder[6,]<- c(6, 3, 7)
streamorder[7,]<- c(7, 6, 8)
streamorder[8,]<- c(8, 7, NA)
streamorder[9,]<- c(9, 8, 2)
streamorder[10,]<- c(10, 9, 11)
streamorder[11,]<- c(11, 10, 12)
streamorder[12,]<- c(12, 11, NA)
colnames(streamorder) <- c("Stream.order", "Upstream", "dwnStream")
#### end file example stream ###

### This one works using igraph.  I input the above information with one noticable change.  
#Only the two points that represent an edge are in columns.  
#Relatively easy for a small system
streamorder <- data.frame(nrow=11, ncol = 2)  # empty matrix
streamorder[1,]<- c(1, 2)
streamorder[2,]<- c(2, 3)
streamorder[3,]<- c(3,4)
streamorder[4,]<- c(4,5)
streamorder[5,]<- c(5, 6)
streamorder[6,]<- c(6, 7)
streamorder[7,]<- c(7,8)
streamorder[8,]<- c(3, 9)
streamorder[9,]<- c(9, 10)
streamorder[10,]<- c(10, 11)
streamorder[11,]<- c(9, 12)
colnames(streamorder) <- c("Stream.order", "neighbor")  

g<-graph_from_data_frame(streamorder, directed = FALSE)
plot.igraph(g, axes = FALSE)
graph_attr_names(g)


ecount(g)
get.edge.ids
setNames
con_edge_list
#demo(package = "igraph")

### stuff that may not work ###
Booger <- streamorder
x = i
j = x+1

samples <- c(Booger$Stream.order)
for (i in 1:length(samples)) { #12
  lapply(Booger, function (x){
    a <- Booger$Stream.order[x]
    for (j in 1:length(Booger)){
      j <- x+1
      b <- Booger$Stream.order[j]
      # for (i == x + 1) (this one repeates)    
      
      #Recursion begins here and a and b are passes into this function
      Stream.segment(a,b, route)
    }})}

g <- make_ring(10)
all_simple_paths(g, 1, 5)
all_simple_paths(g, 1, c(3,5))

l <- make_ring(5)
ends(l, E(l))

l <- make_ring(10) %>%
  set_edge_attr("weight", value = 1:10) %>%
  set_edge_attr("color", value = "red")
l
plot(l, edge.width = E(l)$weight)

l <- make_ring(10)
graph_attr_names(g)

#My idea is 
# read in file
# read in first line and this is stream order a
# the second line is stream order b (creates the pair to be samples)
# recursion to find the reaches that are shared between the two points
# the whole thing repeats as the first three lines cycle through all pairs of individuals, which are fed into the recursion code


######