"""

"""

# # for cc in cc_list:
# revenue = pd.read_sql_query(sql=sql_revenue, con=q.engine)

# WK: df.melt()
# pd.options.display.max_columns = 50
# pd.options.display.width = 500

# new_df = revenue.melt(
#     id_vars=['accounting_code', '99', CATEGORY, 'description', ALT_PRODUCT_GROUP, 'year'],
#     value_vars=MONTHS
# ).rename(columns={'variable': 'month', })

# # build unique indices to cover all your categories, descriptions and groups
# multi_index_cols = ['accounting_code', cc, CATEGORY, 'description', ALT_PRODUCT_GROUP]
# indices = new_df.set_index(
#     multi_index_cols
# ).index.drop_duplicates()

# # multi indexed df: this is basically what you need already:
# result = new_df.pivot_table(
#     index=multi_index_cols, columns=['year', 'month'], values='value', aggfunc=np.sum
# )

# # further tidy up the column indices:
# new_cols = pd.to_datetime(list(map(lambda x: str(x[0]) + '-' + str(x[1]), result.columns.to_flat_index())))
# result.columns = new_cols
# result = result.sort_index(axis=1)
# formatted_cols = list(map(lambda x: x.strftime('%B-%y'), result.columns))
# result.columns = formatted_cols
# revenue = result.reset_index()

# question-answered: i tried the melt method. i confess i like mine better. can we discuss? also a bunch of other
#  pandas methods of interest. this isn't specifically related to the current project

# todo:
#  0) review queries to confirm that the values are correct
#  1) for loop to iterate through 7 x queries to df for each cc in list, concatenate the 7x df's to one df per cc
#  2)export to xlsx. compare result to P&Ls generated from report writer
#  3) generate base case performance prediction (linear regression)
#  4) functions to modify predicted performance @ low level, based on planned actions
#  show changes in company level performance. this requires a bit of thinking about how to make this work
