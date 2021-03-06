USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00367_sel_SIT_2]    Script Date: 10/05/2021 13:59:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00367_sel_SIT_2] 
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
 ,  PC03001    "OrderNumber"
 ,  PC01015	   "OrderDate"	
 ,	SC03054	   "DelDate-Supplier"
 ,	SC03055	   "DelDate-Customer"
 ,	SC03056	   "OrdDate-Supplier"
 ,	SC03097	   "LatestConsol"
 ,  SC01038    "AltProd"
 ,  SC03022    "SuppCode"
  FROM [ScaCompanyDB]..SC010100     INNER JOIN    [ScaCompanyDB]..SC030100 
                                  ON   SC01001 = SC03001 
                                    INNER JOIN    [ScaCompanyDB]..PC030100
                                  ON   SC01001 = PC03005                                   
                                    INNER JOIN    [ScaCompanyDB]..PC010100
                                  ON   PC03001 = PC01001                                   
  WHERE SC01038 IN ('IS','II','RM')
  AND SC03002 IN ('120','125','126')
  GROUP BY  
	   SC03002
     , SC03001
	 , SC01002
	 , SC01003
	 , SC03003
	 , SC03009
	 , PC03001
	 , PC01015
	 , SC03054
	 , SC03055
	 , SC03056
	 , SC03057
	 , SC03097	 
	 , SC01038
	 , SC03022 
END 
