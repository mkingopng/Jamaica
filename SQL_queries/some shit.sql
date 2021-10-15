use ScaCompanydb

declare @IntStart datetime =  -- time of the previous record
declare @IntFin datetime =  -- time of the record

SELECT
	SC07007 AS 'WO_number',
	AS 'transation_number'
	SC07002 AS 'Date',
	CAST(SC07036 AS int) AS 'time',  -- convert string into int
	-- CAST(cast((cast(cast(@IntFin AS float) - cast(IntStart AS float) AS int) * 24) + datepart(hh, @IntFin - @IntStart) as varchar(10)) + ':' + right('0' + cast(datepart(mi, @IntFin - @IntStart) as varchar(2)), 2) + ':' + right('0' + cast(datepart(ss, @maxTime - @minTime) as varchar(2)), 2))AS 'Interval',  -- calculate time interval between update entries.
	SC07004 AS 'Quantity',
	SC07037 AS 'User_ID'
FROM SCO70121 INNER JOIN MP640121 ON MP64001=SC07007
WHERE SC07001=00 AND BETWEEN 2021-05-24 AND 2021-05-25
GROUP BY SC07003;

-- WE NOW HAVE AN INTERVAL BETWEEN PRODUCTION UPDATES. INTERVALS SHOULD BE CONSISTENT. 
-- CAN COMPARE ACTUAL OUTPUT VS MACHINE CAPACITY TO MEASURE ONE PARTICULAR WASTE. 
-- PARTICULARLY IN AREAS WHERE DEMAND OUTSTRIPS SUPPLY, ONE OF THE KEY METRICS FOR THE FACTORY 
-- IS MAXIMUM POSSIBLE OUTPUT. EG OIL, TUFFA TANKS, BLEACH, LDP, PAPER, 
