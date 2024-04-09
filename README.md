[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/AvvTPU3X)
# Multiple Regression ICE
Be clear and detailed in your answers, providing justification and showing any intermediate steps. Simply providing the final answer will *NOT* receive a grade.

To submit, please perform the following:
1. Answer questions in `submission.md`, linking any screenshots as necessary.
1. Please create an R file named `firstname_lastname_ice_multreg.R` and write your code inside it.
1. Push your assignment to GitHub.

## Assumption validation (10 pts.)
For this assignment, you will perform an analysis on a regression model based on data for each State in the United States. The data [states.csv](/data/states.csv) contains 50 rows and 8 columns:
* *State*: name of the State
* *Population*: population estimate as of July 1, 1975.
* *Income*: per capita income (1974)
* *Illiteracy*: illiteracy (1970, percent of population)
* *Life_Exp*: life expectancy in years (1969-71)
* *Murder*: murder and non-negligent manslaughter rate per 100,000 population (1976)
* *HS_Grad*: percent high-school graduates (1970)
* *Frost*: mean number of days with minimum temperature below freezing (1931-1960) in capital or large city
* *Area*: land area in square miles

Source: U.S. Department of Commerce, Bureau of the Census (1977) Statistical Abstract of the United States, and U.S. Department of Commerce, Bureau of the Census (1977) County and City Data Book.

For this data, you will create a model using *Income* as the dependent variable and all other variables as independent variables (do not include *State* as a variable). Please perform the following tasks to assess the validity of the regression assumptions:
1. Assess the linearity of each independent variable by generating a plot for each one. Please comment on the linearity of each plot. Please save a copy of each plot and link it in [submission.md](/submission.md). (1 pt.)
2. For each plot, indicate whether there are potential outliers based on a visual examination. (1 pt.)
3. Write your conclusion about the normality of the Standardized residuals from this model based on the following assessments. Please comment on each of these assessments.
   1. Q-Q plots (0.5 pts.)
   This dataset of standardized residuals does not seem to pass the normality assessment since the data does not sit very close to the normal line. 
   ![Alt text](<assets/Q-Q Plot.png>)

   Even when the log was used to transform three variables (popultion, murder, area) to try and fit a better on their plots, the data sit along the normal line better in the center but the edges are still far from the normal line. You can see it clearly crosses the line and looks s-shaped. I would say this residual data is still not normal.
   ![Alt text](<assets/Q-Q Stnd Plot.png>)

   1. histogram (0.5 pts.)


   1. skewness (0.5 pts.)
   1. kurtosis (0.5 pts.)
   1. Kolmogorov-Smirnov Test (0.5 pts.)
   1. Shapiro-Wilk Test (0.5 pts.)
4. Plot the standardized residuals against the standardized predictions from the model, and comment on the homoscedasticity (or otherwise) of the residuals. (1 pt.)
5. Produce multicollinearity diagnostics for the model and indicate your conclusions. (2 pts.)
6. Produce the outlier diagnostics (i.e., Leverage, Studentized Residuals, and Cook’s D) for the all observations in the model. Identify the observation (i.e., its ID) with highest Cook’s D value. Interpret its Leverage (what it means), its Studentized Residual (what it means) and its Cook’s D (what it means). (2 pts.)