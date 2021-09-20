# !/bin/bash
#PBS -lwalltime=12:00:00
#PBS -lselect=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/Q18_20/zongyihu_HPC_2020_cluster.R
mv *_iter_test_file.rda $HOME/Q18_20
echo "R has finished running"
# this is a comment at teh end of the file
