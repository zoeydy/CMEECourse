#!/usr/bin/env Rscript

# A script that illustrates how vectorization apart from computational efficiency, 
# makes writing code more concise, easy to read, and less error prone

# CLean your environment
rm(list = ls())
graphics.off()

M <- matrix(runif(1000000), 1000, 1000)

SumAllElements <- function(M) {
    Dimensions <- dim(M)
    Tot <- 0
    for (i in 1:Dimensions[1]) {
        for (j in 1:Dimensions[2]) {
            Tot <- Tot + M[i,j]
        }
    }
    return (Tot)
}

print("Using loops in R, the time taken is:")
print(system.time(SumAllElements(M)))

print("Using the in-built vectorized function in R, the time taken is:")
print(system.time(sum(M)))
