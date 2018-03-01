# -*- coding: utf-8 -*-
"""
Created on Sat Feb 10 07:30:02 2018

@author: yyf
"""

import pandas as pd
import numpy
import csv
import sys
import matplotlib.pyplot as plt

AZ_1=pd.read_csv('C:\\Users\\yyf\\Desktop\\MCM\\total\\TETCB-AZ.csv')
CA_1=pd.read_csv('C:\\Users\\yyf\\Desktop\\MCM\\total\\TETCB-CA.csv')
NM_1=pd.read_csv('C:\\Users\\yyf\\Desktop\\MCM\\total\\TETCB-NM.csv')
TX_1=pd.read_csv('C:\\Users\\yyf\\Desktop\\MCM\\total\\TETCB-TX.csv')

AZ_1=AZ_1.set_index('Year')
CA_1=CA_1.set_index('Year')
NM_1=NM_1.set_index('Year')
TX_1=TX_1.set_index('Year')

fig=plt.figure()
fig,axes=plt.subplots(1,1)
axes.plot(AZ_1,label='Arizona')
axes.plot(CA_1,label='California')
axes.plot(NM_1,label='New Mexico')
axes.plot(TX_1,label='Texas')
plt.legend(loc = 'upper left') 
plt.show()