# MiniProject -- Fitting models on data sets

## Author name and contact
Zongyi Hu zh2720@ic.ac.uk

## Brief description
Fit mathematical models to data sets, and comparing the fitting effects to choose the better model

## Language
Shell, python, R, latex

## Project structure and Usage
Hierarchical structure, for fitting cubic, logistic and Gompertz models on population growth data sets.

## Process
### 1. Data Standardization (data.R)
1. delete the population size of negative numbers which do not have any biological meaning.
2. The population size in each data set was log-transformed for better analysing when the population growth is still in the lag phase with
too small size and comparing the Gompertz model, which models the
log-transformed variables, with other two models when calculating the
AICc, AIC and BIC value of each model in the identical standard.
### 2. Models fitting on experimental data sets (Gompertz.R and Logistic.R)
1. define the model_logistic() and model_gompertz() functions to return the equations of logistic and Gompertz models.
2. Parameter estimation: estimate the preliminary parameters as starting value to fit the models.
3. Sample the starting value 1000 times around the preliminary starting values with the factor of 0.2 follow the normal distribution.
4. In GuessStart function: fitting the models using the nlsLM() function from minpack.lm package in R. It is possible to fail when fitting the non-linear model with too far-reach starting value, so within the function, using the tryCatch() function in base R to return the error and avoid stop the whole process.
5. Repeat the GuessStart() function fitting 1000 different starting values sampled in step 3 for each model.
6. Comparing the 1000 results and return the best successful-fitting result with lowest AICc, which contains the evaluation data: AICc, AIC, BIC and R^2,starting values of parameters used and the plot point predicted by the predict() function in base R. The AICc and BIC values are calculated by the in-built function in R. To calculate the AICc, the equation: AICc = AIC + 2K(K+1)/(n-K-1) was used
7. Write the starting value with lowest AICc of each data set into files named logistic/gompertz starting value.csv and plot points into files named logistic/gompertz plot points.csv
### 3. Compare Models and Visualization (Compare Models and plot.R)
1. read the evaluation data and predict plot points.
2. using the lm() function to fit the cubic linear model to the data sets and get the same evaluation data as logistic and Gompertz model.
3. write the evaluation data of three models in the data frame and using them to compare the goodness-of-fit of each model.
4. plot the actual data points overlap with predicted lines to visualize the effects of the fitting.
### 4. Integrate the Whole Project(run MiniProject.py)
Write the single script to integrate the whole process of the project and generate the submission PDF file.