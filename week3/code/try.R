doit <- function(x){
  temp_x <- sample(x, replace = TRUE)
  if(length(unique(temp_x)) > 30) {#only take mean if sample was sufficient
    print(paste("Mean of this sample was:", as.character(mean(temp_x))))
  } 
  else {
    stop("Couldn't calculate mean: too few unique values!")
  }
}

# Now generate your population
popn <- rnorm(50)
hist(popn)

# use lapply like you did before
lapply(1:15, function(i) doit(popn))
# use try
result <- lapply(1:15, function(i) try(doit(popn), FALSE))
class(result)
result
result <- vector("list", 15) #Preallocate/Initialize
for(i in 1:15) {
  result[[i]] <- try(doit(popn), FALSE)
}