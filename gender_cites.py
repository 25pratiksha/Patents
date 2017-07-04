import matplotlib.pyplot as plt
import pandas
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from scipy.optimize import curve_fit
import numpy as np


url='/Users/pjain/Downloads/thesis/CSV files/PatentInfor.csv'
dt=pandas.read_csv(url,delimiter=';')
cols=['female/patent','male/patent','cites/patent','REVENUE2010','REVENUE2011','REVENUE2012','REVENUE2013','REVENUE2014','REVENUE2015','REVENUE2016']

dt['female/patent']=dt['FEMALE']/dt['PATENT_COUNT']
dt['male/patent']=dt['MALE']/dt['PATENT_COUNT']
dt['cites/patent']=dt['CITES']/dt['PATENT_COUNT']

dt1=dt[cols]

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

low=.01
high=.99

rev=['REVENUE2010','REVENUE2011','REVENUE2012','REVENUE2013','REVENUE2014','REVENUE2015','REVENUE2016']
dtrev=dt1[rev]
qd=dtrev.quantile([low,high])
qd
dtrev = dtrev.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)


dtrev=dtrev.fillna(method='pad',axis='columns')
dtrev=dtrev.fillna(method='bfill',axis='columns')
dtrev['female/patent']=dt1['female/patent']
dtrev['male/patent']=dt1['male/patent']
dtrev['cites/patent']=dt1['cites/patent']

dtnew=dtrev
dtnew=dtnew[((dtrev['female/patent']>0)|(dtrev['male/patent']>0))]

dtfemale=dtnew[dtnew['male/patent']==0]
dtmale=dtnew[dtnew['female/patent']==0]
dtmix=dtnew[((dtnew['female/patent']>0) & (dtrev['male/patent']>0 ))]


high=.95
qd=dtmale.quantile([low,high])
dtmale = dtmale.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)
low=0.03
high=.97
qd=dtfemale.quantile([low,high])
dtfemale = dtfemale.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)

high=.97
qd=dtmix.quantile([low,high])
dtmix = dtmix.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)


yfemale=dtfemale.mean()
ymale=dtmale.mean()
ymixed=dtmix.mean()

yfemale=yfemale[rev]
ymale=ymale[rev]
ymixed=ymixed[rev]

efemale=dtfemale.std()
emale=dtmale.std()
emixed=dtmix.std()

efemale=efemale[rev]
emale=emale[rev]
emixed=emixed[rev]



sx = [2010, 2011, 2012, 2013, 2014, 2015, 2016]
plt.errorbar(sx,yfemale,efemale,color='green',label='Female',marker='^')
plt.errorbar(sx,ymale,emale,color='red',label='Male',marker='^')
plt.errorbar(sx,ymixed,emixed,color='blue',label='Mixed',marker='^')
plt.xlabel('Years')
plt.ylabel('Revenue indexed by revenue of year 2010 as 1')
plt.legend()
plt.show()
