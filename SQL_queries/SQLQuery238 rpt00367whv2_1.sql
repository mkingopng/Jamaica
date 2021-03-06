USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00367_sel_WH_v2_1]    Script Date: 10/05/2021 14:00:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00367_sel_WH_v2_1] 
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
 ,  SC03003    "StockBal" 
 ,  SC03057    "AvgCost" 
 ,  SC01074    "ABCCode"
 ,  SC03002    "WH" 
 ,  SC03022    "SuppCode"
 ,  SC01066    "StatusCode"
 ,  SC01128    "ProdCategory"
 ,  SC01038    "AltProdCode"
 ,  SC01023    "Status"

-- , 'Warehousename          '       "WHName"
  
  FROM [ScaCompanyDB]..SC010100     INNER JOIN    [ScaCompanyDB]..SC030100 
                                  ON   SC01001 = SC03001                                   
  WHERE SC03002   =  @Warehouse  and SC03003 >= '0' and SC03001 <> ''--@Warehouse and SC01038 IN ('CS','CI') 
--  WHERE SC03002   =  @Warehouse  and SC03001 <> ''--@Warehouse and SC01038 IN ('CS','CI') 
  
  GROUP BY  
	   SC03001
	 , SC01002
	 , SC01003
	 , SC03003
	 , SC03057
	 , SC03002
	 , SC01074
	 , SC01038
	 , SC03022
	 , SC01060 
	 , SC01066 
	 , SC01128 
	 , SC01023	 
END 
