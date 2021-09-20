# CMEE 2020 HPC excercises R code HPC run code proforma
rm(list=ls()) # good practice 

############ RUN ON CLUSTER ############
# source("/rds/general/user/zh2720/home/Q18_20/zongyihu_HPC_2020_main.R")
# iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

############ RUN LOCALLY ############
source("zongyihu_HPC_2020_main.R")
iter <- 31

set.seed(iter)

if(iter%%4 == 0){
  size = 500
}
if(iter%%4 == 1){
  size = 1000
}
if(iter%%4 == 2){
  size = 2500
}
if(iter%%4 == 3){
  size = 5000
}
speciation_rate <- 0.0033442
cluster_run(speciation_rate, size, wall_time=(11.5*60*60),
            interval_rich=1, interval_oct= size/10,
            burn_in_generations=8*size, output_file_name=paste0(iter, "_iter_test_file.rda"))
