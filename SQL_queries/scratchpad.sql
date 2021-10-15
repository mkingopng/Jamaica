SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',   -- cc
    y.GL53002 AS 'category',
    x.GL03003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2021' AS 'year',
    a.GL52025 - a.GL52007 AS 'january',
    a.GL52026 - a.GL52008 AS 'february',
    a.GL52027 - a.GL52009 AS 'march',
    a.GL52028 - a.GL52010 AS 'april',
    a.GL52029 - a.GL52011 AS 'may',
    a.GL52030 - a.GL52012 AS 'june',
    a.GL52031 - a.GL52013 AS 'july',
    a.GL52032 - a.GL52014 AS 'august',
    a.GL52033 - a.GL52015 AS 'september',
    a.GL52034 - a.GL52016 AS 'october',
    a.GL52035 - a.GL52017 AS 'november',
    a.GL52036 - a.GL52018 AS 'december'
FROM ScaCompanyDB..GL520121 a INNER JOIN ScaCompanyDB..GL030121 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001
                                            LEFT OUTER JOIN ScaCompanyDB..GL530121 y ON a.GL52002 = y.GL53001
                                            LEFT OUTER JOIN ScaCompanyDB..GL030121 z ON a.GL52002 = z.GL03001
WHERE a.GL52003={c}
AND a.GL52002='300000'
AND x.GL03001='C'
AND GL52004 IN ('ACACON', 'ACACOP', 'ACAOIL', 'ACBBOT', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT', 'ACMCCR',
                'ACMMAN', 'ACRSUN', 'ACSALU', 'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSONN', 'ACSOOO', 'ACTDAZ', 'ACTDHR',
                'ACTDLP', 'ACUOIL', 'AIJSAF', 'AIOSEH', 'AIPROT')

UNION ALL

SELECT
    a.GL52002 AS 'accounting_code',
    a.GL52003 AS 'cc',   -- cc
    y.GL53002 AS 'category',
    x.GL03003 AS 'description',
    a.GL52004 AS 'alt_product_group',
    '2020' AS 'year',
    a.GL52025 - a.GL52007 AS 'january',
    a.GL52026 - a.GL52008 AS 'february',
    a.GL52027 - a.GL52009 AS 'march',
    a.GL52028 - a.GL52010 AS 'april',
    a.GL52029 - a.GL52011 AS 'may',
    a.GL52030 - a.GL52012 AS 'june',
    a.GL52031 - a.GL52013 AS 'july',
    a.GL52032 - a.GL52014 AS 'august',
    a.GL52033 - a.GL52015 AS 'september',
    a.GL52034 - a.GL52016 AS 'october',
    a.GL52035 - a.GL52017 AS 'november',
    a.GL52036 - a.GL52018 AS 'december'
FROM ScaCompanyDB..GL520120 a INNER JOIN ScaCompanyDB..GL030120 x ON x.GL03002 = a.GL52004 AND '0' = a.GL52001
                                            LEFT OUTER JOIN ScaCompanyDB..GL530120 y ON a.GL52002 = y.GL53001
                                            LEFT OUTER JOIN ScaCompanyDB..GL030120 z ON a.GL52002 = z.GL03001
WHERE a.GL52003='99'
AND a.GL52002 = '300000'
AND x.GL03001='C'
AND GL52004 IN ('ACACON', 'ACACOP', 'ACAOIL', 'ACBBOT', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT', 'ACMCCR',
                'ACMMAN', 'ACRSUN', 'ACSALU', 'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSONN', 'ACSOOO', 'ACTDAZ', 'ACTDHR',
                'ACTDLP', 'ACUOIL', 'AIJSAF', 'AIOSEH', 'AIPROT')