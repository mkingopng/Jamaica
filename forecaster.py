"""
forecast based on history as base case.

then allow user to adjust variables/parameters at low level & see effect on company performance. parameters include
    revenue
    cogs
    direct costs
    overheads
    other income
    other expenses
I prefer not to budget for variances.

as a test case i will model 'some_funny_bird.txt'. its still a work in process. I would like to finish the forecaster
asap. linear regression seems like a reasonable place ot start for forecasting purposes.
"""
import pandas as pd
import statsmodels
import sklearn
from sklearn.linear_model import LinearRegression

# question 5) linear regression for base case for each cc. please note, i dont like to forecast variances for many
#  reasons. variables that need to be forecast: sales revenue, cogs, direct costs. overhead recoveries overheads
#  operating profit, other_income, other expenses, net profit

# a = []

# OLS linear regression
# x = a[''].values.reshape(-1, 1)
# y = a[''].values.reshape(-1, 1)  # actual ratios
# model = LinearRegression()
# model.fit(x, y)  # after this line, you will have a trained model
# pred = model.predict(x)  # predicted ratios
# a['trend'] = pred.flatten()

# question 6) how to 'twist the dials'? ie adjust predicted future performance based on the expected outcomes of
#  actions. need to design a mechanism
