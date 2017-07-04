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

r1=gr3['REVENUE2010'].mean()
r2=gr3['REVENUE2011'].mean()
r3=gr3['REVENUE2012'].mean()
r4=gr3['REVENUE2013'].mean()
r5=gr3['REVENUE2014'].mean()
r6=gr3['REVENUE2015'].mean()
r7=gr3['REVENUE2015'].mean()

sm=[r1,r2,r3,r4,r5,r6,r7]

sx=[]
sy=[]
x = [1,2,3,4,5,6,7]
for row in gr3.iterrows():
    y=row[1][0:7]
    sx=np.append(sx,x)
    sy=np.append(sy,y)


popt, pcov = curve_fit(func, sx, sy)
plt.plot(x, sm, 'b-', label='mean of data')
plt.scatter(sx,sy,label='data')
plt.plot(sx, func(sx, *popt), 'g--', label='fit-with-bounds')

plt.legend()
plt.xlabel('Years incrementing by 1 start year 2010')
plt.ylabel('Revenue indexed by revenue of year 2010 as 1')
plt.show()



qd=gr2.quantile([low,high])

gr2 = gr2.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)
gr2= gr2.fillna(method='pad',axis='columns')

r1=gr2['REVENUE2010'].mean()
r2=gr2['REVENUE2011'].mean()
r3=gr2['REVENUE2012'].mean()
r4=gr2['REVENUE2013'].mean()
r5=gr2['REVENUE2014'].mean()
r6=gr2['REVENUE2015'].mean()
r7=gr2['REVENUE2015'].mean()

sm=[r1,r2,r3,r4,r5,r6,r7]

sx=[]
sy=[]
x = [1,2,3,4,5,6,7]
for row in gr2.iterrows():
    y=row[1][0:7]
    sx=np.append(sx,x)
    sy=np.append(sy,y)


popt, pcov = curve_fit(func, sx, sy)
plt.plot(x, sm, 'b-', label='mean of data')
plt.scatter(sx,sy,label='data')
plt.plot(sx, func(sx, *popt), 'g--', label='fit-with-bounds')

plt.legend()
plt.xlabel('Years incrementing by 1 start year 2010')
plt.ylabel('Revenue indexed by revenue of year 2010 as 1')
plt.show()



qd=gr1.quantile([low,high])

gr1 = gr1.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)
gr1= gr1.fillna(method='pad',axis='columns')

r1=gr1['REVENUE2010'].mean()
r2=gr1['REVENUE2011'].mean()
r3=gr1['REVENUE2012'].mean()
r4=gr1['REVENUE2013'].mean()
r5=gr1['REVENUE2014'].mean()
r6=gr1['REVENUE2015'].mean()
r7=gr1['REVENUE2015'].mean()

sm=[r1,r2,r3,r4,r5,r6,r7]

sx=[]
sy=[]
x = [1,2,3,4,5,6,7]
for row in gr1.iterrows():
    y=row[1][0:7]
    sx=np.append(sx,x)
    sy=np.append(sy,y)


popt, pcov = curve_fit(func, sx, sy)
plt.plot(x, sm, 'b-', label='mean of data')
plt.scatter(sx,sy,label='data')
plt.plot(sx, func(sx, *popt), 'g--', label='fit-with-bounds')

plt.legend()
plt.xlabel('Years incrementing by 1 start year 2010')
plt.ylabel('Revenue indexed by revenue of year 2010 as 1')
plt.show()
