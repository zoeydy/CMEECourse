rm(list = ls())
graphics.off()




# geckos

len <- 20000

data_w <- read.csv("../data/western_banded_gecko.csv", stringsAsFactors = FALSE, header = FALSE, colClasses = rep("character", len))
dim(data_w)

data_b <- read.csv("../data/bent-toed_gecko.csv", stringsAsFactors = FALSE, header = FALSE, colClasses = rep("character", len))
dim(data_b)

data_l <- read.csv("../data/leopard_gecko.csv", stringsAsFactors = FALSE, header = FALSE, colClasses = rep("character", len))
dim(data_l)


# calculate the divergence between sequences of B and L

sites_total <- 0
sites_divergent <- 0

for (i in 1:ncol(data_b)) {
  
  if (length(unique(data_b[,i])) == 1 & length(unique(data_l[,i])) == 1){
    
    sites_total <- sites_total + 1
    
    if (data_b[1,i] != data_l[1,i]) 
      sites_divergent <- sites_divergent + 1
  }
}

## divergence rate
div_rate_BL <- sites_divergent / sites_total



# calculate divergence between sequences of W and L 

sites_total <- 0
sites_divergent <- 0

for (i in 1:ncol(data_w)) {
  
  if (length(unique(data_w[,i])) == 1 & length(unique(data_l[,i])) == 1){
    
    sites_total <- sites_total + 1
    
    if (data_w[1,i] != data_l[1,i]) 
      sites_divergent <- sites_divergent + 1
  }
}

## divergence rate
div_rate_WL <- sites_divergent / sites_total




# calculate divergence between sequences of W and B 

sites_total <- 0
sites_divergent <- 0

for (i in 1:ncol(data_w)) {
  
  if (length(unique(data_w[,i])) == 1 & length(unique(data_b[,i])) == 1){
    
    sites_total <- sites_total + 1
    
    if (data_w[1,i] != data_b[1,i]) 
      sites_divergent <- sites_divergent + 1
  }
}

## divergence rate
div_rate_WB <- sites_divergent / sites_total


# From the divergence rate we can infer that W and B are close species while L si the outgroup






# Estimate mutation rate per site per year
mut_rate <- div_rate_BL / (2 * 3e7)

# Estimate the divergence time
div_time <- div_rate_WB / (2 * mut_rate)

cat("\nThe two species have a divergence time of", div_time, "years.")
cat("\nThe most likely species tree is L:(W:B).")