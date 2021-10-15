use ScaCompanyDB

SELECT
	GL52001,
	GL52003 AS 'cc',
	GL52002  AS 'accounting_code',
	GL52004 AS 'alt_product_group',
	CAST(GL52025 AS FLOAT) AS 'january_20_credit',
	CAST(GL52026 AS FLOAT) AS 'february_20_credit',
	CAST(GL52027 AS FLOAT) AS 'march_20_credit',
	CAST(GL52028 AS FLOAT) AS 'april_20_credit',
	CAST(GL52029 AS FLOAT) AS 'may_20_credit',
	CAST(GL52030 AS FLOAT) AS 'june_20_credit',
	CAST(GL52031 AS FLOAT) AS 'july_20_credit',
	CAST(GL52032 AS FLOAT) AS 'august_20_credit',
	CAST(GL52033 AS FLOAT) AS 'september_20_credit',
	CAST(GL52034 AS FLOAT) AS 'october_20_credit',
	CAST(GL52035 AS FLOAT) AS 'november_20_credit',
	CAST(GL52036 AS FLOAT) AS 'december_20_credit'
FROM GL520120
WHERE GL52001='0' AND GL52003 = '29' AND GL52002 = '400000';