SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    '' AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    SUM(a.GL52007 - a.GL52025) AS 'January',
    SUM(a.GL52008 - a.GL52026) AS 'February',
    SUM(a.GL52009 - a.GL52027) AS 'March',
    SUM(a.GL52010 - a.GL52028) AS 'April',
    SUM(a.GL52011 - a.GL52029) AS 'May',
    SUM(a.GL52012 - a.GL52030) AS 'June',
    SUM(a.GL52013 - a.GL52031) AS 'July',
    SUM(a.GL52014 - a.GL52032) AS 'August',
    SUM(a.GL52015 - a.GL52033) AS 'September',
    SUM(a.GL52015 - a.GL52033) AS 'October',
    SUM(a.GL52015 - a.GL52033) AS 'November',
    SUM(a.GL52015 - a.GL52033) AS 'December'
    FROM ScaCompanyDB..GL520121 a LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001
    WHERE a.GL52003 IN ('99', ' ')  -- Change this value (99) to produce output for a particular cost centre/99 is consolidated
    AND a.GL52002 IN ('400901', '400902', '400903', '400910', '400911', '400916')
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
    SUM(a.GL52007 - a.GL52025) AS 'January',
    SUM(a.GL52008 - a.GL52026) AS 'February',
    SUM(a.GL52009 - a.GL52027) AS 'March',
    SUM(a.GL52010 - a.GL52028) AS 'April',
    SUM(a.GL52011 - a.GL52029) AS 'May',
    SUM(a.GL52012 - a.GL52030) AS 'June',
    SUM(a.GL52013 - a.GL52031) AS 'July',
    SUM(a.GL52014 - a.GL52032) AS 'August',
    SUM(a.GL52015 - a.GL52033) AS 'September',
    SUM(a.GL52015 - a.GL52033) AS 'October',
    SUM(a.GL52015 - a.GL52033) AS 'November',
    SUM(a.GL52015 - a.GL52033) AS 'December'
    FROM ScaCompanyDB..GL520120 a LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001
    WHERE a.GL52003 IN ('99', ' ')  -- Change this value (99) to produce output for a particular cost centre/99 is consolidated
    AND a.GL52002 IN ('400901', '400902', '400903', '400910', '400911', '400916')
    AND GL52001='0'
    GROUP BY GL52001, GL52002, GL53002, GL52003, GL52004;