USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00367_sel_IndDNR_OBS]    Script Date: 10/05/2021 13:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00367_sel_IndDNR_OBS] 
AS 
BEGIN 
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF
SELECT 
    SC01001    "StockCode" 
 ,  SC01002    "Description1" 
 ,  SC01003    "Description2" 
 ,  SC01004    "Price"
 ,  SC01042    "StockBal" 
 ,  SC03002    "WH"
 ,  SC01023    "Status"
 ,  SUM((SC03003 * SC03057)/SC03003)    "AvgCost" 
 ,  SC01038    "AltProd"
 ,  SC03022    "SuppCode"
  FROM [ScaCompanyDB]..SC010100     INNER JOIN    [ScaCompanyDB]..SC030100 
                                  ON   SC01001 = SC03001 
  WHERE SC01001=SC03001 AND SC01038 IN ('IS','II') and SC03003 > 0 and SC03002='01'
  AND SC01023 in ('DNR','OBSOLETE')
  GROUP BY  
	   SC01001
	 , SC01002
	 , SC01003
	 , SC01004
	 , SC01042
	 , SC03002
	 , SC01023
	 , SC03057
	 , SC03002
	 , SC01038
	 , SC03022 
END 