use ScaCompanyDB

SELECT 
	SC07001,
	SC07002 AS 'date',
	DATEPART(MONTH, SC07002) AS 'month',
	SC07003 AS 'stock_code',
	SC07004 AS 'quantity',
	SC07007 AS 'work_order_number'
FROM SC070100
WHERE SC07001='01' AND SC07003='10-01-0047' AND SC07002 BETWEEN '2020-01-01' AND '2021-05-31';

-- notes
-- 3.5% bleach: 10-01-0047
-- rivergum: 15-01-0200
-- IV60 12-01-9110
-- bulk LDP: 10-02-0091
-- 16 gsm recycled paper:

-- SC07001 = 00 incoming goods, 01 outgoing goods, 02 stocktake difference, 03 cost, 04 WH movement
