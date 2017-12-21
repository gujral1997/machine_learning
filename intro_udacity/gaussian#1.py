import numpy as np
x=np.array([[-1,-1],[-2,-1],[-3,-2],[1,1],[2,1],[3,2]])
y=np.array([1,1,1,2,2,2])
from sklearn.naive_bayes import GaussianNB
clf=GaussianNB() #classifier
clf.fit(x,y)
print(clf.predict([[3,-1],[1,1]]))
