use ScaCompanyDB

SELECT
	SC01001 AS 'stockcode',
	SC01002 AS 'description 1',
	SC01003 AS 'description 2',
	SC03003 AS 'QUANTITY'
FROM SC010100
inner join SC030100 on SC03001=SC01001
WHERE SC01001 LIKE '85-%';
-- AND SC03003=0;

