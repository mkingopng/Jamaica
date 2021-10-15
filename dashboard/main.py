"""
written by: noOne
date:
last updated: 29th august 2021

"""

import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output
import plotly.graph_objs as go
import pandas as pd

# fix_me: something has changed. not running correctly anymore.

dtypes = {'INVOICE_NUMBER': str, 'QTY_INVOICED': float, 'UNIT_NET_PRICE': float, 'SALES_ORDER_LINE_NUMBER': int,
          'SALES_VALUE': float, 'INVOICE_DATE': str, 'FULLY_SHIPPED?': bool, 'WEEK_ID': int, 'YEAR_ID': int,
          'ALT_ALT_PRODUCT_GROUP': str, 'STOCK_CODE': str, 'PRODUCT_DESCRIPTION': str, 'SALES_PERSON': str, 'CC': int,
          'TEAM': str, 'CUSTOMER_CODE': str, 'CUSTOMER_NAME': str, 'CUSTOMER_PHONE': str, 'CUSTOMER_ADDRESS_1': str,
          'CUSTOMER_ADDRESS_2': str, 'CITY': str, 'PROVINCE': str}

parse_dates = ['STOCK_CODE']

sales_1 = pd.read_csv("/home/michaelkingston/Documents/GitHub/Jamaica/data/test_query.csv", encoding='utf-8', sep=',',
                      dtype=dtypes, parse_dates=parse_dates, error_bad_lines=False, index_col=False)

app = dash.Dash(__name__, )
app.layout = html.Div([

    html.Div([
        html.Br(), html.Br(),
        html.H1('KK Kingston Sales Dashboard')],
        style={'margin-left': '5%', 'color': '#808000', 'width': '50%', 'display': 'inline-block'
               }),

    html.Div([
        html.Br(), html.Br(),
        html.H4('Created by: noOne')],
        style={'color': '#17202A', 'width': '30%', 'display': 'inline-block', 'float': 'right'
               }),
    # this is the key filter
    html.Div([
        html.Label('Select a Team:'),
        dcc.Dropdown(id='w_teams',
                     multi=False,
                     clearable=True,
                     value='',
                     placeholder='Select a Team',
                     options=[{'label': c, 'value': c}
                              for c in (sales_1['TEAM'].unique())])

    ], style={'width': '20%', 'margin-left': '45%'}),

    # TODO: charts L1, R1, L2 are quite similar. They all related to sales qty, sales value,
    #  and by extension price per UOM and cost per UOM. I think this could be reduced to 1 chart and be more
    #  informative. Y1 is always some variant of qty. Y2 is always some variant of sales value.
    #  X is more constant. It is always alt product group (APG) I like R1 the best.

    # Chart L1: Create combination of bar chart and line chart (Compare quantity ordered to each Price of product)
    html.Div([
        html.Br(),
        dcc.Graph(id='bar_line_1', config={'displayModeBar': False}),

    ], style={'margin-left': '1.4%', 'width': '50%', 'display': 'inline-block'}),

    # Chart R1: Create combination of bar chart and line chart (Compare sales to each Price of product)
    html.Div([
        html.Br(),
        dcc.Graph(id='bar_line_2', config={'displayModeBar': False}),
    ], style={'width': '48.6%', 'display': 'inline-block', 'float': 'right'}),

    # Chart L2: Create group bar chart (Compare sales and quantity ordered for each product)
    html.Div([
        html.Br(),
        dcc.Graph(id='bar_bar_3', config={'displayModeBar': False}),
    ], style={'margin-left': '1.4%', 'width': '50%', 'display': 'inline-block'}),

    # Chart R2: Create combination of bar chart and line chart (Compare each year sales and q. ordered for each product)
    html.Div([
        html.Br(),
        dcc.Graph(id='bar_line_4', config={'displayModeBar': False}),
    ], style={'width': '48.6%', 'display': 'inline-block', 'float': 'right'}),

    # Chart L3: Create line chart (each month sales)
    html.Div([
        html.Br(),
        dcc.Graph(id='line_line_5', config={'displayModeBar': False}),
    ], style={'margin-left': '1.4%', 'width': '50%', 'display': 'inline-block', 'margin-bottom': '3%'}),

    # Chart R3: Create scatter chart (Compare sales and q. ordered)
    html.Div([
        html.Br(),
        dcc.Graph(id='scatter_6', config={'displayModeBar': False}),

    ], style={'width': '48.6%', 'display': 'inline-block', 'float': 'right', 'margin-bottom': '3%'}),

], style={'background-color': '#e6e6e6'})


# Chart L1: Create combination of bar chart and line chart (Compare quantity ordered to each Price of product)
@app.callback(Output('bar_line_1', 'figure'),
              [Input('w_teams', 'value')])
def update_graph(w_teams):
    product_sales1 = sales_1.groupby(['ALT_PRODUCT_GROUP', 'TEAM'])['QTY_INVOICED'].sum().reset_index()
    product_sales2 = sales_1.groupby(['ALT_PRODUCT_GROUP', 'TEAM'])['UNIT_NET_PRICE'].mean().reset_index()

    return {
        'dec_20': [go.Bar(x=product_sales1[product_sales1['TEAM'] == w_teams]['ALT_PRODUCT_GROUP'],
                          y=product_sales1[product_sales1['TEAM'] == w_teams]['QTY_INVOICED'],
                          text=product_sales1[product_sales1['TEAM'] == w_teams]['QTY_INVOICED'],
                          name='∑ Qty Sold',
                          texttemplate='%{text:.2s}',
                          textposition='auto',
                          marker=dict(
                              color=product_sales1[product_sales1['TEAM'] == w_teams]['QTY_INVOICED'],
                              colorscale='phase',
                              showscale=False),
                          yaxis='y1',

                          hoverinfo='text',
                          hovertext='<b>Team</b>: ' + product_sales1[product_sales1['TEAM'] == w_teams][
                              'TEAM'].astype(str) + '<br>' +
                                    '<b>∑ Qty Sold</b>: ' + [f'{x:,.0f}' for x in
                                                             product_sales1[product_sales1['TEAM'] == w_teams][
                                                                 'QTY_INVOICED']] + '<br>' +
                                    '<b>APG</b>: ' + product_sales1[product_sales1['TEAM'] == w_teams][
                                        'ALT_PRODUCT_GROUP'].astype(str) + '<br> '
                          ),

                   go.Scatter(
                       x=product_sales2[product_sales2['TEAM'] == w_teams]['ALT_PRODUCT_GROUP'],
                       y=product_sales2[product_sales2['TEAM'] == w_teams]['UNIT_NET_PRICE'],
                       name='μ Price',
                       text=product_sales2[product_sales2['TEAM'] == w_teams]['UNIT_NET_PRICE'],
                       mode='markers + lines',
                       marker=dict(color='#bd3786'),
                       yaxis='y2',
                       hoverinfo='text',
                       hovertext='<b>Team</b>: ' + product_sales2[product_sales2['TEAM'] == w_teams][
                           'TEAM'].astype(str) + '<br>' +
                                 '<b>Price</b>: $' + [f'{x:,.0f}' for x in
                                                      product_sales2[product_sales2['TEAM'] == w_teams][
                                                          'UNIT_NET_PRICE']] + '<br>' +
                                 '<b>APG</b>: ' + product_sales2[product_sales2['TEAM'] == w_teams][
                                     'ALT_PRODUCT_GROUP'].astype(str) + '<br>'
                   )],

        'layout': go.Layout(
            width=780,
            height=520,
            title={
                'text': '∑ Qty Sold & Price: ' + w_teams,
                'y': 0.93,
                'x': 0.43,
                'xanchor': 'center',
                'yanchor': 'top'},
            titlefont={'family': 'Oswald',
                       'color': 'rgb(230, 34, 144)',
                       'size': 25},

            hovermode='x',

            xaxis=dict(title='<b>APG</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2,
                       ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis=dict(title='<b>∑ Qty Sold</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2,
                       ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis2=dict(title='<b>Price (K)</b>',
                        overlaying='y',
                        side='right',
                        color='rgb(230, 34, 144)',
                        showline=True,
                        showgrid=False,
                        showticklabels=True,
                        linecolor='rgb(104, 204, 104)',
                        linewidth=2,
                        ticks='outside',
                        tickfont=dict(
                            family='Arial',
                            size=12,
                            color='rgb(17, 37, 239)'
                        )
                        ),

            legend=dict(title='',
                        x=0.25,
                        y=1.08,
                        orientation='h',
                        bgcolor='rgba(255, 255, 255, 0)',
                        traceorder="normal",
                        font=dict(
                            family="sans-serif",
                            size=12,
                            color='#000000'
                        )
                        ),
            legend_title_font_color="green",
            uniformtext_minsize=12,
            uniformtext_mode='hide',
        )
    }


# TODO: this is my preferred hart for sales revenue and sales qty
# Chart R1: Create combination of bar chart and line chart (Compare sales to each Price of product)
@app.callback(Output('bar_line_2', 'figure'),
              [Input('w_teams', 'value')])
def update_graph(w_teams):
    product_sales3 = sales_1.groupby(['ALT_PRODUCT_GROUP', 'TEAM'])['SALES_VALUE'].sum().reset_index()
    product_sales4 = sales_1.groupby(['ALT_PRODUCT_GROUP', 'TEAM'])['UNIT_NET_PRICE'].mean().reset_index()

    return {
        'dec_20': [go.Bar(x=product_sales3[product_sales3['TEAM'] == w_teams]['ALT_PRODUCT_GROUP'],
                          y=product_sales3[product_sales3['TEAM'] == w_teams]['SALES_VALUE'],
                          text=product_sales3[product_sales3['TEAM'] == w_teams]['SALES_VALUE'],
                          name='∑ Sales',
                          texttemplate='%{text:.2s}',
                          textposition='auto',
                          marker=dict(
                              color=product_sales3[product_sales3['TEAM'] == w_teams]
                              ['SALES_VALUE'],
                              colorscale='portland',
                              showscale=False),
                          yaxis='y1',

                          hoverinfo='text',
                          hovertext='<b>Team</b>: ' + product_sales3[product_sales3['TEAM'] == w_teams][
                              'TEAM'].astype(str) + '<br>' +
                                    '<b>Sales</b>: $' + [f'{x:,.0f}' for x in
                                                         product_sales3[product_sales3['TEAM'] == w_teams][
                                                             'SALES_VALUE']] + '<br>' +
                                    '<b>APG</b>: ' + product_sales3[product_sales3['TEAM'] == w_teams][
                                        'ALT_PRODUCT_GROUP'].astype(str) + '<br>'
                          ),

                   go.Scatter(
                       x=product_sales4[product_sales4['TEAM'] == w_teams]['ALT_PRODUCT_GROUP'],
                       y=product_sales4[product_sales4['TEAM'] == w_teams]['UNIT_NET_PRICE'],
                       name='μ Price (K)',
                       text=product_sales4[product_sales4['TEAM'] == w_teams]['UNIT_NET_PRICE'],
                       mode='markers + lines',
                       marker=dict(color='#bd3786'),
                       yaxis='y2',
                       hoverinfo='text',
                       hovertext='<b>Team</b>: ' + product_sales4[product_sales4['TEAM'] == w_teams][
                           'TEAM'].astype(str) + '<br>' +
                                 '<b>APG</b>: ' + product_sales4[product_sales4['TEAM'] == w_teams][
                                     'ALT_PRODUCT_GROUP'].astype(str) + '<br>' +
                                 '<b>Price</b>: $' + [f'{x:,.0f}' for x in
                                                      product_sales4[product_sales4['TEAM'] == w_teams][
                                                          'UNIT_NET_PRICE']] + '<br>'
                   )],

        'layout': go.Layout(
            width=780,
            height=520,
            title={
                'text': '∑ Sales & μ Price p/uom: ' + w_teams,
                'y': 0.93,
                'x': 0.43,
                'xanchor': 'center',
                'yanchor': 'top'},
            titlefont={'family': 'Oswald',
                       'color': 'rgb(230, 34, 144)',
                       'size': 25},

            hovermode='x',

            xaxis=dict(title='<b>APG</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2,
                       ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis=dict(title='<b>∑ Sales</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2,
                       ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis2=dict(title='<b>μ Price of Ea. uom (K)</b>',
                        overlaying='y',
                        side='right',
                        color='rgb(230, 34, 144)',
                        showline=True,
                        showgrid=False,
                        showticklabels=True,
                        linecolor='rgb(104, 204, 104)',
                        linewidth=2,
                        ticks='outside',
                        tickfont=dict(
                            family='Arial',
                            size=12,
                            color='rgb(17, 37, 239)'
                        )
                        ),

            legend=dict(title='',
                        x=0.25,
                        y=1.08,
                        orientation='h',
                        bgcolor='rgba(255, 255, 255, 0)',
                        traceorder="normal",
                        font=dict(
                            family="sans-serif",
                            size=12,
                            color='#000000')),

            legend_title_font_color="green",
            uniformtext_minsize=12,
            uniformtext_mode='hide',
        )
    }


# Chart L2: Create group bar chart (Compare sales and quantity ordered for each product)
@app.callback(Output('bar_bar_3', 'figure'),
              [Input('w_teams', 'value')])
def update_graph(w_teams):
    product_sales5 = sales_1.groupby(['ALT_PRODUCT_GROUP', 'TEAM'])['SALES_VALUE'].sum().reset_index()
    product_sales6 = sales_1.groupby(['ALT_PRODUCT_GROUP', 'TEAM'])['QTY_INVOICED'].sum().reset_index()

    return {
        'dec_20': [go.Bar(x=product_sales5[product_sales5['TEAM'] == w_teams]['ALT_PRODUCT_GROUP'],
                          y=product_sales5[product_sales5['TEAM'] == w_teams]['SALES_VALUE'],
                          text=product_sales5[product_sales5['TEAM'] == w_teams]['SALES_VALUE'],
                          name='∑ Sales',
                          texttemplate='%{text:.2s}',
                          textposition='auto',
                          marker=dict(color='rgb(214, 137, 16)'),
                          yaxis='y1',
                          offsetgroup=1,
                          hoverinfo='text',
                          hovertext='<b>Team</b>: ' + product_sales5[product_sales5['TEAM'] == w_teams][
                              'TEAM'].astype(str) + '<br>' +
                                    '<b>APG</b>: ' + product_sales5[product_sales5['TEAM'] == w_teams][
                                        'ALT_PRODUCT_GROUP'].astype(str) + '<br>' +
                                    '<b>∑ Sales</b>: $' + [f'{x:,.0f}' for x in
                                                           product_sales5[product_sales5['TEAM'] == w_teams][
                                                               'SALES_VALUE']] + '<br>'
                          ),

                   go.Bar(
                       x=product_sales6[product_sales6['TEAM'] == w_teams]['ALT_PRODUCT_GROUP'],
                       y=product_sales6[product_sales6['TEAM'] == w_teams]['QTY_INVOICED'],
                       name='∑ Qty. Ordered',
                       text=product_sales6[product_sales6['TEAM'] == w_teams]['QTY_INVOICED'],
                       texttemplate='%{text:.2s}',
                       textposition='auto',
                       marker=dict(color='rgb(112, 123, 124)'),
                       yaxis='y2',
                       offsetgroup=2,
                       hoverinfo='text',
                       hovertext='<b>Team</b>: ' + product_sales6[product_sales6['TEAM'] == w_teams][
                           'TEAM'].astype(str) + '<br>' +
                                 '<b>APG</b>: ' + product_sales6[product_sales6['TEAM'] == w_teams][
                                     'ALT_PRODUCT_GROUP'].astype(str) + '<br>' +
                                 '<b>∑ Qty Ordered</b>: ' + [f'{x:,.0f}' for x in
                                                             product_sales6[product_sales6['TEAM'] == w_teams][
                                                                 'QTY_INVOICED']] + '<br>'
                   )],

        'layout': go.Layout(
            width=780,
            height=520,
            title={
                'text': '∑ sales & ∑ Qty Sold by APG: ' + w_teams,
                'y': 0.93,
                'x': 0.43,
                'xanchor': 'center',
                'yanchor': 'top'},
            titlefont={'family': 'Oswald',
                       'color': 'rgb(230, 34, 144)',
                       'size': 25},

            hovermode='x',

            xaxis=dict(title='<b>Name of APG</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2,
                       ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis=dict(title='<b>∑ Sales</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2,
                       ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis2=dict(title='<b>∑ Qty Sold</b>', overlaying='y', side='right',
                        color='rgb(230, 34, 144)',
                        showline=True,
                        showgrid=False,
                        showticklabels=True,
                        linecolor='rgb(104, 204, 104)',
                        linewidth=2,
                        ticks='outside',
                        tickfont=dict(
                            family='Arial',
                            size=12,
                            color='rgb(17, 37, 239)'
                        )
                        ),

            legend=dict(title='',
                        x=0.25,
                        y=1.08,
                        orientation='h',
                        bgcolor='rgba(255, 255, 255, 0)',
                        traceorder="normal",
                        font=dict(
                            family="sans-serif",
                            size=12,
                            color='#000000')),

            legend_title_font_color="green",
            uniformtext_minsize=12,
            uniformtext_mode='hide',
        )
    }


# Chart R2: Create combination of bar chart and line chart (Compare each year sales and q. ordered for each product)
@app.callback(Output('bar_line_4', 'figure'),
              [Input('w_teams', 'value')])
def update_graph(w_teams):
    product_sales7 = sales_1.groupby(['TEAM', 'YEAR_ID'])['SALES_VALUE'].sum().reset_index()
    product_sales8 = sales_1.groupby(['TEAM', 'YEAR_ID'])['QTY_INVOICED'].sum().reset_index()

    return {
        'dec_20': [go.Bar(x=product_sales7[product_sales7['TEAM'] == w_teams]['YEAR_ID'],
                          y=product_sales7[product_sales7['TEAM'] == w_teams]['SALES_VALUE'],
                          text=product_sales7[product_sales7['TEAM'] == w_teams]['SALES_VALUE'],
                          name='∑ Sales',
                          texttemplate='%{text:.2s}',
                          textposition='auto',
                          marker=dict(color='rgb(11, 220, 239)'),
                          yaxis='y1',
                          hoverinfo='text',
                          hovertext='<b>Team</b>: ' + product_sales7[product_sales7['TEAM'] == w_teams][
                              'TEAM'].astype(str) + '<br>' +
                                    '<b>∑ sales</b>: $' + [f'{x:,.0f}' for x in
                                                           product_sales7[product_sales7['TEAM'] == w_teams][
                                                               'SALES_VALUE']] + '<br>' +
                                    '<b>Year</b>: ' + product_sales7[product_sales7['TEAM'] == w_teams][
                                        'YEAR_ID'].astype(
                              str) + '<br>'
                          ),

                   go.Scatter(
                       x=product_sales8[product_sales8['TEAM'] == w_teams]['YEAR_ID'],
                       y=product_sales8[product_sales8['TEAM'] == w_teams]['QTY_INVOICED'],
                       name='∑ Qty Ordered',
                       text=product_sales8[product_sales8['TEAM'] == w_teams]['QTY_INVOICED'],
                       mode='markers + lines',
                       marker=dict(color='#bd3786'),
                       yaxis='y2',
                       hoverinfo='text',
                       hovertext='<b>Team</b>: ' + product_sales8[product_sales8['TEAM'] == w_teams][
                           'TEAM'].astype(str) + '<br>' +
                                 '<b>∑ Qty Sold</b>: ' + [f'{x:,.0f}' for x in
                                                          product_sales8[product_sales8['TEAM'] == w_teams][
                                                              'QTY_INVOICED']] + '<br>' +
                                 '<b>Year</b>: ' + product_sales8[product_sales8['TEAM'] == w_teams]['YEAR_ID'].astype(
                           str) + '<br>'
                   )],

        'layout': go.Layout(
            width=780,
            height=520,
            title={
                'text': '∑ Sales & ∑ Qty Sold by APG: ' + w_teams,
                'y': 0.93,
                'x': 0.43,
                'xanchor': 'center',
                'yanchor': 'top'},
            titlefont={'family': 'Oswald',
                       'color': 'rgb(230, 34, 144)',
                       'size': 25},

            hovermode='x',

            xaxis=dict(title='<b>APG</b>',
                       tick0=0,
                       dtick=1,
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2,
                       ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis=dict(title='<b>∑ sales</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2,
                       ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis2=dict(title='<b>∑ Qty Sold</b>', overlaying='y', side='right',
                        color='rgb(230, 34, 144)',
                        showline=True,
                        showgrid=False,
                        showticklabels=True,
                        linecolor='rgb(104, 204, 104)',
                        linewidth=2,
                        ticks='outside',
                        tickfont=dict(
                            family='Arial',
                            size=12,
                            color='rgb(17, 37, 239)'
                        )
                        ),

            legend=dict(title='',
                        x=0.25,
                        y=1.08,
                        orientation='h',
                        bgcolor='rgba(255, 255, 255, 0)',
                        traceorder="normal",
                        font=dict(family="sans-serif", size=12, color='#000000')),

            legend_title_font_color="green",
            uniformtext_minsize=12,
            uniformtext_mode='hide',
        )
    }


# TODO: i like this one. How can i make it more readable. why do some people disagree with the week number?
# Chart L3: Create line chart (year oon year weekly sales)
@app.callback(Output('line_line_5', 'figure'),
              [Input('w_teams', 'value')])
def update_graph(w_teams):
    monthly_sales = sales_1.groupby(['TEAM', 'YEAR_ID', 'WEEK_ID'])['SALES_VALUE'].sum().reset_index()

    return {
        'dec_20': [go.Scatter(
            x=monthly_sales[(monthly_sales['YEAR_ID'] == 2020) & (monthly_sales['TEAM'] == w_teams)]['WEEK_ID'],
            y=monthly_sales[(monthly_sales['YEAR_ID'] == 2020) & (monthly_sales['TEAM'] == w_teams)]['SALES_VALUE'],
            text=monthly_sales[(monthly_sales['YEAR_ID'] == 2020) & (monthly_sales['TEAM'] == w_teams)][
                'SALES_VALUE'],
            name='2020',
            mode='markers+lines',
            hoverinfo='text',
            hovertext='<b>Team</b>: ' + monthly_sales[(monthly_sales['YEAR_ID'] == 2020) & (monthly_sales[
                                                                                                'TEAM'] == w_teams)][
                'TEAM'].astype(str) + '<br>' +
                      '<b>Year</b>: ' + monthly_sales[(monthly_sales['YEAR_ID'] == 2020) & (monthly_sales[
                                                                                                'TEAM'] == w_teams)][
                          'YEAR_ID'].astype(str) + '<br>' +
                      '<b>Week</b>: ' + monthly_sales[(monthly_sales['YEAR_ID'] == 2020) & (monthly_sales[
                                                                                                'TEAM'] == w_teams)][
                          'WEEK_ID'].astype(str) + '<br>' +
                      '<b>Sales</b>: $' + [f'{x:,.0f}' for x in monthly_sales[
                (monthly_sales['YEAR_ID'] == 2020) & (monthly_sales['TEAM'] == w_teams)]['SALES_VALUE']] + '<br>'
        ),

            go.Scatter(
                x=monthly_sales[(monthly_sales['YEAR_ID'] == 2021) & (monthly_sales['TEAM'] == w_teams)][
                    'WEEK_ID'],
                y=monthly_sales[(monthly_sales['YEAR_ID'] == 2021) & (monthly_sales['TEAM'] == w_teams)][
                    'SALES_VALUE'],
                text=monthly_sales[(monthly_sales['YEAR_ID'] == 2021) & (monthly_sales['TEAM'] == w_teams)][
                    'SALES_VALUE'],
                name='2021',
                mode='markers+lines',
                hoverinfo='text',
                hovertext='<b>Team</b>: ' + monthly_sales[(monthly_sales['YEAR_ID'] == 2021) & (monthly_sales[
                                                                                                    'TEAM'] == w_teams)][
                    'TEAM'].astype(str) + '<br>' +
                          '<b>Year</b>: ' + monthly_sales[(monthly_sales['YEAR_ID'] == 2021) & (monthly_sales[
                                                                                                    'TEAM'] == w_teams)][
                              'YEAR_ID'].astype(str) + '<br>' +
                          '<b>Week</b>: ' + monthly_sales[(monthly_sales['YEAR_ID'] == 2021) & (monthly_sales[
                                                                                                    'TEAM'] == w_teams)][
                              'WEEK_ID'].astype(str) + '<br>' +
                          '<b>Sales</b>: $' + [f'{x:,.0f}' for x in monthly_sales[
                    (monthly_sales['YEAR_ID'] == 2021) & (monthly_sales['TEAM'] == w_teams)][
                    'SALES_VALUE']] + '<br>'
            )],

        'layout': go.Layout(
            width=780,
            height=520,
            title={
                'text': 'Weekly Sales: ' + w_teams,
                'y': 0.93,
                'x': 0.43,
                'xanchor': 'center',
                'yanchor': 'top'},
            titlefont={'family': 'Oswald',
                       'color': 'rgb(230, 34, 144)',
                       'size': 25},

            hovermode='x',

            xaxis=dict(title='<b>Week</b>',
                       tick0=0,
                       dtick=1,
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2, ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            yaxis=dict(title='<b>∑ sales</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2, ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),

            legend=dict(title='',
                        x=0.25,
                        y=1.08,
                        orientation='h',
                        bgcolor='rgba(255, 255, 255, 0)',
                        traceorder="normal",
                        font=dict(
                            family="sans-serif",
                            size=12,
                            color='#000000')),

            legend_title_font_color="green",
            uniformtext_minsize=12,
            uniformtext_mode='hide',
        )
    }


# TODO: Chart R3: Create bubble chart (Compare sales and q. ordered). This one doesn't really work. reconsider and
#  re-plot. If you were the sales manager, what information would you need to see to make the decisions you need to
#  achieve the results yuo need.
@app.callback(Output('scatter_6', 'figure'),
              [Input('w_teams', 'value')])
def update_graph(w_teams):
    scatter = sales_1.groupby(['TEAM', 'ALT_PRODUCT_GROUP'])[['QTY_INVOICED', 'SALES_VALUE']].sum().reset_index()

    return {
        'dec_20': [go.Scatter(x=scatter[scatter['TEAM'] == w_teams]['QTY_INVOICED'],
                              y=scatter[scatter['TEAM'] == w_teams]['SALES_VALUE'],
                              text=scatter[scatter['TEAM'] == w_teams]['SALES_VALUE'],
                              mode='markers',
                              hoverinfo='text',
                              hovertext='<b>Team</b>: ' + scatter[scatter['TEAM'] == w_teams]['TEAM'].astype(
                                  str) + '<br>' +
                                        '<b>APG</b>: ' + scatter[scatter['TEAM'] == w_teams][
                                            'ALT_PRODUCT_GROUP'].astype(
                                  str) + '<br>' +
                                        '<b>∑ Qty Sold</b>: ' + [f'{x:,.0f}' for x in
                                                                 scatter[scatter['TEAM'] == w_teams][
                                                                     'QTY_INVOICED']] + '<br>' +
                                        '<b>Sales</b>: $' + [f'{x:,.0f}' for x in
                                                             scatter[scatter['TEAM'] == w_teams][
                                                                 'SALES_VALUE']] + '<br>',
                              marker=dict(
                                  size=20,
                                  color=scatter[scatter['TEAM'] == w_teams]['QTY_INVOICED'],
                                  colorscale='mrybm',
                                  showscale=False
                              )
                              )],

        'layout': go.Layout(
            width=780,
            height=520,
            title={
                'text': '∑ Sales vs. Sold Qty:' + w_teams,
                'y': 0.93,
                'x': 0.43,
                'xanchor': 'center',
                'yanchor': 'top'},
            titlefont={'family': 'Oswald',
                       'color': 'rgb(230, 34, 144)',
                       'size': 25},

            hovermode='x',

            xaxis=dict(
                title='<b>∑ Qty Sold</b>',
                color='rgb(230, 34, 144)',
                showline=True, showgrid=True,
                showticklabels=True, linecolor='rgb(104, 204, 104)',
                linewidth=2,
                ticks='outside',
                tickfont=dict(
                    family='Arial',
                    size=12,
                    color='rgb(17, 37, 239)'
                )
            ),

            yaxis=dict(title='<b>Sales</b>',
                       color='rgb(230, 34, 144)',
                       showline=True,
                       showgrid=True,
                       showticklabels=True,
                       linecolor='rgb(104, 204, 104)',
                       linewidth=2, ticks='outside',
                       tickfont=dict(
                           family='Arial',
                           size=12,
                           color='rgb(17, 37, 239)'
                       )
                       ),
        )
    }


if __name__ == '__main__':
    app.run_server(host='0.0.0.0', port=8050)
