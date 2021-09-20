# CMEE 2020 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice in this instance
source("zongyihu_HPC_2020_main.R")

#1
species_richness(c(1,4,4,5,1,6,1))
#2
init_community_max(7)
#3
init_community_min(4)
#4
choose_two(4)
#5
neutral_step(c(10, 5, 13))
#6
neutral_generation(c(4,5,1,6))
#7
neutral_time_series(community = init_community_max(7), duration = 20)
#length(neutral_time_series(community = init_community_max(7), duration = 20))
#8
question_8()
#9
neutral_step_speciation(community = init_community_max(7), 0.7)
#10
neutral_generation_speciation(community = init_community_max(7), 0.7)
#11
neutral_time_series_speciation(community = init_community_max(7), 0.7, 10)
#12
question_12()
#13
species_abundance(c(1,5,3,6,5,6,1,1))
#14
octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))
#15
sum_vect(c(1,3),c(1,0,5,2))
#16
question_16()
#17
cluster_run(speciation_rate = 0.1, size=100, wall_time=10,
            interval_rich=1, interval_oct=10,
            burn_in_generations=200, output_file_name="my_test_file_1.rda")
#20
process_cluster_results()
plot_cluster_results()
#21
question_21()
#22
question_22()
#23
chaos_game()
#24
graphics.off()
plot(1, type = "n", main = "turtle",
     xlim = c(-1,6), ylim = c(-1,6))
turtle(start_position = c(1,1), direction = pi/6, length = 2)
#25
graphics.off()
plot(1, type = "n", main = "elbow",
     xlim = c(-1,6), ylim = c(-1,6))
elbow(start_position = c(1,1), direction = pi/6, length = 2)
#26
graphics.off()
plot(1, type = "n", main = "spiral",
     xlim = c(0,6), ylim = c(-3,3))
spiral(start_position = c(1,1), direction = pi/6, length = 2)
#27
graphics.off()
plot(1, type = "n", main = "spiral",
     xlim = c(-3,6), ylim = c(-3,6))
draw_spiral()
#28
draw_tree()
#29
draw_fern()
#30
draw_fern2()


# it should take a faction of a second to source your file
# if it takes longer you're using the main file to do actual simulations
# it should be used only for defining functions that will be useful for your cluster run and which will be marked automatically

# do what you like here to test your functions (this won't be marked)
# for example
# 1
species_richness(c(1,4,4,5,1,6,1))
species_richness(init_community_max(66))
# should return 4 when you've written the function correctly for question 1

# you may also like to use this file for playing around and debugging
# but please make sure it's all tidied up by the time it's made its way into the main.R file or other files.
