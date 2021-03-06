USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00367_sel_IndPRC]    Script Date: 10/05/2021 13:37:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00367_sel_IndPRC] 
@Warehouse AS NVARCHAR(20)
WITH RECOMPILE 
AS 
BEGIN 
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF
SELECT 
    SC03001    "StockCode" 
 ,  SC01002    "Description1" 
 ,  SC01003    "Description2" 
 ,  SC39004    "Price"
 ,  SC03003    "StockBal" 
 ,  SC03057    "AvgCost" 
 ,  SC03002    "WH" 
 ,  SC01038    "AltProd"
 ,  SC03022    "SuppCode"
-- , 'Warehousename          '       "WHName"
  
  FROM [ScaCompanyDB]..SC010100     INNER JOIN    [ScaCompanyDB]..SC030100 
                                  ON   SC01001 = SC03001                                   
									INNER JOIN    [ScaCompanyDB]..SC390100 
                                  ON   SC01001 = SC39001                                   

  WHERE SC03002   = @Warehouse  and SC01038 IN ('IS','II') and SC39002 = '00' and SC39001 LIKE '52-05-%'
  
  GROUP BY  
	   SC03001
	 , SC01002
	 , SC01003
	 , SC39004
	 , SC03003
	 , SC03057
	 , SC03002
	 , SC01038
	 , SC03022 
END 
