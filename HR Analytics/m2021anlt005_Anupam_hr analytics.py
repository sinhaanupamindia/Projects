# -*- coding: utf-8 -*-
"""
Created on Sun May 29 17:46:28 2022

@author: user
"""


# -*- coding: utf-8 -*-
"""
Created on Sat May 28 16:14:36 2022

@author: user
"""

# -*- coding: utf-8 -*-
"""
Created on Fri May 27 11:54:14 2022

@author: user
"""

#Importing librarires
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn import metrics

from sklearn.preprocessing import LabelEncoder



attrdata = pd.read_csv("D:/ANUPAM/study/sem2/HR analytics/individual assign/hr_dataset.csv")
print(attrdata.head())



print(attrdata.isnull().sum())
#median replacement for null values

desc = attrdata.describe()
print(desc)

attrdata['Duration to accept offer'] = attrdata['Duration to accept offer'].fillna(attrdata['Duration to accept offer'].median())
attrdata['Pecent hike expected in CTC'] = attrdata['Pecent hike expected in CTC'].fillna(attrdata['Pecent hike expected in CTC'].median())
attrdata['Percent hike offered in CTC'] = attrdata['Percent hike offered in CTC'].fillna(attrdata['Percent hike offered in CTC'].median())
attrdata['Percent difference CTC'] = attrdata['Percent difference CTC'].fillna(attrdata['Percent difference CTC'].median())
attrdata.describe()

print(attrdata.isnull().sum())
#shape of dataset




encoder = LabelEncoder()
#data cleaning and encoding
# Encoding
attrdata['DOJ Extended'] = encoder.fit_transform(attrdata['DOJ Extended'])
attrdata['Offered band'] = encoder.fit_transform(attrdata['Offered band'])
attrdata['Joining Bonus'] = encoder.fit_transform(attrdata['Joining Bonus'])
attrdata['Candidate relocate actual'] = encoder.fit_transform(attrdata['Candidate relocate actual'])
attrdata['Gender'] = encoder.fit_transform(attrdata['Gender'])
attrdata['Candidate Source'] = encoder.fit_transform(attrdata['Candidate Source'])
attrdata['LOB'] = encoder.fit_transform(attrdata['LOB'])
attrdata['Location'] = encoder.fit_transform(attrdata['Location'])
attrdata['Status'] = encoder.fit_transform(attrdata['Status'])
attrdata['Duration to accept offer'] = encoder.fit_transform(attrdata['Duration to accept offer'])


#scaling 










'''

#scaling the features
# make a copy of dataframe
scaled_features = attrdata.copy()

col_names = ['DOJ Extended',	'Duration to accept offer',	'Notice period',	'Offered band',	'Pecent hike expected in CTC',	'Percent hike offered in CTC'	,'Percent difference CTC'	,'Joining Bonus',	'Candidate relocate actual',	'Gender',	'Candidate Source',	'Rex in Yrs',	'LOB',	'Location',	'Age']
features = scaled_features[col_names]

# Use scaler of choice; here Standard scaler is used
scaler = StandardScaler().fit(features.values)
features = scaler.transform(features.values)

scaled_features[col_names] = features


'''

'''



#HEAT MAP after data cleaning and filtering
# Let's make our correlation matrix visual
corr_matrix=scaled_features.corr()
fig,ax=plt.subplots(figsize=(15,10))
ax=sns.heatmap(corr_matrix,
               annot=True,
               linewidths=0.5,
               fmt=".2f"
              )

#dropping correlated columns
scaled_features.drop(['Percent hike offered in CTC', 'Rex in Yrs', 'Candidate Ref'], axis = 1)


#saving clean dataset

scaled_features.to_csv("D:/ANUPAM/study/sem2/HR analytics/individual assign/processed table1.csv")

'''

#from the processed data we have to separate the features and target column again.
#scaled_features_df = pd.read_csv("D:/ANUPAM/study/sem2/HR analytics/individual assign/processed table1.csv")
X = attrdata.drop(columns=['Status'], axis=1)
Y = attrdata['Status']


#Splitting data – Train test split

X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.3, random_state=12344)
print(X_train.shape)
print(X_test.shape)

from sklearn.linear_model import LogisticRegression
#--------------------
model = LogisticRegression()
print(model.fit(X_train, Y_train))
print(model.score(X_test, Y_test))
Y_predict_prob = model.predict_proba(X_test)
### Converting predicted values into classes using threshold
threshold=0.5415

predicted_class1=np.zeros(Y_predict_prob.shape)
predicted_class1[Y_predict_prob<threshold]=1
predicted_class1

#Confusion matrix, Accuracy, sensitivity and specificity


print(Y_predict_prob)
Y_pred =  model.predict(X_test)

print(Y_pred)


#confusion matrix
cm1 = confusion_matrix(Y_test, Y_pred)
print(confusion_matrix)

#####from confusion matrix calculate accuracy
total1=sum(sum(cm1))
accuracy1=(cm1[0,0]+cm1[1,1])/total1


sensitivity1 = cm1[0,0]/(cm1[0,0]+cm1[0,1])
print('Sensitivity : ', sensitivity1 )

specificity1 = cm1[1,1]/(cm1[1,0]+cm1[1,1])
print('Specificity : ', specificity1)
print ('Accuracy : ', accuracy1)
#define metrics
y_pred_proba = model.predict_proba(X_test)[::,1]
fpr, tpr, _ = metrics.roc_curve(Y_test,  y_pred_proba)
auc = metrics.roc_auc_score(Y_test, y_pred_proba)
print("Thresold aus: ", auc)
#create ROC curve
plt.plot(fpr,tpr)
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')
plt.show()


