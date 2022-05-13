-- for production
	-- throughput ACTUAL VS PLANNED OR ACTUAL VS POTENTIAL?
	-- manufacturing variances
	-- waste

-----------------------------------------------------------------------------------
-- look at the trend in output for key product groups

-- thoughput actual vs planned by factory
use ScaCompanydb

SELECT 
	MP64001 AS 'Work_Order_No',
	MP64002 AS 'Stock_Code', 
	MP64003 AS 'Warehouse',
	MP64004 AS 'Planned_Qty',
	MP64005 AS 'Manufactured_Qty',
	MP64005 - MP64004 AS 'DELTA'
	MP64005 / MP64004 AS '%_ATTAINMENT'
	MP64012 AS 'Planned_Start_Date',
	MP64013 AS 'Plan_Due_Date',
	MP64014 AS 'Due_Date'
FROM MP640121
WHERE 
GROUP BY MP64003
ORDER BY MP64014;  
-- use warehouse as a proxy for factory. generate a report for each factory.s

-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------

-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- throughput actual vs potential


-----------------------------------------------------------------------------
-- manufacturing variances (daybooks)


-----------------------------------------------------------------------------

