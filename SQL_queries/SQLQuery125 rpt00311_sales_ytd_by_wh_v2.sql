USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00311_SalesYTD_By_WH_v2]    Script Date: 10/05/2021 11:17:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00311_SalesYTD_By_WH_v2] 
		@Warehouse Nvarchar(2),
	    @Thisyearvalue integer
AS
	SET NOCOUNT ON;

SELECT 
    T1.SC01001    "StockCode" 
 ,  T1.SC01002    "Description1" 
 ,  T1.SC01003    "Description2" 
 ,  T2.ST03029	  "WH"
 ,	CAST( @ThisYearValue as CHAR(4)) "Year"
 ,	SUBSTRING(SC01039,13,6) "AccountCode"
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M01' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Jan" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M01' Then T2.ST03020 End)   "Jan_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M02' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Feb" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M02' Then T2.ST03020 End)   "Feb_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M03' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Mar" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M03' Then T2.ST03020 End)   "Mar_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M04' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Apr" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M04' Then T2.ST03020 End)   "Apr_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M05' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "May" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M05' Then T2.ST03020 End)   "May_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M06' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Jun" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M06' Then T2.ST03020 End)   "Jun_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M07' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Jul" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M07' Then T2.ST03020 End)   "Jul_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M08' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Aug" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M08' Then T2.ST03020 End)   "Aug_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M09' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Sep" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M09' Then T2.ST03020 End)   "Sep_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M10' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Oct" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M10' Then T2.ST03020 End)   "Oct_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M11' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Nov" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M11' Then T2.ST03020 End)   "Nov_Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M12' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Dec" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  CAST (@Thisyearvalue as CHAR(4)) +'M12' Then T2.ST03020 End)   "Dec_Qty" 
 FROM [ScaCompanyDB]..ST030100 T2    INNER JOIN    [ScaCompanyDB]..SC010100 T1
                                  ON   T2.ST03017 = T1.SC01001
--WHERE T1.SC01001   =  T2.ST03017
--WHERE T1.SC01001   =  '46-05-0080'
WHERE rtrim(cast(datepart(yyyy,ST03015) as char)) = CAST( @ThisYearValue as CHAR(4))
AND T2.ST03029= @Warehouse
AND SUBSTRING(ST03008,1,4) <>  'INTR'
AND NOT SUBSTRING(SC01039,13,6) = 'AIXFRU'
AND NOT SUBSTRING(SC01039,13,6) = 'RAWMAT' 
AND NOT SUBSTRING(SC01039,13,6) = 'AIXPAL' 
AND T1.SC01001   IS NOT NULL
AND T1.SC01001 <> ''

GROUP BY T1.SC01001, T1.SC01002, T1.SC01003, T1.SC01039, T2.ST03029
