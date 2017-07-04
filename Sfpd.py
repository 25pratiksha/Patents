import pandas
import stateplane as sp

##data taken from SFPD incidents from 2003 open data SF
data=pandas.read_csv('/Users/pjain/Documents/SFPD_Incidents_-_from_1_January_2003-2.csv', delimiter=',')

data.insert(0,'objectid',range(1,2049206))
#objeciId column inserted

date_obj=pandas.to_datetime(data['Date'],format="%m/%d/%Y")
#date to Date format

data['Date']=date_obj
y=date_obj.map(lambda x: x.year)
m=date_obj.map(lambda x: x.month)
d=date_obj.map(lambda x: x.day)

#year,day , month extracted

data['occur_month']=m
data['occur_day']=d
data['occur_year']=y

time_obj=pandas.to_datetime(data['Time'],format="%H:%M")
#time converted

data['Time']=time_obj

dt = pandas.to_datetime(data['occurrence_timestamp'], format="%m/%d/%Y %H:%M")
#timestamp created

data['occurrence_timestamp']=dt
data['occurrence_timestamp']=data['occurrence_timestamp'].apply(lambda x : pandas.to_datetime(str(x)))
data['Time']=data['occurrence_timestamp'].dt.time



data['longitude']=data['X']
data['latitude']=data['Y']
del data['X']
del data['Y']


sy=[]
sx=[]
for index,row in data.iterrows():
    x,y = sp.from_lonlat(row['longitude'],row['latitude'])
    sx.append(x)
    sy.append(y)

dl='('+data['latitude'].map(str)+' '+data['longitude'].map(str)+')'
data['Location']=dl

cols =['objectid','PdId','IncidntNum','Category','Descript','Date','Time','occurrence_timestamp','DayOfWeek','occur_day','occur_month','occur_year','PdDistrict','Resolution','Address','longitude','latitude','Location','easting/X','northing/Y']


data1=data[cols]

data1.to_csv('/Users/pjain/Documents/SFDataUpdate.csv')
