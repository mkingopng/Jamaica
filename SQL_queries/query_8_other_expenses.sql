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
WHERE a.GL52003='99'  -- the cost centre. Change this value
AND a.GL52002 IN ('530215', '530230', '530232', '530234', '530240', '530245', '530249', '530250')
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
WHERE a.GL52003='99'  -- the cost centre. Change this value
AND a.GL52002 IN ('530215', '530230', '530232', '530234', '530240', '530245', '530249', '530250')
AND GL52001='0'
GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004;