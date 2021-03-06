USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00303]    Script Date: 10/05/2021 11:07:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: <Create Date,,>
-- Description:	Extract Stock for Plastics Reporting
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00303] 
	@StartDate as Datetime,
	@EndDate as Datetime
AS

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT	OR01001 as Order#,
			OR01002 as OrderType,
			OR01003 as CustomerCode,
			SC01002 as Description,
			OR03005 as StockCode,
			SC01038 as AltPrdGrp,
			OR01050 as Warehouse,
			OR03011 as OrderQtyOrder,
			OR01015 as OrderDate,
			OR01021 as Invoice#, 
			OR03008 as UnitPrice,
			OR03012 as QtyShipped, 
			OR01016 as DelDate,
			NULL as StockBal,
			SUBSTRING(OR03028,7,6)as CostCentre,	
			CostCentreName,
			(OR03008 * OR03011) as Value,
			1 as LineCount,
			0 as FullFilledCount
 Into #kkwork			
 FROM   ScaCompanyDB..SC010100 
 INNER JOIN ScaCompanyDB..SC030100
 ON SC01001=SC03001
 INNER JOIN ScaCompanyDB..OR030100 
 ON (SC03001=OR03005) AND (SC03002=OR03046)
 INNER JOIN ScaCompanyDB..OR010100
 ON OR03001=OR01001
 INNER JOIN KK_CostCentre
 ON SUBSTRING(OR03028,7,6) =  CostCentre collate database_default
 WHERE  
 (SC01001 LIKE '16%' OR SC01001 LIKE '18%')
 AND 
 OR01002<>0 
 AND (OR01015 BETWEEN @StartDate and @EndDate)
 
 Update #kkwork
 Set StockBal =(SELECT SUM(SC03003)
 FROM ScaCompanyDB..SC030100
 WHERE StockCode = SC03001 collate database_default
 AND SC03002 <> 21)

 
 Update #kkwork
 Set FullFilledCount = 1
 WHERE OrderQtyOrder <= StockBal

 
 SELECT * FROM #kkwork ORder By FullFilledCount Asc
 

