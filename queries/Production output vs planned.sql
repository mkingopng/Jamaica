use ScaCompanydb
-- declare @IntStart datetime =  -- time of the previous record
--declare @IntFin datetime =  -- time of the record

SELECT
	SC07001,
	SC07007 AS 'WO_number',
	SC07002 AS 'Date',  -- cast to date
	SC07036 AS 'time',  -- convert string into int
	-- CAST(cast((cast(cast(@IntFin AS float) - cast(@IntStart AS float) AS int) * 24) + datepart(hh, @IntFin - @IntStart) as varchar(10)) + ':' + right('0' + cast(datepart(mi, @IntFin - @IntStart) as varchar(2)), 2) + ':' + right('0' + cast(datepart(ss, @maxTime - @minTime) as varchar(2)), 2))AS 'Interval',  -- calculate time interval between update entries.
	DATEPART(MONTH, SC07002) AS 'Month',
	SC07003 AS 'Stock Code',
	SC01002 AS 'Description',
	SC07004 AS 'Quantity',
	SC07009 AS 'Warehouse',
	SC07037 AS 'User_ID',
	MP64004 AS 'Planned Qty',
	MP64005 AS 'Actual Qty'
FROM SC070100 INNER JOIN MP640100 ON MP64001=SC07007 INNER JOIN SC010100 ON SC01001=SC07003
WHERE SC07001=00 AND SC07002 BETWEEN '2020-01-01' AND '2021-05-31';
-- GROUP BY SC07003;
-- HAVING SC07001='0';
