create table #workorders
(
	w_workorder nvarchar(10),
	w_stockcode nvarchar(35),
	w_alt nvarchar(2),
	w_wh nvarchar(6),
	w_status int,
	w_plnduedate datetime,
	w_wk int,
	w_closedate datetime,
	w_enddate datetime,
	w_qty numeric(28,8),
	w_reported numeric(28,8),
	w_rest numeric(28,8),
	w_planner nvarchar(15),
	w_matavail int,
	w_text1 nvarchar(15),
	w_text2 nvarchar(15),
	w_text3 nvarchar(15)
)
insert into #workorders
SELECT
    MP64001 AS "WH",  --WO
    MP64002 AS "SKU",  --StockCode
    MP64006 AS "ALT",  --ALT
    MP64003 AS "WH#",  --WH (sort 1 by WH)
    MP64088 AS "STAT",  --Status (select WO's status 3/7 in the last year)
    MP64013,  --Planned Due/End Date
    DATEPART(ISO_WEEK,MP64038) AS "WK",  --Week
    MP64038 AS "WOCLOSEDATE",  --WorkOrder Close Date
    MP64014 AS "ENDDATE",  --Enddate (sort 2 by date within WH. Divid into Before this week/this week/ after this week )
    MP64004 AS "QTY",  --Qty
    MP64005 AS "REPORTED",  --Reported
    MP64093 AS "REST", --Rest
    MP64024 "PLANNER",  --Planner (sort 3)
    MP64067 "MATAVAIL", --Mat Avail
    MP64017 "TEXT1",  --Text1
    MP64018 "TEXT2",  --Text2
    MP64019 "TEXT3"  --Text3
FROM MP640100
WHERE MP64014 >= '2020-10-01'
AND MP64003='40'
ORDER BY MP64003, MP64014, MP64024, MP64038

SELECT * FROM #workorders
DROP TABLE #workorders
