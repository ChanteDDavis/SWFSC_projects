library(dplyr)
library(reshape2)
library(igraph)
library(plyr)

# first, read the data as an edgelist data frame.
# the edgelist data frame is a list of all the verticies that make 
# up the endpoints for each edge.  
# To advance this step we need a program that will transfer nodes into edge pairs.
G <- read.table("data/example-network-edges.txt", 
                stringsAsFactors = FALSE, 
                colClasses = "character", 
                header = T)


# make a graph of it
# in igraph look at the various options
g <- graph.data.frame(G, directed = FALSE)

plot(g)

# here is a function that returns the vertex Names on the path between two vertices
# and doubles them up as would be appropriate for extracting edge IDs.  This only works
# for trees
vertex_path <- function(g, from, to) {
  # get the vertex names
  x <- names(unclass(all_simple_paths(g, from = from, to = to)[[1]])) # report the path from node a to node b
  y <- rep(x, each = 2) # because of how all-simple-paths returns the lists it doesnt report verticies twice so 2, 3, 4 shoud be 2-3, 3-4 (the three repeats twice).  This line fixes that
  z <- y[-c(1, length(y))] 
  z
}


# Here are all the pairwise comparisons (which will form the rows of our matrix...)
Pairs <- combn(names(V(g)), 2) %>%   #V is a function so is names.  names calls the name of the edge (not the verticy) which the program will name for you.
  t

# make a named list of those:
PairsList <- lapply(1:nrow(Pairs), function(x) Pairs[x, ]) %>%
  setNames(paste(Pairs[,1], Pairs[,2], sep = "-"))  # Since this is a list we're changing the name of the item to the name of the list in it's line.

# now lapply over that list and get the IDs of the edges that are between the
# corresponding pairs of vertices.
con_edge_List <- lapply(PairsList, function(x) {
  get.edge.ids(g, vertex_path(g, x[1], x[2]))
})


# now make a matrix with every row a pair, and every column an edge
# and start with all 0's and then add 1's where needed
Matrix <- matrix(0, nrow = length(con_edge_List), ncol = ecount(g))
rownames(Matrix) <- names(PairsList)

# make a matrix of indices for putting 1's into Matrix
idx <- lapply(1:length(con_edge_List), function(x) {cbind(x, con_edge_List[[x]])}) %>%
  do.call(rbind, .)


Matrix[idx] <- 1

# Voila!  That is your matrix X for the "StreamTrees" analysis


### make a D matrix of fixation intrest of choice but in the correct format ###
  
D.matrix<- read.table("FIle.text", header = TRUE, sep = "\t", stringsAsFactors = FALSE)


## Formula time ###
# This should be the matrix manipulations you need!
# r <- solve(t(X) %*% X) %*% t(X) %*% D




