"""
written by: noOne
on: 29th August 21
"""
import pandas as pd

month_dict_20 = {'BOOKED-01': 'january_20', 'BOOKED-02': 'february_20', 'BOOKED-03': 'march_20',
                 'BOOKED-04': 'april_20', 'BOOKED-05': 'may_20', 'BOOKED-06': 'june_20', 'BOOKED-07': 'july_20',
                 'BOOKED-08': 'august_20', 'BOOKED-09': 'september_20', 'BOOKED-10': 'october_20',
                 'BOOKED-11': 'november_20', 'BOOKED-12': 'december_20'}

month_dict_21 = {'BOOKED-01': 'january_21', 'BOOKED-02': 'february_21', 'BOOKED-03': 'march_21',
                 'BOOKED-04': 'april_21', 'BOOKED-05': 'may_21', 'BOOKED-06': 'june_21', 'BOOKED-07': 'july_21'}


company_20 = pd.read_csv('data/Company PL2020.csv')
company_21 = pd.read_csv('data/Jul21 Co P&L.csv')

# clean data

# dropna()
company_20 = company_20.dropna(axis=0)
company_21 = company_21.dropna(axis=0)

# reset index

# rename months
company_20 = company_20.replace(month_dict_20)
company_21 = company_21.replace(month_dict_21)

# set column headers to months
# merge dataframes to make a multi year file
company = pd.concat([company_20, company_21], axis=1)

# TODO: this doesn't really give the desired output

# insert new rows with aggregations: sum, TP, trading margin, GP, gross margin, NP,
#   total revenue (K)
#   total cogs (K)
#   trading profit(K)
#   trading margin (%)
#   total manufacturing variances (K)
#   total stock variances (K)
#   total direct costs (K)
#   total overheads (K)
#   operating profit (K)
#   other expenses (K)
#   other income (K)
#   net profit

# reset column headers

# export to excel file

company = company.to_excel('the_penguin.xlsx', sheet_name='company', float_format='%.2f', header=True, index=False)

