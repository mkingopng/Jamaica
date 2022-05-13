"""

"""
from analyzer import *
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.dates import DateFormatter
import seaborn as sns
import datetime as dt

# set global plot parameters
sns.set_theme()
sns.set_palette('magma')
sns.axes_style()
sns.set_style()
sns.plotting_context()
sns.set_context()
titledict = {'fontsize': 20}
axesdict = {'fontsize': 14}
vlinestyle = 'dotted'

df = pd.read_csv('data2/what i want.csv')

nested_list = [COMMERCIAL_SALES_LIST, OIL_SALES_LIST, TUFFA_SALES_LIST, RETAIL_SALES_LIST, HIRE_SALES]
months = ['January_20', 'February_20', 'March_20', 'April_20', 'May_20', 'June_20', 'July_20', 'August_20',
          'September_20', 'October_20', 'November_20', 'December_20', 'January_21', 'February_21', 'March_21',
          'April_21']

analyzer = ProfitLossAnalyzer()
reader = CsvReader
month_cols = analyzer.build_monthly_columns_for_year(2020)
path = 'other_output/'

# data
df = df.drop(labels=['cc', 'accounting_code', 'description', 'alt_product_group', 'year', 'May_21', 'June_21',
                     'July_21', 'August_21', 'September_21', 'October_21', 'November_21', 'December_21'], axis=1)

x = months
y = df.groupby(['category']).sum(month_cols)
labels = ['commercial', 'hire', 'oil', 'tuffa', 'retail']
title = 'Company Sales Revenue'

plt.stackplot(x, y, labels=labels)
plt.xlabel('months')
plt.ylabel('Kina')
plt.title(title)
plt.xticks(x, rotation=45)
plt.legend(loc='upper left', bbox_to_anchor=(0.0, 0.4))
plt.tight_layout()
plt.savefig('revenue.png')
plt.show()

# df.plot(kind='bar', stacked=True, x=x, y=y, figsize=(15, 9))
# plt.ylabel('Kina', fontsize=14)
# plt.xlabel('Date', fontsize=14)
# plt.title('Revenue', fontsize=20)
# plt.legend(loc='center left', bbox_to_anchor=(0.25, -0.4))
# plt.savefig('revenue_plot.png')
# plt.show()

# fix_me: staff costs / overheads over time
# fix_me: cost of finance over time