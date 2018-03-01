# -*- coding: utf-8 -*-
"""
Created on Sat Feb 10 07:30:02 2018

@author: yyf
"""

import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
from scipy.stats import norm, ttest_ind, chisquare, chi2_contingency, chi2

Energy_Census_GDP = pd.read_csv("C:\\Users\\yyf\\Desktop\\MCM\\GDP&population.csv")
Energy_Census_GDP.head()

Energy_features = ['GDP',  'population', 'Total energy consumption','Total energy production']
Energy_CPEP = Energy_Census_GDP[Energy_features]

colormap = plt.cm.viridis
plt.figure(figsize = (8,8))
plt.title('Correlation between energy and population, GDP', y=1.13, size = 20)
sns.heatmap(Energy_CPEP.corr(),
            linewidths=0.1, 
            center = 0,
            vmin = -1,
            vmax = 1, 
            annot = True,
            square = True, 
            fmt ='.2f', 
            annot_kws = {'size': 10},
            cmap = colormap, 
            linecolor ='white');
