use ScaCompanyDB

SELECT 
	SC07020 AS 'GL_trans_number',
	SC07019 AS 'GL_trans_date',
	SUBSTRING(GL06001, 0, 6) AS 'account_#',
	SUBSTRING(SC07012, 6, 3) AS 'CC',
	SUBSTRING(SC07012,12, 8) AS 'alt_product_group',
	-- AS 'debit',
	-- AS 'credit',
	SC07003 AS 'stock_code',
	SC07009 AS 'WH',
	SC07001 AS 'transaction_type',
	SC07008 AS 'cost_type',
	-- AS 'batch_id',
	SC07002 AS 'trans_date',
	SC07007 AS 'order number',
	SC07013 AS 'trans_source',
	SC01002 AS 'product_description'
FROM SC070100
INNER JOIN SC010100 ON SC01001=SC07003
LEFT OUTER JOIN GL060121 ON SC07001=GL06002
WHERE SC07002 BETWEEN '2021-05-21' AND '2021-05-31';