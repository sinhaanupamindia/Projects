#predicting the death rate in city ABCD
library(car)
library(corrplot)
options(scipen = 999)
Deathrate <- read.csv("D:/ANUPAM/study/sem2/multi variate analysis-1/30 may/Dataset.csv")

summary(Deathrate)
str(Deathrate)

model <- lm(P~A+B+C+D+E+ F +G+H+I+J+K+L+M+N+O, data = Deathrate)
vif(model)
summary(model1)

model2 <- lm(P~A+B+C+D+E+G+H+J+L+N+O, data = Deathrate)
vif(model2)
summary(model2)



corr=cor(Deathrate)
pairs(Deathrate, pch = 17 , col = "Red")
corrplot(corr, method = "number", type="lower", addCoef.col = 1, number.cex = 0.5)
colnames(Deathrate)






# Test for heteroscedasity
plot(model2)
# to set the graphical parameters - default is c(5.1, 4.1, 4.1, 2.1)
#mar sets the margin sizes in the following order: bottom, left, top, and right.
par(mar = c(2,2,2,2))
par(mfrow = c(2,2))

#scale location graph - red line should be straight or heteroscad. & even if red line is straight residual/dots should not have pattern
#residual Vs fitted - 
# if not clear with trend analysis, do bp / white test

# BP Test - Ho: the variance is constant   - Ha: the variance is not constant
install.packages("lmtest")
library(lmtest)
bptest(model2)
#Autocoorelation: Hypothesis Durbin Watson test are:
#H0: Autocorrelation doesnot exist in Model.
#H1: Autocorrelation does exist in Model.
lmtest::dwtest(model2)





