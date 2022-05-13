SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    x.GL03003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    a.GL52007 - a.GL52025 AS 'January',
    a.GL52008 - a.GL52026 AS 'February',
    a.GL52009 - a.GL52027 AS 'March',
    a.GL52010 - a.GL52028 AS 'April',
    a.GL52011 - a.GL52029 AS 'May',
    a.GL52012 - a.GL52030 AS 'June',
    a.GL52013 - a.GL52031 AS 'July',
    a.GL52014 - a.GL52032 AS 'August',
    a.GL52015 - a.GL52033 AS 'September',
    a.GL52016 - a.GL52034 AS 'October',
    a.GL52017 - a.GL52035 AS 'November',
    a.GL52018 - a.GL52036 AS 'December'
FROM ScaCompanyDB..GL520121 a INNER JOIN ScaCompanyDB..GL030121 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001  -- the year. change the tables to 121 for 2021
                              LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001
                              LEFT OUTER JOIN ScaCompanyDB..GL030121 z ON a.GL52002 = z.GL03001
WHERE a.GL52003='99'  -- cc, Change this value
AND a.GL52002 = '400000'  -- accounting_code for cogs
AND x.GL03001='C'
AND GL52004 IN ('ACACON', 'ACACOP', 'ACAOIL', 'ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT', 'ACMCCR',
                'ACMMAN', 'ACRSUN', 'ACSALU', 'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSONN', 'ACSOOO', 'ACSSUL', 'ACTDAZ', 'ACTDHR',
                'ACTDLP', 'ACUOIL', 'AIJSAF', 'AIOSEH', 'AIPROT');

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',
    y.GL53002 AS 'category',
    x.GL03003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    a.GL52007 - a.GL52025 AS 'January',
    a.GL52008 - a.GL52026 AS 'February',
    a.GL52009 - a.GL52027 AS 'March',
    a.GL52010 - a.GL52028 AS 'April',
    a.GL52011 - a.GL52029 AS 'May',
    a.GL52012 - a.GL52030 AS 'June',
    a.GL52013 - a.GL52031 AS 'July',
    a.GL52014 - a.GL52032 AS 'August',
    a.GL52015 - a.GL52033 AS 'September',
    a.GL52016 - a.GL52034 AS 'October',
    a.GL52017 - a.GL52035 AS 'November',
    a.GL52018 - a.GL52036 AS 'December'
FROM ScaCompanyDB..GL520120 a INNER JOIN ScaCompanyDB..GL030120 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001  -- the year. change the tables to 121 for 2021
                              LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001
                              LEFT OUTER JOIN ScaCompanyDB..GL030120 z ON a.GL52002 = z.GL03001
WHERE a.GL52003='99'  -- cc, Change this value
AND a.GL52002 = '400000'  -- accounting_code for cogs
AND x.GL03001='C'
AND GL52004 IN ('ACACON', 'ACACOP', 'ACAOIL', 'ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT', 'ACMCCR',
                'ACMMAN', 'ACRSUN', 'ACSALU', 'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSONN', 'ACSOOO', 'ACSSUL', 'ACTDAZ', 'ACTDHR',
                'ACTDLP', 'ACUOIL', 'AIJSAF', 'AIOSEH', 'AIPROT');