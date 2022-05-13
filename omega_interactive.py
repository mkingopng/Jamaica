"""

"""
from lists_and_dicts import *
from methods_and_classes import *
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import ticker
import seaborn as sns
import hvplot
import panel as pn
import plotly.express as px
import xarray as xr
import hvplot.xarray # noqa
import hvplot.pandas # noqa
import panel.widgets as pnw
import ipywidgets as ipw

# global parameters
pd.options.display.float_format = '{:,.2f}'.format
plt.figure()
plt.rcParams.update({'font.size': 22})
plt.style.use('ggplot')

stock = pd.read_csv('data/stock_transactions.csv')
new = stock['alt_product_group & cc'].str.split(n=0, expand=True)
stock['cc'] = new[0]
stock['alternate_product_group'] = new[1]
stock['cost_value'] = stock['unit_cost'] * stock['quantity']
stock = stock.drop(columns=['alt_product_group & cc'])

num_invalid_apg = pd.isnull(stock['alternate_product_group']).sum()
print(f'You have {num_invalid_apg} records after the preprocessing where you find invalid "alternate_product_group"')
num_invalid_cc = pd.isnull(pd.to_numeric(stock['cc'], errors='coerce')).sum()
print(f'You have {num_invalid_cc} records after the preprocessing where you find invalid "cc"')


# question: talk me through this please
@pn.depends(select_warehouse)
def exp_plot(select_warehouse):
    data = stock[(stock['transaction_type'] == 1) & (stock['warehouse'] == select_warehouse)].copy()
    summary = data.pivot_table(values='value', index='month/year', columns='warehouse', aggfunc=np.sum)
    return summary.hvplot(kind='bar', width=1600, height=600)


pn.Column(select_warehouse, exp_plot).save('test.html', embed=True)
warehouses = stock['warehouse'].unique()
select_warehouse = pn.widgets.Select(options=warehouses.tolist(), name='Warehouse ID')

# load sales statistics
sales_statistics = pd.read_csv('data/sales_statistics.csv')
new = sales_statistics['cc_and_alt_product_group'].str.split(n=0, expand=True)
sales_statistics['cc'] = new[0]
sales_statistics['alternate_product_group'] = new[1]
sales_statistics['cost_value'] = sales_statistics['cost_price_per_uom'] * sales_statistics['quantity']
sales_statistics['sales_revenue'] = sales_statistics['price_per_uom'] * sales_statistics['quantity']
sales_statistics['trading_profit'] = sales_statistics['sales_revenue'] - sales_statistics['cost_value']
sales_statistics['trading_margin'] = (sales_statistics['trading_profit'] / sales_statistics['sales_revenue'])
sales_statistics = sales_statistics.drop(columns=['cc_and_alt_product_group'])

# todo: no more boring plots, try out the options for interactive plots:
#  matplotlib
#  plotly
#  Hiplot & panel
#  bokeh
#  altair

# using matplotlib
fig, ax = plt.subplots()
ln, = ax.plot(range(5))
ln.set_color('orange')
# plt.ioff()
plt.ion()