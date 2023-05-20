data <- read.csv("D:/ANUPAM/study/sem3/pychometrics/group assignment - customer satisfaction/response.csv")
View(data)
attach(data)
names(data) 

library(dplyr)
library(psychometric)
library(psych)
################################
#Scoring
################################
# For reverse scoring code the item as (x-item) x represents the maximum number on your response scale + 1
# thus, if 5 point response scale reverse scoring will be item<-(6-item)
#complete reverse scoring of all the items first
# #st here stands for statement
#data.frame(WD1)<- data$WD1
data['WD1']<-data.frame(6-WD1)
data['WD4']<-data.frame(6-WD4)
data['WD6']<-data.frame(6-WD6)
data['WD7']<-data.frame(6-WD7)
data['WD9']<-data.frame(6-WD9)
data['UI1']<-data.frame(6-UI1)
data['UI2']<-data.frame(6-UI2)
data['UI3']<-data.frame(6-UI3)
data['UI4']<-data.frame(6-UI4)
data['UI6']<-data.frame(6-UI6)
data['UI9']<-data.frame(6-UI9)
data['UI11']<-data.frame(6-UI11)
data['P1']<-data.frame(6-P1)
data['P6']<-data.frame(6-P6)
data['DS5']<-data.frame(6-DS5)
data['DS7']<-data.frame(6-DS7)
data['BI3']<-data.frame(6-BI3)
data['BI7']<-data.frame(6-BI7)
#Create a data frame with all the statements/items
#Scale_items <-data.frame()

Scale_total <- rowSums(data)
Scale_total
psych::alpha(data) #Reliability: check the raw_alpha and the raw alpha for each item 

#Similarly do facet wise scoring and scoring for the other scale (validation scale) as well
#our validation will be through regression
#predictive validity 

################################
#INTER. COR among factor level scales/various facets
################################
#scales<-data.frame(Scale_total)
#scales
#r<-cor(scales,method=c("pearson"))
#r
#round(r, digits=2)
#Create the correlation matrix from bfi_data
bfi_cor <- cor(data)
bfi_cor
################################
#VALIDITY
#regression
################################
#Neuroticism--not
#cor.test(scale_1, scale_2) #check for correlations between the scales 

################################
#FACTOR ANALYISIS
################################
#Neuroticism
#fit<-principal(scale_items, nfactors=#total number of items,residuals=FALSE, rotate= "none", n.obs=#number of observations in the data set)

#eigen<-fit$values
#pc_number<-1:#total number of nfactors
#plot(pc_number, eigen, pch=20,cex=3,cex.lab=2,cex.axis=2,
#main="The Scree Plot",type="b")

#fa.parallel(scale_items, n.obs=#observations in the dataset, fa="pc", main="Parallel Analysis",n.iter=1000)
#Factor analysis of the data
factors_data <- fa(r = bfi_cor, nfactors = 5)
#Getting the factor loadings and model analysis
factors_data


#unrotated
#fit_1<-principal(scale_items, nfactors= #final number as shown,residuals=FALSE, rotate= "none", n.obs=#no. of observations)

#rotated
#fit_2<-principal(scale_items, nfactors=#final number as shown,residuals=FALSE, rotate= "varimax", n.obs=60)

##################################
#PERCENTILE NORMS
##################################


N_norms <- quantile(Scale_total, probs = seq(0, 1, 0.10), na.rm = T,names = TRUE, type = 7)
range(Scale_total)



#elbow point
library(cluster)
library(factoextra)

#create plot of number of clusters vs total within sum of squares
fviz_nbclust(data, kmeans, method = "wss")