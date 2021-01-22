#!/usr/bin/env R

library(ggplot2)
library(tidyverse)
library(plyr)
library(broom)

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

# Initialize a new dataframe
PP_Regress_loc_Results_DF <- data.frame("predator_lifestage" = MyDF$Predator.lifestage,
                                    "feeding_interaction" = MyDF$Type.of.feeding.interaction,
                                    "location" = MyDF$Location,
                                    "prey.mass" = log10(MyDF$Prey.mass), 
                                    "predator.mass" = log10(MyDF$Predator.mass))

# Initialize new data frame and calculate the linear regression results by Feeding Type × Predator life Stage using ddply (avoids looping)
PP_Regress_loc_Results <- ddply(PP_Regress_loc_Results_DF, .(location, predator_lifestage, feeding_interaction), summarize, # Group by 'predator_lifestage, feeding_interaction'
              slope = lm((predator.mass)~(prey.mass))$coefficients[2],
              intercept = lm((predator.mass)~(prey.mass))$coefficients[1], 
              r_squared = summary(lm((predator.mass)~(prey.mass)))$r.squared,
              f_statistic_value = as.numeric(glance(lm((predator.mass)~(prey.mass)))[4]), # ANOVA kept producing error: Error in quickdf(.data[names(cols)]) : length(rows) == 1 is not TRUE
              p_value = summary(lm((predator.mass)~(prey.mass)))$coefficients[8]) # ANOVA kept producing error: Error in quickdf(.data[names(cols)]) : length(rows) == 1 is not TRUE

dplyr::glimpse(PP_Regress_loc_Results)

write.csv(PP_Regress_loc_Results, file = "../Results/PP_Regress_loc_Results.csv")