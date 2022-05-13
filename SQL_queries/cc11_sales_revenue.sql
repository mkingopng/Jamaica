SELECT
	GL52001,
	GL52002 AS account_number,
	GL52003 AS cc,
	GL52004 AS alt_product_group,
	GL52007 AS January_20,  -- p1debitamt
	GL52008 AS February_20,  -- p2debitamt
	GL52009 AS March_20,  -- p3debitamt
	GL52010 AS April_20,  -- p4debitamt
	GL52011 AS May_20,  -- p5debitamt
	GL52012 AS June_20,  -- p6debitamt
	GL52013 AS July_20,  -- p7debitamt
	GL52014 AS August_20,  -- p8debitamt
	GL52015 AS September_20,  -- p9debitamt
	GL52016 AS October_20,  -- p10debitamt
	GL52017 AS November_20,  -- p11debitamt
	GL52018 AS December_20  -- p12debitamt
FROM GL520120
WHERE GL52001=0 AND GL52002=300000 AND GL52003='11'
