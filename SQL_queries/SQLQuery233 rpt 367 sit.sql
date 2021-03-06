USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00367_sel_SIT]    Script Date: 10/05/2021 13:59:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00367_sel_SIT] 
--@Warehouse AS NVARCHAR(20)
WITH RECOMPILE 
AS 
BEGIN 
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF

SELECT 
    SC03001    "StockCode" 
 ,  SC01002    "Description1" 
 ,  SC01003    "Description2" 
 ,  SC03003    "StockBal" 
 ,  SC03057    "AvgCost" 
 ,  SC03002    "WH" 
 ,  SC03009	   "StockTakeDate"	
 ,	SC03054	   "DelDate-Supplier"
 ,	SC03055	   "DelDate-Customer"
 ,	SC03056	   "OrdDate-Supplier"
 ,	SC03097	   "LatestConsol"
 ,  SC01038    "AltProd"
 ,  SC03022    "SuppCode"
  FROM [ScaCompanyDB]..SC010100     INNER JOIN    [ScaCompanyDB]..SC030100 
                                  ON   SC01001 = SC03001                                   
  WHERE SC01038 IN ('IS','II')-- SC03002   = @Warehouse  and SC01038 IN ('IS','II') 
  AND SC03002='120' OR SC03002='125' OR SC03002='126'
  GROUP BY  
	   SC03002
     , SC03001
	 , SC01002
	 , SC01003
	 , SC03003
	 , SC03009
	 , SC03054
	 , SC03055
	 , SC03056
	 , SC03057
	 , SC03097	 
	 , SC01038
	 , SC03022 
END 
