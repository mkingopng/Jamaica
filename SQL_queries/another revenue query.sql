SELECT
	GL52002 AS account_number,
	GL52003 AS cc,
	GL52004 AS alt_product_group,
	SUM(GL52007) AS January_20,  -- p1debitamt
	SUM(GL52008) AS February_20,  -- p2debitamt
	SUM(GL52009) AS March_20,  -- p3debitamt
	SUM(GL52010) AS April_20,  -- p4debitamt
	SUM(GL52011) AS May_20,  -- p5debitamt
	SUM(GL52012) AS June_20,  -- p6debitamt
	SUM(GL52013) AS July_20,  -- p7debitamt
	SUM(GL52014) AS August_20,  -- p8debitamt
	SUM(GL52015) AS September_20,  -- p9debitamt
	SUM(GL52016) AS October_20,  -- p10debitamt
	SUM(GL52017) AS November_20,  -- p11debitamt
	SUM(GL52018) AS December_20  -- p12debitamt
FROM GL520121
WHERE GL52002 = 300000 and GL52003='11'
GROUP BY GL52004, GL52003, GL52004
-- HAVING 
-- 	SUM(GL52007)!=0,
--	SUM(GL52008)!=0, 
--	SUM(GL52009)!=0,
--	SUM(GL52010)!=0, 
--	SUM(GL52011)!=0,
--	SUM(GL52012)!=0, 
--	SUM(GL52013)!=0, 
--	SUM(GL52014)!=0,
--	SUM(GL52015)!=0,
--	SUM(GL52016)!=0,
--	SUM(GL52017)!=0,
--	SUM(GL52018)!=0
