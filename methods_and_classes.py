"""

"""
import numpy as np


def summarise_stock(df, transaction_type, warehouse, cc, values, agg_function):
    df = df[df['transaction_type'] == transaction_type]
    df = df[df['warehouse'] == warehouse]
    df = df[df['cc'] == cc]
    df = df.pivot_table(index='month/year', values=values, aggfunc=agg_function)
    return df


def summarise_sales(df, cost_center_id, values):
    df = df[df['cc'] == cost_center_id].copy()
    summary = df.pivot_table(index='month/year', columns='alternate_product_group', values=values, aggfunc=np.sum)
    return summary
