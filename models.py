import matplotlib.pyplot as plt
import pandas
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from scipy.optimize import curve_fit
import numpy as np

url='/Users/pjain/Downloads/thesis/CSV files/fulldataset.csv'
dt=pandas.read_csv(url,delimiter=',')
cols=['REVENUE2010','REVENUE2011','REVENUE2012','REVENUE2013','REVENUE2014','REVENUE2015','REVENUE2016']

