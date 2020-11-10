rm(list = ls())
graphics.off()

data <- read.csv("../data/bears.csv", stringsAsFactors = FALSE, header = FALSE, colClasses =  rep("character",10000))




# 1. Identify the position ot alleles
snps <- c()
for (i in 1:ncol(data)) {
  if (length(unique(data[,i])) > 1) {
    snps <- c(snps, i)
  } 
}

SNP <- subset(data[,snps])




# 2. calculate, print and visualize allele frequencies for each SNP
frequencies <- c()
for (i in 1:ncol(SNP)) {
  alleles <- sort(unique(SNP[,i]))
  cat("\nSNP", i, "with alleles", alleles)
  freq <- length(which(SNP[,i] == alleles[2])) / nrow(SNP)
  cat(" and allel frequency of the second allele is", freq)
  frequencies <- c(frequencies, freq)
}

plot(frequencies, type = "hist")




# 3. Calculate and print genotype frequencies for each SNP

SampleSize <- 20
for (i in 1:ncol(SNP)) {
 
  alleles <- sort(unique(SNP[,i]))
  cat("\nSNP", i, "with alleles", alleles)
  GenotypeCount <- c(0,0,0)
  
  for (j in 1:SampleSize) {
    
    index <- c(j*2-1, j*2)
    Genotype <- length(which(SNP[index,i] == alleles[2])) + 1
    GenotypeCount[Genotype] <- GenotypeCount[Genotype] + 1
    
  }
  
  cat(" and genotype frequencies", GenotypeCount)
  
}



# 4. Calculate (observed) homozygosity and heterozygosity for each SNP

SampleSize <- 20
for (i in 1:ncol(SNP)) {
  
  alleles <- sort(unique(SNP[,i]))
  cat("\nSNP", i)
  GenotypeCount <- c(0,0,0)
  
  for (j in 1:SampleSize) {
    
    index <- c(j*2-1, j*2)
    Genotype <- length(which(SNP[index,i] == alleles[2])) + 1
    GenotypeCount[Genotype] <- GenotypeCount[Genotype] + 1
    Hetero <- as.integer(GenotypeCount[2]) / SampleSize
    Homo <- 1 - Hetero
    
  }
  
  cat(" has", Hetero, "Heterozygosity, and has ", Homo, "Homozygosity.")
  
}




# 5. Calculate expected genotype counts for each SNP and test for HWE

nonHWE <- c()
SampleSize <- 20

for (i in 1:ncol(SNP)) {
  
  alleles <- sort(unique(SNP[,i]))
  cat("\nSNP", i)
  freq <- length(which(SNP[,i] == alleles[2])) / nrow(SNP)
  GenotypeCountExpect <- c((1-freq)^2, 2*freq*(1-freq), freq^2) * SampleSize
  GenotypeCount <- c(0,0,0)
  
  for (j in 1:SampleSize) {
    
    index <- c(j*2-1, j*2)
    Genotype <- length(which(SNP[index,i] == alleles[2])) + 1
    GenotypeCount[Genotype] <- GenotypeCount[Genotype] + 1
    
    
  }
  
  # Test for HWE
  chi <- sum((GenotypeCountExpect - GenotypeCount)^2 / GenotypeCountExpect)
  # p-value
  pv <- 1 - pchisq(chi, df = 1)
  cat(" with p-value for test against HWE", pv)
  # retain SNPs with p-value < 0.05
  if (pv < 0.05) {
    nonHWE <- c(nonHWE, i)
  } 
}



# 6. calculate print and visualize inbreeding coefficient for each SNP deviating from HWE

F <- c()
SampleSize <- 20

for (i in nonHWE) {
  
  #browser()
  alleles <- sort(unique(SNP[,i]))
  cat("\nSNP", i)
  freq <- length(which(SNP[,i] == alleles[2])) / nrow(SNP)
  GenotypeCountExpect <- c( (1-freq)^2, 2*freq*(1-freq), freq^2) * SampleSize
  GenotypeCount <- c(0,0,0)
  
  for (j in 1:SampleSize) {
    
    index <- c( (j*2)-1, j*2 )
    Genotype <- length(which(SNP[index,i] == alleles[2])) + 1
    GenotypeCount[Genotype] <- GenotypeCount[Genotype] + 1
    
  }
  
  inbreeding <- ( 2*freq*(1-freq) - (GenotypeCount[2]/SampleSize)) / (2*freq*(1-freq))
  F <- c(F, inbreeding)
  cat(" with inbreeding coefficient", inbreeding)
  
}

plot(F, type = "hist")


