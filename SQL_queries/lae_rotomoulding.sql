SELECT
	GL52003 AS 'cc',
	GL52002  AS 'accounting_code',
	GL52004 AS 'alt_product_group',
	CAST(GL52007 AS FLOAT) AS 'january_20',  -- debit
	CAST(GL52008 AS FLOAT) AS 'february_20',  -- debit
	CAST(GL52009 AS FLOAT) AS 'march_20',  -- debit
	CAST(GL52010 AS FLOAT) AS 'april_20',  -- debit
	CAST(GL52011 AS FLOAT) AS 'may_20',  -- debit
	CAST(GL52012 AS FLOAT) AS 'june_20',  -- debit
	CAST(GL52013 AS FLOAT) AS 'july_20',  -- debit
	CAST(GL52014 AS FLOAT) AS 'august_20',  -- debit
	CAST(GL52015 AS FLOAT) AS 'september_20',  -- debit
	CAST(GL52016 AS FLOAT) AS 'october_20',  -- debit
	CAST(GL52017 AS FLOAT) AS 'november_20',  -- debit
	CAST(GL52018 AS FLOAT) AS 'december_20'  -- debit
FROM GL520120
WHERE GL52003 = '29' AND GL52002 = '400000';
