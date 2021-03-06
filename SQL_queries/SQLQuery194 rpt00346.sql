USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00346_sel]    Script Date: 10/05/2021 12:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00346_sel] 
--	 ST080100.ST08022, ST080100.ST08024 AS 'Inv No (Batch)'
AS
BEGIN
SELECT 
    T2.PL03001    "SupplierCode" 
 ,  T2.PL03003    "TransactioNo" 
 ,  T2.PL03004    "InvoiceDate" 
 ,  T2.PL03002    "InvoiceNo" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2010M07' Then T2.PL03013  End)   "Jul 2010" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2010M08' Then T2.PL03013  End)   "Aug 2010" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2010M09' Then T2.PL03013  End)   "Sep 2010" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2010M10' Then T2.PL03013  End)   "Oct 2010" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2010M11' Then T2.PL03013  End)   "Nov 2010" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2010M12' Then T2.PL03013  End)   "Dec 2010" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M01' Then T2.PL03013  End)   "Jan 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M02' Then T2.PL03013  End)   "Feb 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M03' Then T2.PL03013  End)   "Mar 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M04' Then T2.PL03013  End)   "Apr 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M05' Then T2.PL03013  End)   "May 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M06' Then T2.PL03013  End)   "Jun 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M07' Then T2.PL03013  End)   "Jul 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M08' Then T2.PL03013  End)   "Aug 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M09' Then T2.PL03013  End)   "Sep 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M10' Then T2.PL03013  End)   "Oct 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M11' Then T2.PL03013  End)   "Nov 2011" 
 , SUM(Case When rtrim(cast(datepart(yyyy,T2.PL03006) as char))+'M'+substring(cast(cast(datepart(mm,T2.PL03006) as INT)+100 as char),2,2) =  '2011M12' Then T2.PL03013  End)   "Dec 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M01' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Jan 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M02' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Feb 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M03' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Mar 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M04' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Apr 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M05' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "May 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M05' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Jun 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M06' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Jul 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M07' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Aug 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M08' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Sep 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M08' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Oct 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M09' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Nov 2011" 
 --, SUM(Case When rtrim(cast(datepart(yyyy,T3.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T3.ST03015) as INT)+100 as char),2,2) =  '2011M010' Then (T3.ST03020 * T3.ST03021) - (T3.ST03020 * T3.ST03021 * T3.ST03022 / 100) End)   "Dec 2011" 

 INTO #temp_DHL_TNT
 
FROM ScaCompanyDB..PL030100 T2 
 
WHERE T2.PL03001   IN('PGKTNT','PGKDHL')
--AND   rtrim(cast(datepart(yyyy,T2.PL03006) as char))   in ('2010','2011')


  
GROUP BY  
   T2.PL03001
  ,T2.PL03002
  ,T2.PL03003
  ,T2.PL03004
-- , T1.SL01002
-- , T2.SC01001
-- , T2.SC01002
-- , T3.ST03014
-- , T3.ST03015
 --ORDER BY T3.ST03015
 select * from #temp_DHL_TNT 
 where rtrim(cast(datepart(yyyy,InvoiceDate) as char))='2011'

 order by InvoiceDate
 END
