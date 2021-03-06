USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00380]    Script Date: 10/05/2021 14:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00380]
	
	@Warehouse AS NVARCHAR(4)
AS
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF
DECLARE  @rundate as datetime
DECLARE @1monthago as datetime

SELECT @rundate = (SELECT DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())) )
SELECT @1monthago = (SELECT DATEADD(m,-1,@Rundate))

DROP TABLE dbo.KK_Rpt00380Data
CREATE TABLE dbo.KK_Rpt00380Data
(
   
   su_stockcode nvarchar(35),
   su_trandate Date,
   --su_qty numeric(10,2),
   --su_ORD_No nvarchar(20),
   --su_Reference nvarchar(20),
   --su_WH nvarchar(4),
  -- su_BatchID nvarchar(20),
  -- su_GLFlag nvarchar(2),
  -- su_Flag nvarchar(1),
   suSUMqty numeric(10,2)
   
   
 ) on [PRIMARY] 
 
 CREATE TABLE #KK_Rpt00380Data_1
(
   
   #1su_stockcode nvarchar(35),
   #1su_trandate Date,
   #1su_qty numeric(10,2),
   #1su_ORD_No nvarchar(20),
   #1su_Reference nvarchar(20),
   #1su_WH nvarchar(4),
   #1su_BatchID nvarchar(20),
   #1su_BatchID_2 nvarchar(20),
   #1su_GLFlag nvarchar(2),
   #1su_Flag nvarchar(1),
   #1su_SUMqty numeric(10,2)
   
   
 ) on [PRIMARY] 
 
INSERT INTO #KK_Rpt00380Data_1
SELECT  SC07003,SC07002,SC07004,SC07007,SC07006,SC07009,SC07021,SC07029,SC07017,0,0
FROM ScaCompanyDB..SC070100  WHERE SC07009 = @Warehouse and SC07001 = '04' and SC07004 > 0 --and SC07017 <> ''
AND SC07002 >= '2012-01-01 00:00:00.000' --and SC07003 = '36-31-0261'--and @1monthago --and SC07003 in ('10-05-0515','16-03-8510')
--and SC07003 in ('12-01-8000','16-03-8510','32-05-0470','52-06-9303')

--SELECT * from dbo.KK_Rpt00380Data where su_stockcode = '16-03-8510'
--SELECT * from #KK_Rpt00380Data_1
CREATE TABLE #KK_Rpt00380Data_2
(
   
   #2su_stockcode nvarchar(35),
   #2su_trandate Date,
   #2su_qty numeric(10,2),
   #2su_ORD_No nvarchar(20),
   #2su_Reference nvarchar(20),
   #2su_WH nvarchar(4),
   #2su_BatchID nvarchar(20),
   #2su_BatchID_2 nvarchar(20),
   #2su_GLFlag nvarchar(2),
   #2su_Flag nvarchar(1)
   
   
 ) on [PRIMARY] 

INSERT INTO #KK_Rpt00380Data_2
SELECT  SC07003,SC07002,-(SC07004),SC07007,SC07006,SC07009,SC07021,SC07029,SC07017,0
FROM ScaCompanyDB..SC070100  WHERE SC07009 = @Warehouse and SC07001 = '04' and SC07004 < 0 --and SC07018 <> ''
AND SC07002 >= '2012-01-01 00:00:00.000' --and SC07003 = '36-31-0261'--and @1monthago and SC07003 in ('10-05-0515','16-03-8510')
--and SC07003 in ('12-01-8000','16-03-8510','32-05-0470','52-06-9303')

--SELECT * from #KK_Rpt00380Data_2
--DROP TABLE #KK_Rpt00380Data_3
CREATE TABLE #KK_Rpt00380Data_3
(
   
   #3su_stockcode nvarchar(35),
   #3su_trandate Date,
   #3su_qty numeric(10,2),
   #3su_ORD_No nvarchar(20),
   #3su_Reference nvarchar(20),
   #3su_WH nvarchar(4),
   #3su_BatchID nvarchar(20),
   #3su_BatchID_2 nvarchar(20),
   #3su_GLFlag nvarchar(2),
   #3su_Flag nvarchar(1)
   
   
 ) on [PRIMARY] 
 
--INSERT #KK_Rpt00380Data_3
--SELECT 0,'9999-12-31',0,0,0,0,0,0,0

INSERT #KK_Rpt00380Data_3 
SELECT #2su_stockcode,#2su_trandate,#2su_qty,
#2su_ORD_No, #2su_Reference,#2su_WH, 
#2su_BatchID,#2su_BatchID_2, #2su_GLFlag ,0
FROM  #KK_Rpt00380Data_1 inner join #KK_Rpt00380Data_2 on #1su_stockcode = #2su_stockcode 
where #1su_BatchID = #2su_BatchID  and #1su_qty <> #2su_qty
--group by #2su_stockcode


--SELECT * from #KK_Rpt00380Data_3


--UPDATE #KK_Rpt00380Data_3
--SET #3su_stockcode = #2su_stockcode,#3su_trandate = #2su_trandate,#3su_qty = #2su_qty,
--#3su_ORD_No = #2su_ORD_No, #3su_Reference = #2su_Reference, #3su_WH = #2su_WH, 
--#3su_BatchID = #2su_BatchID, #3su_GLFlag = #2su_GLFlag  
--FROM  #KK_Rpt00380Data_1 inner join #KK_Rpt00380Data_2 on #1su_stockcode = #2su_stockcode 
--where #1su_BatchID = #2su_BatchID and #1su_qty <> #2su_qty
--Group by #1su_stockcode


--SELECT * from #KK_Rpt00380Data_1 inner join #KK_Rpt00380Data_2 on #1su_stockcode = #2su_stockcode 
--where #1su_BatchID = #2su_BatchID and #1su_qty <> #2su_qty 

--SELECT * from #KK_Rpt00380Data_3
 
--UPDATE dbo.KK_Rpt00380Data
--SET su_stockcode  =  SC07003,su_trandate= SC07002,su_qty=SC07004,
--su_ORD_No = SC07007,su_Reference = SC07006,su_WH = SC07009,su_BatchID = SC07021,
--su_GLFlag = SC07017,su_Flag = 0
--FROM ScaCompanyDB..SC070100  WHERE SC07009 = @Warehouse and SC07001 = '04' --and SC07004 > 0 
--and SC07021 = su_BatchID COLLATE DATABASE_DEFAULT and SC07004 <> su_Qty
--AND SC07002 between '2011-01-01 00:00:00.000' and @1monthago --and SC07003 = '15-50-50002'

--SELECT * from dbo.KK_Rpt00380Data where su_stockcode = '16-03-8510'

--INSERT INTO KK_Rpt00380Data
--SELECT  #1su_stockcode,#1su_trandate,#1su_qty,#1su_ORD_No,#1su_Reference,#1su_WH,#1su_BatchID,#1su_GLFlag,#1su_Flag
--FROM #KK_Rpt00380Data_1 inner join ScaCompanyDB..SC070100 on #1su_stockcode = SC07003  WHERE SC07009 = @Warehouse and SC07001 = '04' 
--#1su
--and SC07004 > 0 and SC07018 <> ''
--AND SC07002 between '2011-01-01 00:00:00.000' and @1monthago -

UPDATE #KK_Rpt00380Data_1
SET #1su_Flag  = '1' from ScaCompanyDB..SC070100 
where #1su_stockcode COLLATE DATABASE_DEFAULT = SC07003 and SC07021 = #1su_BatchID  COLLATE DATABASE_DEFAULT --and SC07004 = su_Qty  --su_GLFlag = '4'
and SC07009 = @Warehouse and SC07001 = '04' and SC07004 < 0 --AND SC07002 between '2011-01-01 00:00:00.000' and @1monthago

INSERT INTO #KK_Rpt00380Data_1
SELECT #3su_stockcode,#3su_trandate,-(#3su_qty),#3su_ORD_No, #3su_Reference, #3su_WH, #3su_BatchID,#3su_BatchID_2,
#3su_GLFlag,#3su_Flag,0     
FROM #KK_Rpt00380Data_3 
--SELECT * from #KK_Rpt00380Data_1

UPDATE #KK_Rpt00380Data_1
SET #1su_Flag  = '0' from #KK_Rpt00380Data_3
where #1su_stockcode = #3su_stockcode and #1su_BatchID = #3su_BatchID  COLLATE DATABASE_DEFAULT --and SC07004 = su_Qty  --su_GLFlag = '4'
and #1su_WH = @Warehouse -- and #1su_GLFlag

CREATE TABLE #KK_Rpt00380Data_4
(
   #4su_stockcode nvarchar(35),
   #4su_qty numeric(10,2),
 ) on [PRIMARY]

INSERT INTO #KK_Rpt00380Data_4
SELECT #1su_stockcode,SUM(#1su_qty)
FROM #KK_Rpt00380Data_1 where #1su_Flag  = '0'
GROUP BY #1su_stockcode

UPDATE #KK_Rpt00380Data_1
SET #1su_SUMqty = #4su_qty
FROM #KK_Rpt00380Data_4
where #4su_stockcode = #1su_stockcode --and #1su_BatchID = #3su_BatchID  COLLATE DATABASE_DEFAULT --and SC07004 = su_Qty  --su_GLFlag = '4'
--and #1su_WH = @Warehouse -- and #1su_GLFlag
--INSERT INTO dbo.KK_Rpt00380Data
--SELECT #1su_stockcode,#1su_trandate,SUM(#1su_qty)
--FROM #KK_Rpt00380Data_1
--GROUP BY #1su_stockcode,#1su_trandate



--INSERT INTO dbo.KK_Rpt00380Data
--SELECT #1su_stockcode,#1su_trandate,#1su_qty,#1su_ORD_No, #1su_Reference, #1su_WH, #1su_BatchID,
--#1su_GLFlag,1su_Flag,SUM(#1su_qty)
--FROM #KK_Rpt00380Data_1
--GROUP BY #1su_stockcode,#1su_trandate,#1su_BatchID,#1su_ORD_No,#1su_Reference,#1su_GLFlag,#1su_qty,#1su_WH,#1su_Flag
--SELECT * from #KK_Rpt00380Data_1
--SELECT * from #KK_Rpt00380Data_1


--UPDATE dbo.KK_Rpt00380Data
--SET su_Flag = '1' from ScaCompanyDB..SC070100 
--where su_stockcode COLLATE DATABASE_DEFAULT = SC07003 and SC07017 = '4' 
--and SC07009 = @Warehouse and SC07001 = '04'  AND SC07002 between '2011-01-01 00:00:00.000' and @1monthago
--and su_GLFlag = '4'

--SELECT * from #KK_Rpt00380Data_4 --where #1su_Flag  = '0'


SELECT * from #KK_Rpt00380Data_1 where #1su_Flag  = '0' and #1su_SUMqty <> 0 --and #1su_stockcode ='36-31-0261'
--GROUP BY #1su_stockcode,#1su_BatchID,#1su_trandate,#1su_Reference,#1su_GLFlag,#1su_qty,#1su_WH,#1su_Flag,#1su_ORD_No

--DROP TABLE dbo.KK_Rpt00380Data
--SELECT  SC07001 "TranType",
	--	SC07002 "TranDate"  ,
	--	SC07003 "StockCode" ,  
	--	SC07004 "Qty" ,
	--	SC07006 "Reference",
	--	SC07007 "Order No",
	--	SC07009 "WH",
	--	SC07027 "Stk_For_WH"
		
--FROM ScaCompanyDB..SC070100  WHERE SC07009 = @Warehouse and SC07001 = '04' and SC07004 > 0
 
 
 
 
 
 
 
 
 
 
 
 
-- SELECT * from IscalaAnalysis.. Stockforecast
 
 --END