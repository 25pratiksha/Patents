import matplotlib.pyplot as plt
import pandas
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from scipy.optimize import curve_fit
import numpy as np


url='/Users/pjain/Downloads/thesis/CSV files/Revenuebyyrs.csv'
dt=pandas.read_csv(url,delimiter=',')
cols=['REVENUE2010','REVENUE2011','REVENUE2012','REVENUE2013','REVENUE2014','REVENUE2015','REVENUE2016']



def func(x, m, c):
    return m*x + c


dt1=dt[cols]
#max=dt1.max(axis='columns')

max=dt1['REVENUE2010']


a= dt1['REVENUE2010']/max
b= dt1['REVENUE2011']/max
c= dt1['REVENUE2012']/max
d= dt1['REVENUE2013']/max
e= dt1['REVENUE2014']/max
f= dt1['REVENUE2015']/max
g= dt1['REVENUE2016']/max


dt1['REVENUE2010']=a
dt1['REVENUE2011']=b
dt1['REVENUE2012']=c
dt1['REVENUE2013']=d
dt1['REVENUE2014']=e
dt1['REVENUE2015']=f
dt1['REVENUE2016']=g


dt1['PATENT_COUNT']=dt['PATENT_COUNT']

gr3= dt1[dt1['PATENT_COUNT']>2]
gr1= dt1[dt1['PATENT_COUNT']==0]
gr2=dt1[dt1['PATENT_COUNT']>0]
gr2=gr2[gr2['PATENT_COUNT']<3]


gr1=gr1[cols]
gr2=gr2[cols]
gr3=gr3[cols]

low=.01
high=.99
qd=gr3.quantile([low,high])

gr3 = gr3.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)
gr3= gr3.fillna(method='pad',axis='columns')

sm=gr3.mean()

sx=[]
sy=[]
x = [1,2,3,4,5,6,7]
for row in gr3.iterrows():
    y=row[1][0:7]
    sx=np.append(sx,x)
    sy=np.append(sy,y)


popt3, pcov3 = curve_fit(func, sx, sy)
print popt3
plt.plot(sx, func(sx, *popt3), 'g--', label='group3')


qd=gr2.quantile([low,high])

gr2 = gr2.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)
gr2= gr2.fillna(method='pad',axis='columns')

sm=gr2.mean()

sx=[]
sy=[]
x = [1,2,3,4,5,6,7]
for row in gr2.iterrows():
    y=row[1][0:7]
    sx=np.append(sx,x)
    sy=np.append(sy,y)


popt2, pcov2 = curve_fit(func, sx, sy)
print popt2

plt.plot(sx, func(sx, *popt2), 'b--', label='group2')

plt.legend()
plt.show()

##[ 0.01707614  0.96588895] --gr2
##[ 0.03338735  0.94311584] --gr3
##0.00725475,  0.98877292  --gr1
