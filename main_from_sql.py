"""
generate full P&Ls for 2020 and 2021 from sql query
"""

from cost_center_querier import *
from analyzer import *

path = 'other_output/'
analyzer = ProfitLossAnalyzer()
q = CostCenterQuerier()
writer = pd.ExcelWriter('cc99.xlsx', engine='xlsxwriter')
connection = q.engine

month_cols_20 = analyzer.build_monthly_columns_for_year(2020)
month_cols_21 = analyzer.build_monthly_columns_for_year(2021)
MONTH_COLS = month_cols_20 + month_cols_21

if __name__ == '__main__':
    revenue = pd.read_sql_query(sql=sql_revenue, con=connection)
    revenue = analyzer.wrangling(df=revenue, g1='year', g2='alt_product_group')
    revenue = analyzer.clean_df1(df=revenue, m_list=MONTH_COLS, ch_0='accounting_code', cv_0='300000', ch_1='cc',
                                 cv_1=cc, ch_2='category', cv_2='sales', list_1=APG_DESCRIPTIONS, ch_3='description',
                                 index='Total Revenue')

    apg_list = revenue['alt_product_group']
    description_list = revenue['description']

    cogs = pd.read_sql_query(sql=sql_cogs, con=connection)
    cogs = analyzer.wrangling(df=cogs, g1='year', g2='alt_product_group')
    cogs = analyzer.clean_df1(df=cogs, m_list=MONTH_COLS, ch_0='accounting_code', cv_0='400000', ch_1='cc', cv_1=cc,
                              ch_2='category', cv_2='cost of goods', list_1=APG_DESCRIPTIONS, ch_3='description',
                              index='Total COGS')

    # calculate trading profit
    trading_profit = analyzer.trading_profit_calc(cols=MONTH_COLS, df1=revenue, df2=cogs, cc='99', category=CATEGORY5,
                                                  list1=description_list, list2=apg_list)
    trading_profit = analyzer.clean_df2(df=trading_profit, list_2=MONTH_COLS)

    # calculate trading margin
    trading_margin = analyzer.trading_margin_calc(df1=trading_profit, df2=revenue, cols=MONTH_COLS, cc=cc,
                                                  category=CATEGORY6, list1=description_list, list2=apg_list)
    trading_margin = analyzer.clean_df2(df=trading_margin, list_2=MONTH_COLS)

    # read the manufacturing variances from sql
    manu_vars = pd.read_sql_query(sql=sql_manufacturing_variances, con=connection)  # execute the query
    manu_vars = analyzer.wrangling(df=manu_vars, g1='year', g2='accounting_code')  # wrangle the data
    manu_vars = analyzer.clean_df3(df=manu_vars, m_list=MONTH_COLS, ch_1='cc', cv_1=cc, ch_2='category',
                                   cv_2='manufacturing variances', list_3=MANUFACTURING_VARIANCES_DICT,
                                   ch_3='description', ch_4='alt_product_group', cv_4=np.nan,
                                   index='Total Manufacturing Variances')  # clean the data

    # read the stock variances from sql, wrangle and clean the data
    stk_var = pd.read_sql_query(sql=sql_stock_variances, con=connection)  # query
    stk_var = analyzer.wrangling(df=stk_var, g1='year', g2='accounting_code')  # wrangle
    stk_var = analyzer.clean_df3(df=stk_var, m_list=MONTH_COLS, ch_1='cc', cv_1=cc, ch_2='category',
                                 cv_2='stock variances', list_3=STOCK_VARIANCES_DICT, ch_3='description',
                                 ch_4='alt_product_group', cv_4=np.nan, index='Total Stock Variances')  # clean

    # read the direct costs from sql, wrangle and clean the data
    direct_costs = pd.read_sql_query(sql=sql_direct_costs, con=connection)
    direct_costs = analyzer.wrangling(df=direct_costs, g1='year', g2='alt_product_group')
    direct_costs = analyzer.clean_df1(df=direct_costs, m_list=MONTH_COLS, ch_0='accounting_code', cv_0='400000',
                                      ch_1='cc', cv_1=cc, ch_2='category', cv_2='direct_costs',
                                      list_1=DIRECT_COSTS_DICT, ch_3='description', index='Total Direct Costs')

    gross_profit = trading_profit.loc['Total Trading Profit'] + manu_vars.loc['Total Manufacturing Variances'] + \
                   stk_var.loc['Total Stock Variances'] + direct_costs.loc['Total Direct Costs']
    direct_costs.loc['Gross Profit', MONTH_COLS] = gross_profit  # calc & append gP
    # fix_me: gross_profit_margin = gross profit / revenue

    overheads = pd.read_sql_query(sql=sql_overheads, con=connection)  # read,
    overheads = analyzer.wrangling(df=overheads, g1='year', g2='accounting_code')  # wrangle
    overheads = analyzer.clean_df3(df=overheads, m_list=MONTH_COLS, ch_1='cc', cv_1=cc, ch_2='category',
                                   cv_2='overheads', ch_3='description', list_3=OVERHEADS_DICT,
                                   ch_4='alt_product_group', cv_4=np.nan, index='Total Overheads')  # clean

    operating_profit = direct_costs.loc['Gross Profit'].subtract(overheads.loc['Total Overheads'])
    # fix_me: operating_profit_margin = overheads / revenue

    other_income = pd.read_sql_query(sql=sql_other_income, con=connection)
    other_income = analyzer.wrangling(df=other_income, g1='year', g2='accounting_code')
    other_income = analyzer.clean_df3(df=other_income, m_list=MONTH_COLS, ch_1='cc', cv_1=cc, ch_2='category',
                                      cv_2='Other Income', list_3=OTHER_INCOME_DICT, ch_3='description',
                                      ch_4='alt_product_group', cv_4=np.nan, index='Total Other Income')

    other_expenses = pd.read_sql_query(sql=sql_other_expenses, con=connection)
    other_expenses = analyzer.wrangling(df=other_expenses, g1='year', g2='accounting_code')
    other_expenses = analyzer.clean_df3(df=other_expenses, m_list=MONTH_COLS, ch_1='cc', cv_1=cc, ch_2='category',
                                        cv_2='other_income', list_3=OTHER_EXPENSES_DICT, ch_3='description',
                                        ch_4='alt_product_group', cv_4=np.nan, index='Total Other Expenses')

    df_list = [revenue, cogs, trading_profit, trading_margin, stk_var, manu_vars, direct_costs, overheads, other_income,
               other_expenses]
    consolidated = analyzer.concatenate_df(df_list)

    # net profit = gross profit + overheads
    analyzer.net_profit_calc(consolidated)
    # fix_me: net profit margin

    # export as xlsx, each cc P&L on a separate sheet
    consolidated.to_excel(writer, sheet_name=f'cc{cc} P&L')
    consolidated.to_excel(writer, sheet_name=f'cc{cc} P&L')
    writer.save()
    print('process complete')
