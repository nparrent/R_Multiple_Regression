#wd = "C:\\Users\\Bryan.Hammer\\Documents\\github\\bgen694-abs-master\\multiple-regression\\data"
wd = "C:\\Users\\npleg\\Documents\\GitHub\\multiple-regression-ice-nparrent//data"
setwd(wd)

install.packages("ppcor")
#############################################
#===============Read in data================#
#############################################

df <- read.table('states.csv', header = TRUE, sep = ',')

summary(df)

data <- df[,c("Population", "Income", "Illiteracy", "Life_Exp", "Murder", "HS_Grad", "Frost", "Area")]
corr <- cor(data)
print(signif(corr, 4))

# Assign variable names to DataFrame Column objects "Income", "Illiteracy", "Life_Exp", "Murder", "HS_Grad", "Frost", "Area"

state <- df$State
population <- df$Population
income <- df$Income
illiteracy <- df$Illiteracy
life_exp <- df$Life_Exp
murder <- df$Murder
hs_grad <- df$HS_Grad
frost <- df$Frost
area <- df$Area

#==========================================================

plot(population, income)
plot(illiteracy, income)
plot(life_exp, income)
plot(murder, income)
plot(hs_grad, income)
plot(frost, income)
plot(area, income)

pairs(data, panel=panel.smooth)


#==========================================================
# =============================
# ==== Assessing Linearity ====
# =============================

# Perform log transformations to encourage
# a linear relationship
logArea <- log(area)
logPopulation <- log(population)
logMurder <- log(murder)

par(mfrow=c(1,2))
plot(logArea, income, main="Scatterplot of Area vs Income")
plot(logPopulation, income, main="Scatterplot of Population vs Income")
plot(logMurder, income,)

# Checking correlations before and after 
# transformations. Does not control for
# other correlations, so we should either
# use partial correlations or regression
M1 <- cbind(population, illiteracy, life_exp, murder, hs_grad, frost, area)
print(cor(M1))
M2 <- cbind(logPopulation, illiteracy, life_exp, logMurder, hs_grad, frost, logArea)
print(cor(M2))

# Comparing regression models
mod1 <- lm(income ~ population+illiteracy+life_exp+murder+hs_grad+frost+area) 
summary(mod1)
mod2 <- lm(income ~ logPopulation+illiteracy+life_exp+logMurder+hs_grad+frost+logArea)
summary(mod2)

library(moments)
mod1_rstand <-rstandard(mod1)
qqnorm(mod1_rstand, ylab="Standardized Residuals of Assets", xlab="Normal Quantiles")
qqline(mod1_rstand)
hist(mod1_rstand)
print(skewness(mod1_rstand))
print(kurtosis(mod1_rstand))

mod2_rstand <-rstandard(mod2)
qqnorm(mod2_rstand, ylab="Standardized Residuals of Assets", xlab="Normal Quantiles")
qqline(mod2_rstand)
hist(mod2_rstand)
print(skewness(mod2_rstand))
print(kurtosis(mod2_rstand))

# ===========================
# Residuals normality tests

# Kolomogorov-Smirnov Test
print(ks.test(mod1_rstand,"pnorm"))
print(ks.test(mod2_rstand, "pnorm"))

# Shapiro-Wilk Test
print(shapiro.test(mod1_rstand))
print(shapiro.test(mod2_rstand))

# =======================================
# ==== Assessing Heteroscedascticity ====
# Using standardized residuals vs 
# standardized predictions
# =======================================

# Getting Standardized Predictions for Each Model
mod1_pred <- predict(mod1)
mod2_pred <- predict(mod2)
mod1_pstand <-  (mod1_pred - mean(mod1_pred))/sd(mod1_pred)
mod2_pstand <-  (mod2_pred - mean(mod2_pred))/sd(mod2_pred)

# Do the plot for each model
par(mfrow=c(2,1))
plot(mod1_pstand, mod1_rstand, 
     main = "Model 1: lm(assets ~ age+mortgage)
     \nStandardized Predictions vs Standardized Residuals",
     xlab = "Standardized Predictions",
     ylab = "Standardized Residuals",
     xlim = c(-3, 3))
     
plot(mod2_pstand, mod2_rstand, 
     main = "Model 2: lm(assets ~ age+logHome+logMort)
     \nStandardized Predictions vs Standardized Residuals",
     xlab = "Standardized Predictions",
     ylab = "Standardized Residuals",
     xlim = c(-3, 3))

     # =====================================
# ==== Assessing Multicollinearity ====
# =====================================

# From Rosenkrantz, "Probability and Statistics 
# for Science, Engineering and Finance," CRC 
# Press, Boca raton, 2009. Table 10.2.
# Twelve 1992 cars were measured for fuel 
# efficiency. The response variable is miles per 
# gallon (MPG).


M <- cbind(population, illiteracy, life_exp, murder, hs_grad, frost, area)
print(cor(M))

# car_weight and car_disp are highly correlated
# i.e., high collinearity

colin_mod1 <- lm(income ~ murder+illiteracy)
summary(colin_mod1)

colin_mod2 <- lm(income ~ population+illiteracy+life_exp+murder+hs_grad+frost+area)
summary(colin_mod2)

# Collinearity diagnostics using library "olsrr"
install.packages("olsrr")
library(olsrr)
ols_vif_tol(colin_mod2)
ols_vif_tol(colin_mod1)

ols_vif_tol(mod1)
ols_vif_tol(mod2)

# Alternatively, you can use the library "car"
# to calculate the VIF. Additionally, it
# provides the Durbin-Watson test
install.packages("car")
library(car)

vif(colin_mod1)
vif(colin_mod2)

# =============================
# ==== Outlier Diagnostics ====
# =============================
mod_pop <- lm(income~area)
summary(mod_pop)

leverage <- hatvalues(mod_pop)
stud_res <- rstudent(mod_pop)
cook_dist <- cooks.distance(mod_pop)

df_home <-data.frame(income, area, leverage, stud_res, cook_dist)
print(round(df_home,4))

max(df_home$cook_dist)

plot(leverage, income, xlab = "Leverage for Income", ylab = "Area")
text(leverage, income, labels=paste(frost), cex = 0.6, pos = 3, col = 2)

# Plot of Leverage (hat-value) versus Studentized Residuals
plot(leverage, stud_res, xlab = "Leverage for Home Value", ylab = "Studentized Residuals")
text(leverage, stud_res, labels=paste(area), cex = 0.6, pos = 3, col = 2)

# Outlier Diagnostics using log-transformed Home
mod_loghome <- lm(assets~logHome)
summary(mod_loghome)
leverage <- hatvalues(mod_loghome)
stud_res <- rstudent(mod_loghome)
cook_dist <- cooks.distance(mod_loghome)
df_loghome <-data.frame(logHome, assets, leverage, stud_res, cook_dist)
print(round(df_loghome,4))
