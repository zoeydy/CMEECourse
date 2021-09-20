# CMEE 2020 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "zongyihu"
preferred_name <- "zongyihu"
email <- "zongyi.hu20@imperial.ac.uk"
username <- "zongyihu"


require(ggplot2)


# please remember *not* to clear the workspace here, or anywhere in this file. If you do, it'll wipe out your username information that you entered just above, and when you use this file as a 'toolbox' as intended it'll also wipe away everything you're doing outside of the toolbox.  For example, it would wipe away any automarking code that may be running and that would be annoying!

# Question 1
species_richness <- function(community){
  length(unique(community))
}

# Question 2
init_community_max <- function(size){
  seq(size)
}

# Question 3
init_community_min <- function(size){
  rep(1, size)
}

# Question 4
choose_two <- function(max_value){
  two_value <- sample(seq(max_value), size = 2,replace = FALSE)
  return(two_value)
}

# Question 5
neutral_step <- function(community){
  new_commu <- replace(community, community==sample(community, 1), sample(community,1))
  return(new_commu)
}

# Question 6
neutral_generation <- function(community){
  i <- 0
  gen <- length(community)/2
  while(i < gen){
    new_commu <- neutral_step(community)
    i <- i+1
  }
  return(new_commu)
}

# Question 7
neutral_time_series <- function(community,duration) {
  i <- 0
  SpeRich <- c()
  while (i <= duration) {
    SpeRich <- append(SpeRich, species_richness(community))
    community <- neutral_generation(community)
    i <- i+1
  }
  return(SpeRich)
}

# Question 8
question_8 <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(seq(0:200), neutral_time_series(init_community_max(100), 200),
       main = "neutral model simulation \n initial condition of maximal diversity in a system size of 100 individuals", cex.main = .7,
       xlab = "Generation",
       ylab = "Community Richness",
       pch = 20, cex = 0.1)
  
    return("At the first steps of the neutral simulation, the probability of each species' chance of replacing the individual dies is similar. As time goes by, there will be more individuals of this species, so the probability of this species replacing species is going higher. This positive feedback makes it the predominant species and gets more chance to take over other species. So, after a long enough time, there will only leave one species.")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate){
  rate <- runif(1,0,1)
  choose <- choose_two(length(community))
  if (rate < speciation_rate){
    new_commu <- replace(community, choose[1], max(community)+1)
  }else{
    new_commu <- replace(community, choose[1], community[choose[2]])
  }
  return(new_commu)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  i <- 0
  gen <- length(community)/2
  new_commu <- community
  while(i < gen){
    new_commu <- neutral_step_speciation(new_commu,speciation_rate)
    i <- i+1
  }
  return(new_commu)
}

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  i <- 0
  SpeRich <- c()
  while (i <= duration) {
    SpeRich <- append(SpeRich, species_richness(community))
    community <- neutral_generation_speciation(community, speciation_rate)
    i <- i+1
  }
  return(SpeRich)
}

# Question 12
question_12 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  #den <- data.frame()
  
  max_commu <- init_community_max(100)
  min_commu <- init_community_min(100)
  max_commu_ric <- neutral_time_series_speciation(max_commu,0.1,200)
  min_commu_ric <- neutral_time_series_speciation(min_commu,0.1,200)
  
  df1 <- data.frame(t = seq(0:200), richness = max_commu_ric, init_condition = 'maximum richness')
  df2 <- data.frame(t = seq(0:200), richness = min_commu_ric, init_condition = 'minimum richness')
  df <- rbind(df1,df2)
  
  #plot(df$t, df$richness, col = ifelse(df$init_condition == 'max', 'red', 'blue'))
  p_12 <- ggplot(df, aes(x=t, y = richness, color = init_condition)) +
    geom_line() +
    theme_bw() +
    labs(color = "community initial condition", x = "Time", y="community richness", 
         title = "Neutral theory simulation with speciation",
         subtitle = "max/min community's species richness against time",
         caption = "initial communit size=100, generation=200, speciation rate=0.1")
    
  print(p_12)
  
  return("In a long enough generation, the initial condition of community richness doesn't matter. As explained in question 8, the community's richness will come to 1, after a long enough time, as we have speciation here, there are always new species coming up so the richness of the community can reach an equilibrium at the end. If the speciation rate is higher, the community richness is higher at the end.")
}



# Question 13
species_abundance <- function(community){
  spe_abun <- sort(table(rep('species_abundance', length(community)), community),decreasing = TRUE)
  return(spe_abun)
}

# Question 14
octaves <- function(abundance_vector) {
  result <- c()
  for (i in 1:(log2(max(abundance_vector))+1)) {
    sub_vec <- abundance_vector[abundance_vector >= (2^(i-1)) & abundance_vector < 2^i]
    count <- sum(table(rep('octaves',length(sub_vec)), sub_vec))
    result <- append(result,count)
  }
  return(result)
}

# Question 15
sum_vect <- function(x, y) {
  result <- c()
  if(length(x) < length(y)){
    short <- x
    long <- y
  }else{
    short <- y
    long <-x
  }
  length(long)
  for (i in 1:length(long)) {
    #browser()
    short <- append(short, rep(0,length(long)-length(short)))
    index_sum <- sum(short[i],long[i])
    result <- append(result, index_sum)
  }
return(result)
}

# Question 16 
question_16 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  max_commu <- init_community_max(100)
  min_commu <- init_community_min(100)
  max_oct_inter <- vector(mode = "list",length = 100)
  min_oct_inter <- vector(mode = "list",length = 100)
  max_sum <- c()
  min_sum <- c()

  for (i in 1:2200) {
    #browser()
    max_commu <- neutral_generation_speciation(community = max_commu,speciation_rate = 0.1)
    min_commu <- neutral_generation_speciation(community = min_commu,speciation_rate = 0.1)
    max_abun <- species_abundance(max_commu)
    min_abun <- species_abundance(min_commu)
    max_octa <- octaves(max_abun)
    min_octa <- octaves(min_abun)
    
    if (i==200) {
      max_oct_burn_in <- max_octa
      min_oct_burn_in <- min_octa
    }
    if(i>200){
      max_sum <- sum_vect(max_sum,max_octa)
      min_sum <- sum_vect(min_sum,min_octa)
      if (i%%20==0) {
        max_oct_inter[[i]] <- max_octa
        min_oct_inter[[i]] <- min_octa 
      }
    }
  }
  par(mfrow=c(1,2))
  barplot(max_sum/2000, main = "maximum richness community ", cex.main = 0.8,
          ylab = "count", ylim = c(0,11), names.arg = "octaves")
  barplot(min_sum/2000, main = "minimum richness community", cex.main = 0.8,
          ylab = "count", ylim = c(0,11), names.arg = "octaves")
  mtext("different initial richness community's mean octaves after burn-in generation",
        side = 3, line = -1,cex = 1, outer = TRUE)
  mtext("burn-in generation=200, total generation=2200
          the mean of last 2000 generations", side = 1, line = -2, outer = TRUE)
  return("As discussed in question 12, the initial condition of the community doesn't affect the equilibrium condition of the community. And the octaves show the distribution of the community richness, so the maximum and minimum initial community's octaves should be the same after burn-in generation.")
}


# Question 17
cluster_run <- function(speciation_rate, size, wall_time,
                        interval_rich, interval_oct,
                        burn_in_generations, output_file_name){
  community <- init_community_min(size)
  ptm <- proc.time()
  richness_inter <- vector(mode = 'list')
  oct_inter <- vector(mode = 'list')
  i <- 1
  while ((proc.time()-ptm) < wall_time) {
    #browser()
    community <- neutral_generation_speciation(community,speciation_rate)
    richness <- species_richness(community)
    oct <- octaves(species_abundance(community))
    
    if (i%%interval_oct == 0){
      oct_inter[[i]] <- oct
    }
    if (i <= burn_in_generations & i%%interval_rich == 0) {
      richness_inter[[i]] <- richness 
    }
    i <- i+1
  }
  time_consume <- proc.time() - ptm
  result <- list(
    speciation_rate= speciation_rate,
    size=size, 
    wall_time=wall_time,
    interval_rich = interval_rich,
    interval_oct= interval_oct,
    burn_in_generations=burn_in_generations,
    
    time_series = 1:i,
    time_consume = paste(time_consume[1], "s"),
    richness_inter =richness_inter[seq(0,burn_in_generations,interval_rich)],
    oct_inter =oct_inter[seq(0,i,interval_oct)],
    community = community,
    octaves = oct)
  
  save(result, file = output_file_name)
}



# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function(){
  
  # get mean of octaves of each simulation
  # mean_simu_oct <- list()
  mean_simu_oct <- list()
  for (i in 1:100) {
    ##### data 31_iter has some problem, use data 35_iter replacing
    if(i == 31){
      load("35_iter_test_file.rda")
    }else{
      f <- paste0(i,"_iter_test_file.rda")
      load(f)
    }
    
    # mean_simu_oct <- sum octaves after burn-in generation / (end_point - start_point + 1)
    start_point <- (result$burn_in_generations)/(result$interval_oct)
    end_point <- length(result$oct_inter)
    sum_simu_oct <- c()
    
    for (j in start_point:end_point) {
      sum_simu_oct <- sum_vect(sum_simu_oct, result$oct_inter[[j]])
    }
    mean_simu_oct[[i]] <- sum_simu_oct/(end_point - start_point + 1)
    
    }

  # write 4 for loop to distribute different size data set
  sum_500 <- c()
  sum_1000 <- c()
  sum_2500 <- c()
  sum_5000 <- c()
  for (k in seq(4,100,4) ) {
    sum_500 <- sum_vect(sum_500, mean_simu_oct[[k]])
  }
  for (l in seq(1,100,4) ) {
    sum_1000 <- sum_vect(sum_1000, mean_simu_oct[[l]])
  }
  for (m in seq(2,100,4) ) {
    sum_2500 <- sum_vect(sum_2500, mean_simu_oct[[m]])
  }
  for (n in seq(3,100,4) ) {
    sum_5000 <- sum_vect(sum_5000, mean_simu_oct[[n]])
  }
  # mean_size_oct <- add each size's mean_simu_oct / 25
  mean_500_oct <- sum_500/25
  mean_1000_oct <- sum_1000/25
  mean_2500_oct <- sum_2500/25
  mean_5000_oct <- sum_5000/25
  # save the result 
  combined_results <- list(mean_500_oct, mean_1000_oct, mean_2500_oct, mean_5000_oct)
  save(combined_results, file = "summary.rda")
}


plot_cluster_results <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  # load combined_results from your rda file
  load("summary.rda")
  # plot the graphs
  par(mfrow=c(2,2), oma = c(3, 2, 3, 0), # two rows of text at the outer left and bottom margin
      mar = c(2, 2, 1.7, 1.3), # space for one row of text at ticks and to separate plots
      mgp = c(1, 1, 0))
  
  size <- c(500,1000,2500,5000)
  add_axis <- c(0.5,1,2,4)
  for (s in 1:4) {
    #browser()
    barplot(combined_results[[s]], main = paste("Size:", size[s]), cex.main = 0.8,
          names.arg = paste0(c(1,2^seq(length(combined_results[[s]])-1)), "-", c(2^seq(combined_results[[s]]))-1),
          ylim = c(0,max(combined_results[[s]])+add_axis[[s]]))
  }
  mtext("Neutral Model Simulation
        mean species abundance distribution (as octaves)",
        side = 3, line = 0,cex = 1, outer = TRUE)
  mtext("speciation rate = 0.0033442", side = 1, line = 1, outer = TRUE)
  
  return(combined_results)
}

# Question 21
question_21 <- function()  {
  result <- list()
  result[[1]] <- logb(8,3)
  result[[2]] <- paste0("This object has copies of the shape of 8 and a scaling factor of 3, according to, the scaling factor to the dimension power equals the copies of the shape, we get the dimension of this graph is log(8)/log(3) = ", log(8)/log(3))
  return(result)
}

# Question 22
question_22 <- function()  {
  result <- list()
  result[[1]] <- logb(20,3)
  result[[2]] <- paste0("This object has copies of the shape of 20 and a scaling factor of 3, according to, the scaling factor to the dimension power equals the copies of the shape, we get the dimension of this graph is log(20)/log(3) = ", log(20)/log(3))
  return(result)
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  x=y=0
  plot_x <- list(x)
  plot_y <- list(y)
  origin_points <- list(c(0,0),c(3,4),c(4,1))
  
  i<-1
  while (i <= 10000) {
    #browser()
    samp <- sample(1:3,1)
    x <- (origin_points[[samp]][1]+x)/2
    y <- (origin_points[[samp]][2]+y)/2
    plot_x[[i]] <- x
    plot_y[[i]] <- y
    i<- i+1
  }
  plot(1,type = "n",main = "chaos game",xlim = c(-1,5),ylim = c(-1,5),
       axes =  TRUE, xlab = "",ylab = "")
  points(plot_x, plot_y, pch = 20,cex=0.00001, )
  text(-.5,-.5,"A(0,0)")
  text(3,4.5,"B(3,4)")
  text(4.5,1,"C(4,1)")
  return("It's a fractal graph limited to three given points")
}

# Question 24
turtle <- function(start_position, direction, length)  {
  end_point <- c(length*cos(direction)+start_position[1],
                 length*sin(direction)+start_position[2])
  
  lines(c(start_position[1],end_point[1]),
        c(start_position[2],end_point[2]),type = "l")
  
  return(end_point) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  
  turtle(start_position, direction, length)
  turtle(c(length*cos(direction)+start_position[1],
           length*sin(direction)+start_position[2]),
         direction-pi/4, 0.95*length)
  
}


# Question 26
spiral <- function(start_position, direction, length) {
  #browser()
  if (length > 0.01) {
    para1 <- list(start_position, direction, length)
    do.call("turtle",para1)
    para2 <- list(c(length*cos(direction)+start_position[1],
                    length*sin(direction)+start_position[2]),
                  direction-pi/4, 0.95*length)
    do.call("spiral", para2)
  }
  return("This function plot elbow one after another, and used an if statement to confine the endless process by control the length of the line longer than 0.01.")
}

# Question 27
draw_spiral <- function()  {
  graphics.off()
  plot(1, type = "n", main = "spiral", xlim = c(0,6), ylim = c(-3,3))
  spiral(start_position = c(1,1), direction = pi/6, length = 2)
}

# Question 28
tree <- function(start_position, direction, length)  {
  if (length > 0.05) {
    para1 <- list(start_position, direction, length)
    do.call("turtle",para1)
    para2 <- list(c(length*cos(direction)+start_position[1],
                    length*sin(direction)+start_position[2]),
                  direction-pi/4, 0.65*length)
    do.call("tree", para2)
    para3 <- list(c(length*cos(direction)+start_position[1],
                    length*sin(direction)+start_position[2]),
                  direction+pi/4, 0.65*length)
    do.call("tree", para3)
  }
}

draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(1, type = "n", main = "draw_tree", xlim = c(-5,5), ylim = c(-1,9))
  tree(start_position = c(0,0), direction = pi/2, length = 3)
}

# Question 29
fern <- function(start_position, direction, length)  {
  if (length > 0.01) {
    #browser()
    turtle(start_position, direction, length)
    fern(c(length*cos(direction)+start_position[1],
           length*sin(direction)+start_position[2]),
         direction, 0.87*length)
    fern(c(length*cos(direction)+start_position[1],
          length*sin(direction)+start_position[2]),
        direction+pi/4, 0.38*length)
    
  }
}
draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(1, type = "n", main = "Fern", xlim = c(-6,6), ylim = c(-1,25))
  fern(start_position = c(0,0), direction = pi/2, length = 3)
}

# Question 30
fern2 <- function(start_position, direction, length, dir){
  if (length > 0.01) {
    #browser()
    turtle(start_position, direction, length)
    fern2(c(length*cos(direction)+start_position[1],
           length*sin(direction)+start_position[2]),
         direction, 0.87*length,-1*dir)
    fern2(c(length*cos(direction)+start_position[1],
           length*sin(direction)+start_position[2]),
         direction+dir*pi/4, 0.38*length,dir)
  }
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(1, type = "n", main = "Fern2", xlim = c(-7,7), ylim = c(-1,23))
  fern2(start_position = c(0,0), direction = pi/2, length = 3, dir = 1)
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
process_challenge_A_data <- function(){
  # 100 simulation, calculate mean
  sum_max <- c()
  sum_min <- c()
  for (i in 1:100) {
    # initalte the community
    browser()
    commu_max <- init_community_max(100)
    commu_min <- init_community_min(100)
    # each generation: calculate the richness
    rich_max <- neutral_time_series_speciation(commu_max,0.1,2000)
    rich_min <- neutral_time_series_speciation(commu_min,0.1,2000)
    sum_max <- sum_vect(sum_max, rich_max)
    sum_min <- sum_vect(sum_min, rich_min)
  }
  mean_max <- sum_max/100
  mean_min <- sum_min/100
  left_max <- mean_max-qnorm(0.986)*sd(mean_max)/sqrt(100)
  right_max <- mean_max+qnorm(0.986)*sd(mean_max)/sqrt(100)
  left_min <- mean_min-qnorm(0.986)*sd(mean_min)/sqrt(100)
  right_min <- mean_min+qnorm(0.986)*sd(mean_min)/sqrt(100)
  challenge_A_data <- list(mean_max, mean_min, left_max, right_max, left_min, right_min)
  save(challenge_A_data ,file = "challenge_A_result.rda")
}


Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  load(file = "challenge_A_result.rda")
  df <- as.data.frame(challenge_A_data)
  colnames(df) <- c('max_density','min_density','max_left','max_right','min_left','min_right')
  # plot
  p<-ggplot(df, aes(x=1:2001)) + 
    geom_line(aes(y=max_density, colour='darkred')) + 
    geom_line(aes(y=min_density, colour='steelblue')) +
    geom_ribbon(aes(ymin=max_left, ymax=max_right), linetype=2, alpha=0.7) +
    geom_ribbon(aes(ymin=min_left, ymax=min_right), linetype=2, alpha=0.7) +
    labs(x = "Generation", y = 'Density', title = 'mean species richness against time') +
    scale_color_discrete(labels=c("Max initial community","Min initial community"))
    
  p
}
  

# Challenge question B
process_challenge_B_data <- function(){
  
  # generate different initial richness community
  richness <- list()
  richness_vector <- seq(5,100,5)
  for (i in 1:20) {
    init_community <- init_community_max(richness_vector[i])
    community <- rep(init_community, 100/length(init_community))
    richness[[i]] <- neutral_time_series_speciation(community, speciation_rate = 0.1, duration = 100)
  }
  save(richness, file = "challenge_B_data.rda")
}

Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  # load the data
  load("challenge_B_data.rda")
  # richness <- as.data.frame(richness, colnames(richness))
  # colnames(richness) <- richness [1,]
  # plot
  plot(1, type = "n", xlim = c(1,100), ylim = c(0,100), xlab = "Time", ylab = "Richness",
       main = c("Neutral Model Simulation \n community's richness aginst time"), cex.main = 1 )
  colors <- rainbow(20)
  for (i in 1:20) {
    lines(c(1:101), richness[[i]], col= colors[i], lwd=1, )
  }
  legend("topright", legend= seq(5,100,5), col=rainbow(20), lty=1, cex = 0.4)
  
}


# Challenge question C
process_challenge_C_data <- function(){
  # load data for each simulation
  # generate the vector for calculating the sum of the community richness
  sum_rich_500 <- c()
  sum_rich_1000 <- c()
  sum_rich_2500 <- c()
  sum_rich_5000 <- c()
  combine_result <- list()
  for (i in 1:100) {
    ##### data 31_iter has some problem, use data 35_iter replacing
    if(i == 31){
      load("35_iter_test_file.rda")
    }else{
      f <- paste0(i,"_iter_test_file.rda")
      load(f)
    }
    
    # calculate the mean of each size 
    
    if (i%%4==0) {
      sum_rich_500 <- sum_vect(sum_rich_500, as.numeric(result$richness_inter))
    }
    if(i%%4 == 1){
      sum_rich_1000 <- sum_vect(sum_rich_1000, as.numeric(result$richness_inter))
    }
    if(i%%4 == 2){
      sum_rich_2500 <- sum_vect(sum_rich_2500, as.numeric(result$richness_inter))
    }
    if(i%%4 == 3){
      sum_rich_5000 <- sum_vect(sum_rich_5000, as.numeric(result$richness_inter))
    }
    
    # mean_rich <- add each size's mean_rich / 25
    combine_result[[1]] <- sum_rich_500/25
    combine_result[[2]] <- sum_rich_1000/25
    combine_result[[3]] <- sum_rich_2500/25
    combine_result[[4]] <- sum_rich_5000/25
  }
  # save the data for plot challenge_C
  save(combine_result, file = "Challenge_C_data.rda")
}

Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  # load rda data
  load(file = "Challenge_C_data.rda")
  # plot
  plot(1, type = "n", xlim = c(1,5000*8), ylim = c(0,100), xlab = "Generation", ylab = "Mean Richness",
       main = c("mean of species richness against simulation generation"), cex.main = 1 )
  colors <- rainbow(4)
  for (i in 1:4) {
    lines(1:length(combine_result[[i]]), combine_result[[i]], col= colors[i], lwd=1)
  }
  abline(v=1500)
  legend("bottomright", legend = c("size=500","size=1000", "size=2500", "size=5000"), col=rainbow(4), lty=1, cex = 0.7)
  
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  # community size J
  J <- 100
  # speciation rate v
  v <- 0.1
  N <- J
  
  lineages <- init_community_min(J)
  abundances <- c()
  theta <- v*(J-1)/(1-v)
  
  while (N>1) {
    sample_index <- 1:N
    j <- sample(size = 1,sample_index)
    i <- sample(size = 1,sample_index[-j])
    randnum <- runif(1,min=0, max=1)
    if(randnum < theta/(theta+N-1)){
      abundances <- append(abundances, lineages[j])
    }else{
      lineages[i]=lineages[i]+lineages[j]
    }
    lineages <- lineages[-j]
    N <- N-1
  }
  abundances <- c(abundances,lineages)
  
  return(abundances)
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  x=y=3
  origin_points <- list(c(0,0),c(2,0),c(1,3^(1/2)))
  i<-1
  plot(1,type = 'n', main ="Challenge E", xlim = c(-1,4),ylim = c(-1,4), axes =  TRUE, xlab = "",ylab = "")
  while (i <= 10) {
    #browser()
    color <- rainbow(10)
    points(x,y,pch = 20,cex=1, col = color[i])
    samp <- sample(1:3,1)
    x <- (origin_points[[samp]][1]+x)/2
    y <- (origin_points[[samp]][2]+y)/2
    i<- i+1
  }
  j <- 1
  while (j <= 1000) {
    points(x,y,pch = 20,cex=0.00001)
    samp <- sample(1:3,1)
    x <- (origin_points[[samp]][1]+x)/2
    y <- (origin_points[[samp]][2]+y)/2
    j <- j+1
  }

  text(-.5,-.5,"A(0,0)")
  text(3,0,"B(2,0)")
  text(1,2,"C(1,3^(1/2))")

  return("The point will go closer to the triangle and move within the initial three points after the point gets into the area of the triangle.")
}
# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


