"""
by: noOne
on: 30/8/21
objective:
cleaning and visualising kk kingston P&Ls.
This is a modified csv, not raw output.
"""
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.dates import DateFormatter
from matplotlib.font_manager import FontProperties
import datetime as dt

df = pd.read_csv('data/Company P&L.csv')

# drop unneeded columns
df = df.drop(df.columns[[1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 26, 27, 28, 29]], axis=1)
df = df.dropna()
df = df.drop([36, 114])
df = df.reset_index()
df = df.drop(df.columns[[0]], axis=1)
# question: why don't files in this project show todo, fixit and question in the normal color?
# question: why does pycharm show that files are not part of the project? how do i fix it?
# question: i have a tendency to always want to put time o n the y axis of the table (rows UI) Not sure this is correct
# i can't think of a reason why not keep time on the x axis, in which case no need to transpose

# todo: insert aggregation rows: total revenue, total COGS, trading profit(k), trading margin(%), total manufacturing
#  variances, total stock variances, total direct costs(k), gross profit (k), gross profit (%), total overheads,
#  overheads % of revenue, total expenses as a % of revenue, operating profit, total other income, total other expenses,
#  net profit(k), net profit(%), total staff costs(k), total operating costs, total other costs. This is currently part
#  of the csv but it should be calculated

# set plot global variables
titledict = {'fontsize': 20}
axesdict = {'fontsize': 14}
hlinestyle = 'dotted'
label = 'K13m'
#####################################################
# fixme: ValueError: could not convert string to float: 'Total Revenue'
# Create figure and plot space
fig, ax = plt.subplots(figsize=(15, 7))
# tofix: x ticks not right, y data not right but at least i'm getting a plot
# this isn't right. needs to be column headers, date
x = df.columns.values
# this is not returning correctly
y = df.iloc[26]

# Add x-axis and y-axis
ax.plot(x, y, color='g', label='sales revenue')

# Set title and labels for axes
ax.set_xlabel('Date', fontdict=axesdict)
ax.set_ylabel('sales revenue', fontdict=axesdict)
ax.set_title('sales revenue', fontdict=titledict)

# Define the date format
date_form = DateFormatter("%m-%y")
ax.xaxis.set_major_formatter(date_form)
# ax.get_yaxis().get_major_formatter().set_scientific(False)

# need to fix legend to include blue line
ax.legend(loc='center left', bbox_to_anchor=(0.25, -0.25))
plt.savefig('sales_revenue.png')
plt.show()

####################################################################
# plot trading margin
#
#
# fig, ax = plt.subplots(figsize=(15, 7))
#
# # Add x-axis and y-axis
# ax.plot(x, y1, color='g', label='')
#
# plt.figure()
# ax = sales_revenue.plot.bar()
#
# # Set title and labels for axes
# ax.set_xlabel('Date', fontdict=axesdict)
# ax.set_ylabel('Revenue', fontdict=axesdict)
# ax.set_title('Revenue', fontdict=titledict)
#
# # Define the date format
# date_form = DateFormatter("%m-%y")
# ax.xaxis.set_major_formatter(date_form)
#
# # ax.get_yaxis().get_major_formatter().set_scientific(False)
#
# # set vlines for important dates
# # ax.axhline(dt.datetime(2021, 5, 3), label=label, c='r', linestyle=hlinestyle)
# # tofix: change legend to include blue line
# ax.legend(loc='center left', bbox_to_anchor=(0.25, -0.25))
# plt.savefig('trading_margin.png')
# plt.show()




# manufacturing variances plot

# stock variances plot

# Direct Costs plot

# Operating Costs plot

# Other income plot

# Other expenses plot

# Net Profit plot


# Create figure and plot space
