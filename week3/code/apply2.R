rm(list = ls())

SomeOperation <- function(v){ # The function SomeOperation takes as input v which is the colomn of the later input matrix. Then if the sum of the numbers in each column are greater than zero, it multiplies that value by 100. So if v has positive and negative numbers, and the sum comes out to be positive, only then does it multiply all the values in v by 100 and return them.
    if(sum(v) > 0){ #note that sum(v) is a single (scalar) value
        return(v * 100)
    }
    return(v)
}

M <- matrix(rnorm(100), 10, 10)
print(apply(M, 1, SomeOperation))