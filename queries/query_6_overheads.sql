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
    WHERE a.GL52003 IN ('11','SC', 'SE', 'SO','SP','SR','ST','SV')  -- cc, Change this value
    AND a.GL52002 IN ('530010', '530011', '530020', '530030', '530035', '530040', '530045', '530065', '530080',
                      '530095', '530096', '530101', '530105', '530109', '530120', '530125', '530130', '530145',
                      '530155', '530159', '530160', '530161', '530165', '530170', '530174', '530176', '530177',
                      '530182', '530183', '530184', '530185', '530186', '530188', '530189', '530190', '530191',
                      '530193', '530194', '530195', '530197', '530199', '530200', '530260', '530270', '530275',
                      '530280', '530291', '530295')
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
    WHERE a.GL52003 IN ('11','SC', 'SE', 'SO','SP','SR','ST','SV')  -- cc, Change this value
    AND a.GL52002 IN ('530010', '530011', '530020', '530030', '530035', '530040', '530045', '530065', '530080',
                      '530095', '530096', '530101', '530105', '530109', '530120', '530125', '530130', '530145',
                      '530155', '530159', '530160', '530161', '530165', '530170', '530174', '530176', '530177',
                      '530182', '530183', '530184', '530185', '530186', '530188', '530189', '530190', '530191',
                      '530193', '530194', '530195', '530197', '530199', '530200', '530260', '530270', '530275',
                      '530280', '530291', '530295')
    AND GL52001='0'  -- 0 for closed balances
    GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004;