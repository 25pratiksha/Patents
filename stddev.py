import pandas
import matplotlib.pyplot as plt

url='/Users/pjain/Downloads/thesis/CSV files/Revenuebyyrs.csv'
dt=pandas.read_csv(url,delimiter=',')
cols=['REVENUE2010','REVENUE2011','REVENUE2012','REVENUE2013','REVENUE2014','REVENUE2015','REVENUE2016']


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

sx=[]
sy=[]
sx = [2010, 2011, 2012, 2013, 2014, 2015, 2016]

# for row in gr3.iterrows():
#     sy = row[1][0:7]
#     plt.plot(sx,sy)
# plt.show()

# for row in gr3.iterrows():
#     sy = row[1][0:7]
#     plt.scatter(sx,sy)
# plt.show()


low=.01
high=.99
qd=gr3.quantile([low,high])

gr3 = gr3.apply(lambda x: x[(x>= qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)



r1=gr3['REVENUE2010'].mean()
r2=gr3['REVENUE2011'].mean()
r3=gr3['REVENUE2012'].mean()
r4=gr3['REVENUE2013'].mean()
r5=gr3['REVENUE2014'].mean()
r6=gr3['REVENUE2015'].mean()
r7=gr3['REVENUE2015'].mean()


sy=[r1,r2,r3,r4,r5,r6,r7]

r1=gr3['REVENUE2010'].std()
r2=gr3['REVENUE2011'].std()
r3=gr3['REVENUE2012'].std()
r4=gr3['REVENUE2013'].std()
r5=gr3['REVENUE2014'].std()
r6=gr3['REVENUE2015'].std()
r7=gr3['REVENUE2015'].std()

e=[r1,r2,r3,r4,r5,r6,r7]

print e

plt.errorbar(sx,sy,e,color='red',label='1 Patent',marker='^')


qd=gr2.quantile([low,high])


gr2 = gr2.apply(lambda x: x[(x>=qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)




r1=gr2['REVENUE2010'].mean()
r2=gr2['REVENUE2011'].mean()
r3=gr2['REVENUE2012'].mean()
r4=gr2['REVENUE2013'].mean()
r5=gr2['REVENUE2014'].mean()
r6=gr2['REVENUE2015'].mean()
r7=gr2['REVENUE2015'].mean()

sy=[r1,r2,r3,r4,r5,r6,r7]

r1=gr2['REVENUE2010'].std()
r2=gr2['REVENUE2011'].std()
r3=gr2['REVENUE2012'].std()
r4=gr2['REVENUE2013'].std()
r5=gr2['REVENUE2014'].std()
r6=gr2['REVENUE2015'].std()
r7=gr2['REVENUE2015'].std()

e=[r1,r2,r3,r4,r5,r6,r7]
print e

plt.errorbar(sx,sy,e,color='blue',label='>3 Patent',marker='^')


low=.01
high=.95
qd=gr1.quantile([low,high])

gr1 = gr1.apply(lambda x: x[(x>=qd.loc[low,x.name]) &
                                    (x <= qd.loc[high,x.name])], axis=0)



r1=gr1['REVENUE2010'].mean()
r2=gr1['REVENUE2011'].mean()
r3=gr1['REVENUE2012'].mean()
r4=gr1['REVENUE2013'].mean()
r5=gr1['REVENUE2014'].mean()
r6=gr1['REVENUE2015'].mean()
r7=gr1['REVENUE2015'].mean()

sy=[r1,r2,r3,r4,r5,r6,r7]


r1=gr1['REVENUE2010'].std()
r2=gr1['REVENUE2011'].std()
r3=gr1['REVENUE2012'].std()
r4=gr1['REVENUE2013'].std()
r5=gr1['REVENUE2014'].std()
r6=gr1['REVENUE2015'].std()
r7=gr1['REVENUE2015'].std()

e=[r1,r2,r3,r4,r5,r6,r7]

print e
plt.errorbar(sx,sy,e,color='green',label='0 Patent',marker='^')

plt.xlabel('Years')
plt.ylabel('Revenue indexed by revenue of year 2010 as 1')

plt.legend()



plt.show()