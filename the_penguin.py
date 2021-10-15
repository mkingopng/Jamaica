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
# TODO: the result isn't exactly what i want

# merge dataframes to make a multi year file
company = company_20.append(company_21)
# todo: 
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
# hire_20 = hire_20.to_excel('the_penguin.xlsx', sheet_name='hire_20', float_format='%.2f', header=True, index=False)
# retail_20 = retail_20.to_excel('the_penguin.xlsx', sheet_name='retail_20', float_format='%.2f', header=True, index=False)
# retail_21 = retail_21.to_excel('the_penguin.xlsx', sheet_name='retail_21', float_format='%.2f', header=True, index=False)
# oil_20 = oil_20.to_excel('the_penguin.xlsx', sheet_name='oil_20', float_format='%.2f', header=True, index=False)
# oil_21 = oil_21.to_excel('the_penguin.xlsx', sheet_name='oil_21', float_format='%.2f', header=True, index=False)
# commercial_20 = commercial_20.to_excel('the_penguin.xlsx', sheet_name='commercial_20', float_format='%.2f', header=True, index=False)
# commercial_21 = commercial_21.to_excel('the_penguin.xlsx', sheet_name='commercial_21', float_format='%.2f', header=True, index=False)
# plastics_sales_20 = plastics_sales_20.to_excel('the_penguin.xlsx', sheet_name='plastics_sales_20', float_format='%.2f', header=True, index=False)
# process_20 = process_20.to_excel('the_penguin.xlsx', sheet_name='tuffa_21', float_format='%.2f', header=True, index=False)
# tuffa_20 = tuffa_20.to_excel('the_penguin.xlsx', sheet_name='hire', float_format='%.2f', header=True, index=False)
# tuffa_21 = tuffa_21.to_excel('the_penguin.xlsx', sheet_name='hire', float_format='%.2f', header=True, index=False)
# manufacturing_20 = manufacturing_20.to_excel('the_penguin.xlsx', sheet_name='manufacturing_20', float_format='%.2f', header=True, index=False)
# manufacturing_21 = manufacturing_21.to_excel('the_penguin.xlsx', sheet_name='manufacturing_21', float_format='%.2f', header=True, index=False)
# supply_chain_20 = supply_chain_20.to_excel('the_penguin.xlsx', sheet_name='supply_chain_20', float_format='%.2f', header=True, index=False)
# supply_chain_21 = supply_chain_21.to_excel('the_penguin.xlsx', sheet_name='supply_chain_21', float_format='%.2f', header=True, index=False)
# marketing_20 = marketing_20.to_excel('the_penguin.xlsx', sheet_name='marketing_20', float_format='%.2f', header=True, index=False)
# marketing_21 = marketing_21.to_excel('the_penguin.xlsx', sheet_name='marketing_21', float_format='%.2f', header=True, index=False)
# quality_safety_20 = quality_safety_20.to_excel('the_penguin.xlsx', sheet_name='quality_safety_20', float_format='%.2f', header=True, index=False)
# quality_safety_21 = quality_safety_21.to_excel('the_penguin.xlsx', sheet_name='quality_safety_21', float_format='%.2f', header=True, index=False)
# engineering_20 = engineering_20.to_excel('the_penguin.xlsx', sheet_name='engineering_20', float_format='%.2f', header=True, index=False)
# engineering_21 = engineering_21.to_excel('the_penguin.xlsx', sheet_name='engineering_21', float_format='%.2f', header=True, index=False)
# corporate_20 = corporate_20.to_excel('the_penguin.xlsx', sheet_name='corporate_20', float_format='%.2f', header=True, index=False)
# corporate_21 = corporate_21.to_excel('the_penguin.xlsx', sheet_name='corporate_21', float_format='%.2f', header=True, index=False)
# company_20 = company_20.to_excel('the_penguin.xlsx', sheet_name='company_20', float_format='%.2f', header=True, index=False)
company_21 = company_21.to_excel('the_penguin.xlsx', sheet_name='company_21', float_format='%.2f', header=True, index=False)

# if __name__ == '__main__':
