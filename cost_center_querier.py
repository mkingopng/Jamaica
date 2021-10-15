"""
It seems that you have access to the backend of the accounting system, so you can build a class for you to handle
these queries

Copyright (C) Weicong Kong, 2/09/2021
"""
import os
import pandas as pd
import mappings
from mappings import *
import sqlalchemy as sa
from creds import *
import urllib.parse

params = urllib.parse.quote_plus(f'DRIVER={Driver};'
                                 f'SERVER={Server};'
                                 f'DATABASE={Database};'
                                 f'UID={UID};'
                                 f'PWD={PWD}')


class CostCenterQuerier(object):
    """
    a class for
    """
    def __init__(self):
        """Setup some sharable properties"""
        self.engine = (sa.create_engine("mssql+pyodbc:///?odbc_connect={}".format(params)))

    def query_as_dataframe(self, sql) -> pd.DataFrame:
        # WK: this make sure the connection will be closed after your query, good practice
        # question 2) why doesn't this work?
        with self.engine as conn:
            df = pd.read_sql_query(sql, conn)
        return df


cc = '99'
cc_list = COST_CENTER_LIST

sql_revenue = f"""
SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    x.GL03003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    a.GL52025 - a.GL52007 AS 'January',
    a.GL52026 - a.GL52008 AS 'February',
    a.GL52027 - a.GL52009 AS 'March',
    a.GL52028 - a.GL52010 AS 'April',
    a.GL52029 - a.GL52011 AS 'May',
    a.GL52030 - a.GL52012 AS 'June',
    a.GL52031 - a.GL52013 AS 'July',
    a.GL52032 - a.GL52014 AS 'August',
    a.GL52033 - a.GL52015 AS 'September',
    a.GL52034 - a.GL52016 AS 'October',
    a.GL52035 - a.GL52017 AS 'November',
    a.GL52036 - a.GL52018 AS 'December'
FROM ScaCompanyDB..GL520121 a INNER JOIN ScaCompanyDB..GL030121 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001
                              LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001
                              LEFT OUTER JOIN ScaCompanyDB..GL030121 z ON a.GL52002 = z.GL03001
WHERE a.GL52003={cc}
AND a.GL52002='300000'
AND x.GL03001='C'
AND GL52004 IN ('ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT', 'ACMMAN', 'ACRSUN', 'ACSALU', 
                'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSOOO', 'ACTDHR', 'AIPROT', 'ACACON', 'ACACOP', 'ACMCCR', 'ACTDAZ', 
                'ACTDLP', 'ACAOIL', 'ACUOIL', 'ACSSUL', 'AIJSAF', 'AIOSEH')

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    x.GL03003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    a.GL52025 - a.GL52007 AS 'January',
    a.GL52026 - a.GL52008 AS 'February',
    a.GL52027 - a.GL52009 AS 'March',
    a.GL52028 - a.GL52010 AS 'April',
    a.GL52029 - a.GL52011 AS 'May',
    a.GL52030 - a.GL52012 AS 'June',
    a.GL52031 - a.GL52013 AS 'July',
    a.GL52032 - a.GL52014 AS 'August',
    a.GL52033 - a.GL52015 AS 'September',
    a.GL52034 - a.GL52016 AS 'October',
    a.GL52035 - a.GL52017 AS 'November',
    a.GL52036 - a.GL52018 AS 'December'
FROM ScaCompanyDB..GL520120 a INNER JOIN ScaCompanyDB..GL030120 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001
                              LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001
                              LEFT OUTER JOIN ScaCompanyDB..GL030120 z ON a.GL52002 = z.GL03001
WHERE a.GL52003={cc}
AND a.GL52002 = '300000'
AND x.GL03001='C'
AND GL52004 IN ('ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT', 'ACMMAN', 'ACRSUN', 'ACSALU', 
                'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSOOO', 'ACTDHR', 'AIPROT', 'ACACON', 'ACACOP', 'ACMCCR', 'ACTDAZ', 
                'ACTDLP', 'ACAOIL', 'ACUOIL', 'ACSSUL', 'AIJSAF', 'AIOSEH')
 """

sql_cogs = f"""
SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    x.GL03003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    (a.GL52007 - a.GL52025) * -1 AS 'January',
    (a.GL52008 - a.GL52026) * -1 AS 'February',
    (a.GL52009 - a.GL52027) * -1 AS 'March',
    (a.GL52010 - a.GL52028) * -1 AS 'April',
    (a.GL52011 - a.GL52029) * -1 AS 'May',
    (a.GL52012 - a.GL52030) * -1 AS 'June',
    (a.GL52013 - a.GL52031) * -1 AS 'July',
    (a.GL52014 - a.GL52032) * -1 AS 'August',
    (a.GL52015 - a.GL52033) * -1 AS 'September',
    (a.GL52016 - a.GL52034) * -1 AS 'October',
    (a.GL52017 - a.GL52035) * -1 AS 'November',
    (a.GL52018 - a.GL52036) * -1 AS 'December'
FROM ScaCompanyDB..GL520121 a INNER JOIN ScaCompanyDB..GL030121 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001
                              LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001
                              LEFT OUTER JOIN ScaCompanyDB..GL030121 z ON a.GL52002 = z.GL03001
WHERE a.GL52003={cc}  -- cc, Change this value
AND a.GL52002 = '400000'  -- accounting_code for cogs
AND x.GL03001='C'
AND GL52004 IN ('ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT', 'ACMMAN', 'ACRSUN', 'ACSALU', 
                'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSOOO', 'ACTDHR', 'AIPROT', 'ACACON', 'ACACOP', 'ACMCCR', 'ACTDAZ', 
                'ACTDLP', 'ACAOIL', 'ACUOIL', 'ACSSUL', 'AIJSAF', 'AIOSEH')

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    x.GL03003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    (a.GL52007 - a.GL52025) * -1 AS 'January',
    (a.GL52008 - a.GL52026) * -1 AS 'February',
    (a.GL52009 - a.GL52027) * -1 AS 'March',
    (a.GL52010 - a.GL52028) * -1 AS 'April',
    (a.GL52011 - a.GL52029) * -1 AS 'May',
    (a.GL52012 - a.GL52030) * -1 AS 'June',
    (a.GL52013 - a.GL52031) * -1 AS 'July',
    (a.GL52014 - a.GL52032) * -1 AS 'August',
    (a.GL52015 - a.GL52033) * -1 AS 'September',
    (a.GL52016 - a.GL52034) * -1 AS 'October',
    (a.GL52017 - a.GL52035) * -1 AS 'November',
    (a.GL52018 - a.GL52036) * -1 AS 'December'
FROM ScaCompanyDB..GL520120 a INNER JOIN ScaCompanyDB..GL030120 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001  -- the year. change the tables to 121 for 2021
                              LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001
                              LEFT OUTER JOIN ScaCompanyDB..GL030120 z ON a.GL52002 = z.GL03001
WHERE a.GL52003={cc}  -- cc, Change this value
AND a.GL52002 = '400000'  -- accounting_code for cogs
AND x.GL03001='C'
AND GL52004 IN ('ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT', 'ACMMAN', 'ACRSUN', 'ACSALU', 
                'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSOOO', 'ACTDHR', 'AIPROT', 'ACACON', 'ACACOP', 'ACMCCR', 'ACTDAZ', 
                'ACTDLP', 'ACAOIL', 'ACUOIL', 'ACSSUL', 'AIJSAF', 'AIOSEH')
"""

sql_manufacturing_variances = f"""
SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    SUM(a.GL52007 - a.GL52025) * -1 AS 'January',
    SUM(a.GL52008 - a.GL52026) * -1 AS 'February',
    SUM(a.GL52009 - a.GL52027) * -1 AS 'March',
    SUM(a.GL52010 - a.GL52028) * -1 AS 'April',
    SUM(a.GL52011 - a.GL52029) * -1 AS 'May',
    SUM(a.GL52012 - a.GL52030) * -1 AS 'June',
    SUM(a.GL52013 - a.GL52031) * -1 AS 'July',
    SUM(a.GL52014 - a.GL52032) * -1 AS 'August',
    SUM(a.GL52015 - a.GL52033) * -1 AS 'September',
    SUM(a.GL52015 - a.GL52033) * -1 AS 'October',
    SUM(a.GL52015 - a.GL52033) * -1 AS 'November',
    SUM(a.GL52015 - a.GL52033) * -1 AS 'December'
    FROM ScaCompanyDB..GL520121 a LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001
    WHERE a.GL52003 IN ({cc}, ' ')  -- Change this value (99) to produce output for a particular cost centre/99 is consolidated
    AND a.GL52002 IN ('400001', '400901', '400902', '400903', '400910', '400911', '4009012', '400916')
    AND GL52001='0'
    GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    SUM(a.GL52007 - a.GL52025) * -1 AS 'January',
    SUM(a.GL52008 - a.GL52026) * -1 AS 'February',
    SUM(a.GL52009 - a.GL52027) * -1 AS 'March',
    SUM(a.GL52010 - a.GL52028) * -1 AS 'April',
    SUM(a.GL52011 - a.GL52029) * -1 AS 'May',
    SUM(a.GL52012 - a.GL52030) * -1 AS 'June',
    SUM(a.GL52013 - a.GL52031) * -1 AS 'July',
    SUM(a.GL52014 - a.GL52032) * -1 AS 'August',
    SUM(a.GL52015 - a.GL52033) * -1 AS 'September',
    SUM(a.GL52015 - a.GL52033) * -1 AS 'October',
    SUM(a.GL52015 - a.GL52033) * -1 AS 'November',
    SUM(a.GL52015 - a.GL52033) * -1 AS 'December'
    FROM ScaCompanyDB..GL520120 a LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001
    WHERE a.GL52003 IN ({cc}, ' ')  -- Change this value (99) to produce output for a particular cost centre/99 is consolidated
    AND a.GL52002 IN ('400001', '400901', '400902', '400903', '400910', '400911', '4009012', '400916')
    AND GL52001='0'
    GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004;
"""

sql_stock_variances = f"""
SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    a.GL52003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
    FROM ScaCompanyDB..GL520121 a LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001  -- the year. change the tables to 121 for 2021
    WHERE a.GL52003 IN ({cc}, ' ')  -- cc. Change this value
    AND a.GL52002 IN ('401000','401020','402000')
    AND GL52001='0'
    GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    a.GL52003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
    FROM ScaCompanyDB..GL520120 a LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001  -- the year. change the tables to 121 for 2021
    WHERE a.GL52003 IN ({cc}, ' ')  -- cc. Change this value
    AND a.GL52002 IN ('401000','401020','402000')
    AND GL52001='0'
    GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004
"""

sql_direct_costs = f"""
SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
FROM ScaCompanyDB..GL520121 a INNER JOIN ScaCompanyDB..GL030121 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001  -- the year. change the tables to 121 for 2021
                              LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001
                              LEFT OUTER JOIN ScaCompanyDB..GL030121 z ON a.GL52002 = z.GL03001
WHERE a.GL52003 IN ({cc}, ' ')  -- cc, change this value
AND a.GL52002 IN ('400000', '400001')
AND GL52004 IN ('AIXAFG', 'AIXARM', 'AIXAAB', 'AIXCGL', 'AIXCOS', 'AIXCOT', 'AIXCRN', 'AIXDLC', 
                'AIXFRA', 'AIXFRR', 'AIXFRS', 'AIXFRT', 'AIXFRU', 'AIXPAR', 'AIXROY', ' ')
AND GL52001 = '0'
GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004, GL52018

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
FROM ScaCompanyDB..GL520120 a INNER JOIN ScaCompanyDB..GL030120 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001  -- the year. change the tables to 121 for 2021
                              LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001
                              LEFT OUTER JOIN ScaCompanyDB..GL030120 z ON a.GL52002 = z.GL03001
WHERE a.GL52003 IN ({cc}, ' ')  -- cc, change this value
AND a.GL52002 IN ('400000', '400001')
AND GL52004 IN ('AIXAFG', 'AIXARM', 'AIXAAB', 'AIXCGL', 'AIXCOS', 'AIXCOT', 'AIXCRN', 'AIXDLC', 
                'AIXFRA', 'AIXFRR', 'AIXFRS', 'AIXFRT', 'AIXFRU', 'AIXPAR', 'AIXROY', ' ')
AND GL52001 = '0'
GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004, GL52018
"""

sql_overheads = f"""
SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',    
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
    FROM ScaCompanyDB..GL520121 a LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001  -- the year. change the tables to 121 for 2021
    WHERE a.GL52003 IN ({cc},'SC', 'SE', 'SO','SP','SR','ST','SV')  -- cc, Change this value
    AND a.GL52002 IN ('530010', '530011', '530020', '530030', '530035', '530040', '530045', '530065', '530080',
                      '530095', '530096', '530101', '530105', '530109', '530120', '530125', '530130', '530145',
                      '530155', '530159', '530160', '530161', '530165', '530170', '530174', '530176', '530177',
                      '530182', '530183', '530184', '530185', '530186', '530188', '530189', '530190', '530191',
                      '530193', '530194', '530195', '530197', '530199', '530200', '530260', '530270', '530275',
                      '530280', '530291', '530295', '530011', '530026', '530043', '530044', '530097', '530100', 
                      '530108', '530146', '530158', '530179')
    AND GL52001='0'  -- 0 for closed balances
    GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
    FROM ScaCompanyDB..GL520120 a LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001  -- the year. change the tables to 121 for 2021
    WHERE a.GL52003 IN ({cc},'SC', 'SE', 'SO','SP','SR','ST','SV')  -- cc, Change this value
    AND a.GL52002 IN ('530010', '530011', '530020', '530030', '530035', '530040', '530045', '530065', '530080',
                      '530095', '530096', '530101', '530105', '530109', '530120', '530125', '530130', '530145',
                      '530155', '530159', '530160', '530161', '530165', '530170', '530174', '530176', '530177',
                      '530182', '530183', '530184', '530185', '530186', '530188', '530189', '530190', '530191',
                      '530193', '530194', '530195', '530197', '530199', '530200', '530260', '530270', '530275',
                      '530280', '530291', '530295', '530011', '530026', '530043', '530044', '530097', '530100', 
                      '530108', '530146', '530158', '530179')
    AND GL52001='0'  -- 0 for closed balances
    GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004
"""

sql_other_income = f"""
SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
FROM ScaCompanyDB..GL520121 a LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001   -- the year. change the tables to 121 for 2021
WHERE a.GL52003={cc}  -- cc, Change this value
AND a.GL52002 ='530206' AND GL52001='0'
GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
FROM ScaCompanyDB..GL520120 a LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001   -- the year. change the tables to 121 for 2021
WHERE a.GL52003={cc}  -- cc, Change this value
AND a.GL52002 ='530206' AND GL52001='0'
GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004
"""

sql_other_expenses = f"""
SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
FROM ScaCompanyDB..GL520121 a LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001  -- the year. change the tables to 121 for 2021
WHERE a.GL52003={cc}  -- the cost centre. Change this value
AND a.GL52002 IN ('530215', '530230', '530230', '530232', '530234', '530240', '530243', '530245', '530249', '530250')
AND GL52001='0'
GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    SUM(a.GL52025 - a.GL52007) AS 'January',
    SUM(a.GL52026 - a.GL52008) AS 'February',
    SUM(a.GL52027 - a.GL52009) AS 'March',
    SUM(a.GL52028 - a.GL52010) AS 'April',
    SUM(a.GL52029 - a.GL52011) AS 'May',
    SUM(a.GL52030 - a.GL52012) AS 'June',
    SUM(a.GL52031 - a.GL52013) AS 'July',
    SUM(a.GL52032 - a.GL52014) AS 'August',
    SUM(a.GL52033 - a.GL52015) AS 'September',
    SUM(a.GL52034 - a.GL52016) AS 'October',
    SUM(a.GL52035 - a.GL52017) AS 'November',
    SUM(a.GL52036 - a.GL52018) AS 'December'
FROM ScaCompanyDB..GL520120 a LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001  -- the year. change the tables to 121 for 2021
WHERE a.GL52003={cc}  -- the cost centre. Change this value
AND a.GL52002 IN ('530215', '530230', '530230', '530232', '530234', '530240', '530243', '530245', '530249', '530250')
AND GL52001='0'
GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004
"""
