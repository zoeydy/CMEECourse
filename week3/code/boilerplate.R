rm(list = ls())

# A boilerplate R script

MyFunction <- function(Arg1,Arg2){
    print(paste('Argument', as.character(Arg1), 'is', class(Arg1)))
    print(paste('Argument', as.character(Arg2), 'is', class(Arg2)))

    return(c(Arg1,Arg2)) # this is optional, but very useful
}

MyFunction(1,2)
MyFunction('hello', 'world')