SELECT
	GL52002 as account_number,  
	GL52003 as cc,
	GL52004 as alt_product_group,
	GL52025 as January_20,  -- p1creditamt 
	GL52026 as February_20,  -- p2creditamt
	GL52027 as March_20,  -- p3creditamt
	GL52028 as April_20,  -- p4creditamt
	GL52029 as May_20,  -- p5creditamt
	GL52030 as June_20,  -- p6creditamt
	GL52031 as July_20,  -- p7creditamt
	GL52032 as August_20,  -- p8creditamt
	GL52033 as September_20,  -- p9creditamt
	GL52034 as October_20,  -- p10creditamt
	GL52035 as November_20,  -- p11creditamt
	GL52036 as December_20  -- p12creditamt
	
FROM GL520121
WHERE GL52002 = 001021 and GL52003='11';

-- GL520121 is the year specific table that holds all the GL transactions for 2021. each year has its own specific table.
-- three 'key' columns, account number (GL52002), cost centre(GL52003) and alt product group(APG)(GL52004)
-- sales and cogs are both acc number 001021.
-- altproductgroup (APG) designates the product group
-- with this table and keys we can reproduce the profit & loss statements.

-- is there a sql equivalent of dropna()?