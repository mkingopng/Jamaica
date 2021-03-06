USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00301_Detergent]    Script Date: 10/05/2021 11:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00301_Detergent] 
	@Year			NVARCHAR(256) 
AS	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF
--drop table #workdata240	
DECLARE @Command as NVARCHAR(4000)
	,@Month1 as  NVARCHAR(10)
	,@Month2 as  NVARCHAR(10)
	,@Month3 as  NVARCHAR(10)
	,@Month4 as  NVARCHAR(10)
	,@Month5 as  NVARCHAR(10)
	,@Month6 as  NVARCHAR(10)	
	,@Month7 as  NVARCHAR(10)
	,@Month8 as  NVARCHAR(10)
	,@Month9 as  NVARCHAR(10)
	,@Month10 as NVARCHAR(10)
	,@Month11 as NVARCHAR(10)
	,@Month12 as NVARCHAR(10)
	,@Month1_Name as NVARCHAR(10)
	,@Month2_Name as NVARCHAR(10)
	,@Month3_Name as NVARCHAR(10)
	,@Month4_Name as NVARCHAR(10)
	,@Month5_Name as NVARCHAR(10)
	,@Month6_Name as NVARCHAR(10)
	,@Month7_Name as NVARCHAR(10)
	,@Month8_Name as NVARCHAR(10)
	,@Month9_Name as NVARCHAR(10)
	,@Month10_Name as NVARCHAR(10)
	,@Month11_Name as NVARCHAR(10)
	,@Month12_Name as NVARCHAR(10)
   --,@Year as NVARCHAR(10)
-- Calculate Dates
--Select @Year='2010'

IF @Year IS NULL	
	SELECT @Year = Year(Getdate())
	
Select @Year=cast(datepart(mm,GETDATE()) as varCHAR(4))+ '/' + cast(datepart(dd,GETDATE()) as varCHAR(2)) + '/' + @Year
SELECT @Month1 =  rtrim(cast(datepart(yyyy,DATEADD(m,-12,@Year)) as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-12,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month2 =  rtrim(cast(datepart(yyyy,DATEADD(m,-11,@Year)) as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-11,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month3 =  rtrim(cast(datepart(yyyy,DATEADD(m,-10,@Year)) as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-10,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month4 =  rtrim(cast(datepart(yyyy,DATEADD(m,-9,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-9,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month5 =  rtrim(cast(datepart(yyyy,DATEADD(m,-8,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-8,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month6 =  rtrim(cast(datepart(yyyy,DATEADD(m,-7,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-7,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month7 =  rtrim(cast(datepart(yyyy,DATEADD(m,-6,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-6,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month8 =  rtrim(cast(datepart(yyyy,DATEADD(m,-5,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-5,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month9 =  rtrim(cast(datepart(yyyy,DATEADD(m,-4,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-4,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month10 = rtrim(cast(datepart(yyyy,DATEADD(m,-3,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-3,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month11 = rtrim(cast(datepart(yyyy,DATEADD(m,-2,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-2,@Year)) as INT)+100 as char),2,2) 	
SELECT @Month12 = rtrim(cast(datepart(yyyy,DATEADD(m,-1,@Year))  as char))+ 'M' + substring(cast(cast(datepart(mm,DATEADD(m,-1,@Year)) as INT)+100 as char),2,2) 
SELECT @Month1_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month1,4)+right(@Month1,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-12,@Year)) as char)))
SELECT @Month2_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month2,4)+right(@Month2,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-11,@Year)) as char)))
SELECT @Month3_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month3,4)+right(@Month3,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-10,@Year)) as char)))
SELECT @Month4_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month4,4)+right(@Month4,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-9,@Year)) as char)))
SELECT @Month5_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month5,4)+right(@Month5,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-8,@Year)) as char)))
SELECT @Month6_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month6,4)+right(@Month6,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-7,@Year)) as char)))
SELECT @Month7_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month7,4)+right(@Month7,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-6,@Year)) as char)))
SELECT @Month8_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month8,4)+right(@Month8,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-5,@Year)) as char)))
SELECT @Month9_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month9,4)+right(@Month9,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-4,@Year)) as char)))
SELECT @Month10_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month10,4)+right(@Month10,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-3,@Year)) as char)))
SELECT @Month11_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month11,4)+right(@Month11,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-2,@Year)) as char)))
SELECT @Month12_Name=(SELECT left(cast(DateName(MONTH,CONVERT(VARCHAR(30),left(@Month12,4)+right(@Month12,2)+'01',101)) as CHAR),3) + rtrim(cast(datepart(yyyy,DATEADD(m,-1,@Year)) as char)))

--Drop table [IscalaAnalysis].[KINGSTON\1168].temptable
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#workdata240]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
Begin
	DROP TABLE [dbo].[#workdata240]
End
--IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[[IscalaAnalysis].[KINGSTON\1168].temptable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
--Begin
--DROP TABLE [IscalaAnalysis].[KINGSTON\1168].temptable
--End

SELECT 
    T1.SC01001    "StockCode" 
 ,  T1.SC01002   "Description" 
 ,  T2.SC07009   "WareHouse"
 --,  T3.ST03002    "WareHouse" 
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month1 Then T2.SC07004 End))   "Sales_Month1" 
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month2 Then T2.SC07004 End))   "Sales_Month2" 
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month3 Then T2.SC07004 End))   "Sales_Month3" 
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month4 Then T2.SC07004 End))   "Sales_Month4" 
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month5 Then T2.SC07004 End))   "Sales_Month5"
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month6 Then T2.SC07004 End))   "Sales_Month6"
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month7 Then T2.SC07004 End))   "Sales_Month7"
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month8 Then T2.SC07004 End))   "Sales_Month8"
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month9 Then T2.SC07004 End))   "Sales_Month9"
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month10 Then T2.SC07004 End))   "Sales_Month10"
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month11 Then T2.SC07004 End))   "Sales_Month11" 
,ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month12 Then T2.SC07004 End))   "Sales_Month12" 
,  NULL "Prod_Month1"
,  NULL "Prod_Month2"
,  NULL "Prod_Month3"
,  NULL "Prod_Month4"
,  NULL "Prod_Month5"
,  NULL "Prod_Month6"
,  NULL "Prod_Month7"
,  NULL "Prod_Month8"
,  NULL "Prod_Month9"
,  NULL "Prod_Month10"
,  NULL "Prod_Month11"
,  NULL "Prod_Month12"
,  NULL "Month_Year"
INTO #workdata240
 FROM [ScaCompanyDB]..SC070100 T2    
 INNER JOIN    [ScaCompanyDB]..SC010100 T1
                                  ON   T2.SC07003 = T1.SC01001
 --INNER JOIN    [ScaCompanyDB]..ST030100 T3
 --                                 ON   T3.ST03017 = T2.SC07003
--INNER JOIN    [ScaCompanyDB]..SC070100 T3
--                                 ON   T1.SC01001 = T3.SC07003
WHERE T2.SC07001='01' And T2.SC07009 in ('05','03') And T2.SC07012 LIKE '%ACTDLP'
GROUP BY  
   T1.SC01001
 , T1.SC01002
 ,T2.SC07009
 --, T3.ST03002
 --, T3.SC07004
 order by  T1.SC01001  

--create table [IscalaAnalysis].[KINGSTON\1168].temptable
--	(
--		Month_Year			nvarchar(30),
--		Lae					NUMERIC(20,4),
--		Pom					NUMERIC(20,4),
--	)
UPDATE #workdata240
Set Prod_Month1 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month1 Then SC07004 End))
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month2 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month2 Then SC07004 End)) 
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month3 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month3 Then SC07004 End))  
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month4 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month4 Then SC07004 End)) 
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month5 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month5 Then SC07004 End))
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month6 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month6 Then SC07004 End)) 
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month7 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month7 Then SC07004 End))
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month8 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month8 Then SC07004 End)) 
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month9 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month9 Then SC07004 End)) 
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month10 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month10 Then SC07004 End))
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month11 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month11 Then SC07004 End)) 
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )
UPDATE #workdata240
Set Prod_Month12 = (SELECT ABS(SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+'M'+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  @Month12 Then SC07004 End)) 
FROM [ScaCompanyDB]..SC070100 WHERE SC07003=StockCode And SC07001='00' And SC07009=WareHouse And SC07012 LIKE '%ACTDLP' )

 
--, SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month1 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month1" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M01' Then T2.ST03020 End)   "Jan 09 Qty" 
--, SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month2 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month2" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M02' Then T2.ST03020 End)   "Feb 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month3 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month3" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M03' Then T2.ST03020 End)   "Mar 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month4 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month4" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M04' Then T2.ST03020 End)   "Apr 09 Qty" 
--, SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month5 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month5" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M05' Then T2.ST03020 End)   "May 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month6 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month6" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M06' Then T2.ST03020 End)   "Jun 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month7 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month7" 
--, SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M07' Then T2.ST03020 End)   "Jul 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month8 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month8" 
--, SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M08' Then T2.ST03020 End)   "Aug 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month9 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month9" 
-- ,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M09' Then T2.ST03020 End)   "Sep 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month10 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month10" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M10' Then T2.ST03020 End)   "Oct 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month11 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month11" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M11' Then T2.ST03020 End)   "Nov 09 Qty" 
--,SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  @Month12 Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Month12" 
-- , SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2) =  '2010M12' Then T2.ST03020 End)   "Dec 09 Qty" 


 ----insert [IscalaAnalysis].[KINGSTON\1168].temptable
SELECT @Command = 'delete from [IscalaAnalysis].[KINGSTON\1168].temptable'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + '''' +  @Month1_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + '''' + @Month2_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month3_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month4_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month5_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month6_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month7_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month8_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month9_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month10_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month11_Name + ''',NULL,NULL)'
EXEC (@command)
SELECT @Command = 'INSERT INTO [IscalaAnalysis].[KINGSTON\1168].temptable values('
SELECT @Command =@Command + ''''+ @Month12_Name + ''',NULL,NULL)'
EXEC (@command)
---------for Lae
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month1) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month1_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month2) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month2_Name + ''''
EXEC (@command)  
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month3) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month3_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month4) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month4_Name + ''''
EXEC (@command)  
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month5) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month5_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month6) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month6_Name + ''''
EXEC (@command)  
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month7) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month7_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month8) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month8_Name + ''''
EXEC (@command) 
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month9) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month9_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month10) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month10_Name + ''''
EXEC (@command)  
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month11) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month11_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Lae = (SELECT SUM(Sales_Month12) FROM #workdata240 WHERE WareHouse = ''05'' ) 
Where Month_Year='''+ @Month12_Name + ''''
EXEC (@command) 
-----------------for POM
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month1) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month1_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month2) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month2_Name + ''''
EXEC (@command)  
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month3) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month3_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month4) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month4_Name + ''''
EXEC (@command)  
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month5) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month5_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month6) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month6_Name + ''''
EXEC (@command)  
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month7) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month7_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month8) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month8_Name + ''''
EXEC (@command) 
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month9) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month9_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month10) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month10_Name + ''''
EXEC (@command)  
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month11) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month11_Name + ''''
EXEC (@command)
SELECT @command = 'UPDATE [IscalaAnalysis].[KINGSTON\1168].temptable '
SELECT @command = @command + 'Set Pom = (SELECT SUM(Sales_Month12) FROM #workdata240 WHERE WareHouse = ''03'' ) 
Where Month_Year='''+ @Month12_Name + ''''
EXEC (@command)

SELECT * FROM #workdata240


END
