use ScaCompanyDB

SELECT
	SC07001,
	SC07007 AS 'WO_number',
	SC07002 AS 'Date',
	SC07036 AS 'time',
	rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) 'as month/year',
	SC07003 AS 'Stock Code',
	SC01002 AS 'Description',
	(SC07004*-1) AS 'Quantity',
	SC07009 AS 'Warehouse'
	-- SC07037 AS 'User_ID',
	-- MP64004 AS 'Planned Qty',
	-- MP64005 AS 'Actual Qty'
FROM SC070100  INNER JOIN SC010100 ON SC01001=SC07003
WHERE (SC07003='10-01-0047' or SC07003='15-01-0200' OR SC07003='10-11-8023' OR SC07003='12-01-9110' or SC07003='10-11-8023' or SC07003='10-11-8023' or SC07003='10-11-8050' or SC07003='10-11-9250' or SC07003='10-11-7036') AND SC07002 BETWEEN '2020-01-01' AND '2021-05-31';


-- INNER JOIN MP640100 ON MP64001=SC07007
-- bleach 3.5% = 10-01-0047
-- rivergum = 15-01-0200
-- iv60 oil = 12-01-9110
-- 16gsm recycled paper = '10-11-8023'
-- 15 gsm 1 ply virgin = '10-11-8048'
-- 14 gsm 2 ply virgin = '10-11-8050'
-- 23 gsm = '10-11-9250'
-- 40gsm = '10-11-7036'