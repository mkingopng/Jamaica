USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00320_sel_v2]    Script Date: 10/05/2021 11:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00320_sel_v2]

AS 
BEGIN 
SELECT 
    T1.SC01001    "StockCode" 
 ,  T1.SC01060    "SuppStockCode" 
 ,  T1.SC01058    "SuppCode"
 --,  T3.PL01002    "SuppDesc"
 ,  T1.SC01002    "Description1" 
 ,  T1.SC01003    "Description2" 
 , SUM(T2.ST03020)   "Qty" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M01' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Jan 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M02' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Feb 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M03' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Mar 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M04' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Apr 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M05' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "May 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M06' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Jun 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M07' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Jul 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M08' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Aug 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M09' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Sep 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M10' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Oct 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M11' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Nov 2009" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T2.ST03015) as INT)+100 as char),2,2) =  '2009M12' Then (T2.ST03020 * T2.ST03021) - (T2.ST03020 * T2.ST03021 * T2.ST03022 / 100) End)   "Dec 2009" 
  
 INTO #QRYTMP_963460
 
 
 FROM --[ScaCompanyDB]..SC010100 T4 inner join [ScaCompanyDB]..PL010100  T3  on T4.SC01058= T3.PL01001, 
 
 [ScaCompanyDB]..ST030100 T2    INNER JOIN    [ScaCompanyDB]..SC010100 T1
                                  ON   T2.ST03017 = T1.SC01001--,
                                  
 WHERE T1.SC01002   LIKE '%Filter%' or T1.SC01002 LIKE '%FILTER%'or T1.SC01002 LIKE 'FILTER%' or T1.SC01002 LIKE '%filter%'or T1.SC01002 LIKE 'filter%'
 --WHERE T1.SC01001   LIKE '46-04%'
  
GROUP BY  
   T1.SC01001
 , T1.SC01002
 , T1.SC01003
  , T1.SC01060 
  ,T1 .SC01058
 --,T3.PL01002
END 
/* ************************************************ */
/* SELECT THE RESULT FROM QUERY  */
/* ********************************************* */

SELECT * FROM #QRYTMP_963460
  

/* ************************************************ */
/* Drop Temp File                                  */
/* ********************************************** */
BEGIN 
DROP TABLE #QRYTMP_963460 
END 
