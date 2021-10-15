"""

"""
from lists_and_dicts import *
from methods_and_classes import *
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import ticker
import seaborn as sns

# global parameters
pd.options.display.float_format = '{:,.2f}'.format
plt.style.use('my_style')


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

# transaction type 1: debit raw materials
chemical_sum = summarise_stock(stock, 1, 48, '50', 'quantity', np.sum)
oil_sum = summarise_stock(stock, 1, 40, '55', 'quantity', np.sum)
plastics_sum = summarise_stock(stock, 1, 60, '60', 'quantity', np.sum)
paper_sum = summarise_stock(stock, 1, 41, '80', 'quantity', np.sum)
tuffa_sum = summarise_stock(stock, 1, 51, '85', 'quantity', np.sum)

# concatenate
raw_mats_one = pd.DataFrame()
raw_mats_one = pd.concat([raw_mats_one, chemical_sum], axis=1).rename(columns={'value': 'chemical'})
raw_mats_one = pd.concat([raw_mats_one, oil_sum], axis=1).rename(columns={'value': 'oil'})
raw_mats_one = pd.concat([raw_mats_one, plastics_sum], axis=1).rename(columns={'value': 'plastics'})
raw_mats_one = pd.concat([raw_mats_one, paper_sum], axis=1).rename(columns={'value': 'paper'})
raw_mats_one = pd.concat([raw_mats_one, tuffa_sum], axis=1).rename(columns={'value': 'tuffa'})

# plot
ax = raw_mats_one.plot(kind='bar', stacked=True, title='Factory Raw Material Use', xlabel='Months', ylabel='Units')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/all_factories_raw_material_use.png')
plt.show()

# todo: invert, legend problem, value or volume?
# there are a couple of odd values but in general it passes the common sense test.
# the spike in chemical in april 20 is an error in the data related to the product 'blue era'

# transaction type 0: credit finished goods
chemical_sum = summarise_stock(stock, 0, 48, '50', 'quantity', np.sum)
oil_sum = summarise_stock(stock, 0, 40, '55', 'quantity', np.sum)
plastics_sum = summarise_stock(stock, 0, 60, '60', 'quantity', np.sum)
paper_sum = summarise_stock(stock, 0, 41, '80', 'quantity', np.sum)
tuffa_sum = summarise_stock(stock, 0, 51, '85', 'quantity', np.sum)

# concatenate
finished_goods = pd.DataFrame()
finished_goods = pd.concat([finished_goods, chemical_sum], axis=1).rename(columns={'value': 'chemical'})
finished_goods = pd.concat([finished_goods, oil_sum], axis=1).rename(columns={'value': 'oil'})
finished_goods = pd.concat([finished_goods, plastics_sum], axis=1).rename(columns={'value': 'plastics'})
finished_goods = pd.concat([finished_goods, paper_sum], axis=1).rename(columns={'value': 'paper'})
finished_goods = pd.concat([finished_goods, tuffa_sum], axis=1).rename(columns={'value': 'tuffa'})

# plot
ax = finished_goods.plot(kind='bar', stacked=True, title='Factory Finished Goods Output', xlabel='Months', ylabel='Units')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/all_factories_output_quantity.png')
plt.show()
# there is double count going on with oil, which overstates the amount of oil for transaction type 0.

# Chemical Factory Raw Materials
chemical_raw_materials = summarise_stock(stock, 1, 48, '50', 'quantity', np.sum)
# plot
ax = chemical_raw_materials.plot(kind='area', xlabel='Month', ylabel='Units',
                                 title='Chemical Factory Raw Materials Consumed')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/chemical_factory_raw_materials_consumed.png')
plt.show()

# chemical factory finished goods
chemical_factory_finished_goods = summarise_stock(stock, 0, 48, '50', 'quantity', np.sum)
# plot
ax = chemical_factory_finished_goods.plot(kind='area', xlabel='Month', ylabel='Quantity',
                                          title='Chemical Factory Finished Goods Output')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/chemical_factory_finished_goods_output.png')
plt.show()
# todo: invert

# chemical factory recoveries
chemical_factory_recoveries = chemical_factory_finished_goods + chemical_raw_materials
# plot
ax = chemical_factory_recoveries.plot(kind='area', xlabel='Month', ylabel='Kina',
                                      title='Chemical Factory Recoveries')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/chemical_factory_recoveries.png')
plt.show()

# oil factory finished goods
oil_finished_goods = summarise_stock(stock, 0, 40, '55', 'quantity', np.sum)
# plot
ax = oil_finished_goods.plot(kind='area', title='Oil Factory Finished Goods Output (volume)',
                             xlabel='Months', ylabel='Packs')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/oil_factory_finished_goods_output.png')
plt.show()

# there is a problem with oil. Its showing both receipts and production finished goods, because both are transaction
# type 1. need to filter them out by transaction source

#################################################################################################################

# global palm oil price
rbd_palm_olein_fob_malaysia = pd.read_csv('data/RBD palm olein FOB Malaysia.CSV')
ax = rbd_palm_olein_fob_malaysia.plot(kind='line', title='RBD Palm Olein FOB Malaysia', x='date', y='price',
                                      xlabel='Date', ylabel='US$ per Ton')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.tight_layout()
plt.savefig('plots/palm_oil_price.png')
plt.show()

# price from NBPOL
nbpol_oil = stock[stock['transaction_type'] == 0]
nbpol_oil = nbpol_oil[nbpol_oil['warehouse'] == 40]
nbpol_oil = nbpol_oil[nbpol_oil['cc'] == '55']
nbpol_oil = nbpol_oil[nbpol_oil['transaction_sources'] == '0']
nbpol_oil_price = nbpol_oil.pivot_table(index='month/year', values='unit_cost', aggfunc=np.mean)
# plot
ax = nbpol_oil_price.plot(kind='line', title='Oil Price', rot=90, xlabel='Months', ylabel='Kina per kg')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/NBPOL_oil_price.png')
plt.show()

# quantity delivered by NBPOL
nbpol_oil_quantity = nbpol_oil.pivot_table(index='month/year', values='quantity', aggfunc=np.sum)
ax = nbpol_oil_quantity.plot(kind='bar', title='Oil Quantity Received by month', rot=90, xlabel='Months', ylabel='Kilograms')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/NBPOL_oil_quantity.png')
plt.show()
###################################################################################################################
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

retail_column_names = ['ACACON', 'ACACOP', 'ACMCCR', 'ACTDHR', 'ACTDLP', 'AIXFRU']
# lae retail sales
lae_retail_sales_revenue = summarise_sales(sales_statistics, '14', 'sales_revenue')
# aggregate the small stuff
lae_retail_sales_revenue['OTHER'] = lae_retail_sales_revenue[retail_column_names].sum(axis=1)
# drop erroneous data
lae_retail_sales_revenue = lae_retail_sales_revenue.drop(['ACBBOT', 'ACHCLE', 'ACKCOM', 'ACMMAN', 'ACRSUN', 'RENTOF',
                                                          'ACSCON', 'ACUOIL', 'AIJSAF', 'AIPROT', 'AIXAAB', 'RAWMAT',
                                                          'ACACON', 'ACACOP', 'ACMCCR', 'ACTDHR', 'ACTDLP', 'AIXFRU'],
                                                         axis=1)
# plot
ax = lae_retail_sales_revenue.plot(kind='bar', stacked=True, title='Lae Retail Sales Revenue', xlabel='Months',
                                   ylabel='Kina')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/Lae Retail Sales Revenue.png')
plt.show()

lae_retail_sales_volume = summarise_sales(sales_statistics, '14', 'quantity')
lae_retail_sales_volume['OTHER'] = lae_retail_sales_volume[retail_column_names].sum(axis=1)
lae_retail_sales_volume = lae_retail_sales_volume.drop(['ACBBOT', 'ACHCLE', 'ACKCOM', 'ACMMAN', 'ACRSUN', 'RENTOF',
                                                        'ACSCON', 'ACUOIL', 'AIJSAF', 'AIPROT', 'AIXAAB', 'RAWMAT',
                                                        'ACACON', 'ACACOP', 'ACMCCR', 'ACTDHR', 'ACTDLP', 'AIXFRU'],
                                                       axis=1)  # drop erroneous data
# plot
ax = lae_retail_sales_volume.plot(kind='box', title='Lae Retail Sales Volume', xlabel='Months',
                                  ylabel='Kina')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/lae_retail_sales_volume.png')
plt.show()

lae_retail_sales_trading_profit = summarise_sales(sales_statistics, '14', 'trading_profit')
# aggregate the small stuff
lae_retail_sales_trading_profit['OTHER'] = lae_retail_sales_trading_profit[retail_column_names].sum(axis=1)
# drop erroneous data
lae_retail_sales_trading_profit = lae_retail_sales_trading_profit.drop(['ACBBOT', 'ACHCLE', 'ACKCOM', 'ACMMAN',
                                                                        'ACRSUN', 'RENTOF', 'ACSCON', 'ACUOIL',
                                                                        'AIJSAF', 'AIPROT', 'AIXAAB', 'RAWMAT',
                                                                        'ACACON', 'ACACOP', 'ACMCCR', 'ACTDHR',
                                                                        'ACTDLP', 'AIXFRU'], axis=1)
# plot
ax = lae_retail_sales_trading_profit.plot(kind='bar', stacked=True, title='Lae Retail Trading Profit',
                                          xlabel='Months', ylabel='Kina')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/lae_retail_trading_profit.png')
plt.show()

lae_retail_sales_trading_margin = summarise_sales(sales_statistics, '14', 'trading_margin')
# aggregate the small stuff
lae_retail_sales_trading_margin['OTHER'] = lae_retail_sales_trading_margin[retail_column_names].sum(axis=1)
# drop erroneous data
lae_retail_sales_trading_margin = lae_retail_sales_trading_margin.drop(['ACBBOT', 'ACHCLE', 'ACKCOM', 'ACMMAN',
                                                                        'ACRSUN', 'RENTOF', 'ACSCON', 'ACUOIL',
                                                                        'AIJSAF', 'AIPROT', 'AIXAAB', 'RAWMAT',
                                                                        'ACACON', 'ACACOP', 'ACMCCR', 'ACTDHR',
                                                                        'ACTDLP', 'AIXFRU'], axis=1)
# plot
ax = lae_retail_sales_trading_margin.plot(kind='bar', stacked=False, title='Lae Retail Trading Margin',
                                          xlabel='Months', ylabel='Kina')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/lae_retail_trading_margin.png')
plt.show()

# lae commercial trading profit
lae_commercial_trading_profit = summarise_sales(sales_statistics, '11', 'trading_profit')
# drop erroneous columns
lae_commercial_trading_profit = lae_commercial_trading_profit.drop(['ACTDAZ', 'ACJDOM', 'ACTDHR', 'ACTDLP', 'RAWMAT',
                                                                    'ACMCCR', 'AIXFRU', 'ACMPES', 'ACSONN', 'AICSPA',
                                                                    'AIOSEH'], axis=1)
# plot
ax = lae_commercial_trading_profit.plot(kind='bar', stacked=True, title='Lae Commercial Trading Profit',
                                        xlabel='Months', ylabel='Kina')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/Lae Commercial Trading Profit 1.png')
plt.show()

# todo: need to find a way to aggregate multiple cost centres into commercial: process chemicals(22 & 44), plastics

retail_column_names = ['ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACLCAT', 'ACRSUN', 'ACSALU', 'ACSCAU', 'ACSENV',
                       'ACSHYD', 'ACSOOO', 'AIJSAF', 'AIPROT']

lae_commercial_trading_profit['OTHER'] = lae_commercial_trading_profit[retail_column_names].sum(axis=1)

# now that their values have been aggregated into 'OTHER', drop the unneeded columns
lae_commercial_trading_profit = lae_commercial_trading_profit.drop(retail_column_names, axis=1)

ax = lae_commercial_trading_profit.plot(kind='bar', stacked=True, title='Lae Commercial Trading Profit',
                                        xlabel='Months', ylabel='Kina')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/Lae Commercial Trading Profit 2.png')
plt.show()

# Sales Volumes of Key Product Categories: GNS cooking oil, dazzle bleach, tuffa tanks

# Lae Oil Sales Quantity
lae_oil_sales_quantity = summarise_sales(sales_statistics, '19', 'quantity')
# drop erroneous columns
lae_oil_sales_quantity = lae_oil_sales_quantity.drop(['ACBBOT', 'ACBBOT', 'ACMMAN', 'ACRSUN',
                                                      'ACTDAZ', 'AIPROT', 'AIXFRU'], axis=1)
# plot
ax = lae_oil_sales_quantity.plot(kind='bar', stacked=True, title='Lae Oil Sales Quantity', xlabel='Months',
                                 ylabel='Quantity (Units)')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/Lae Oil Sales Quantity.png')
plt.show()

# Lae Tuffa Sales Quantity
tuffa_sales_quantity = summarise_sales(sales_statistics, '29', 'quantity')
# drop erroneous data
tuffa_sales_quantity = tuffa_sales_quantity.drop(['ACBBOT', 'ACJDOM', 'ACTDAZ', 'ACTDHR',
                                                  'ACTDLP', 'AIXFRU', 'RAWMAT'], axis=1)

ax = tuffa_sales_quantity.plot(kind='bar', stacked=True, title='Lae Tuffa Sales Quantity', xlabel='Months',
                               ylabel='Quantity (Units)')
# set the y ticks to display correctly
ax.get_yaxis().set_major_formatter(ticker.StrMethodFormatter('{x:,.0f}'))
plt.savefig('plots/Lae Tuffa Sales Quantity.png')
plt.show()

# sales_statistics.groupby('order_number')
# oil_sales = summarise_sales(sales_statistics, '19', '')
sns.boxplot(x='month/year', y='sales_revenue', data=sales_statistics)
plt.show()
