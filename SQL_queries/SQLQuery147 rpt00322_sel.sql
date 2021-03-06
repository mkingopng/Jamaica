USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00322_sel]    Script Date: 10/05/2021 11:24:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00322_sel] 
WITH RECOMPILE 
AS 
BEGIN 
/* ************************************************* */ 

SELECT 
    SC07003    "StockCode" 
 ,  SC01002    "Description1" 
 ,  SC01003    "Description2" 
 ,  SC07001    "Type" 
 ,  SC07002    "Date" 
 ,  SC07002   "MinDate" 
 ,  SUM(SC07004)"Qty" 
 ,  SUM(SC07004)"TotalQty" 
 ,  SC07005    "Cost" 
 ,  SUM(SC07004 * SC07005)   "Amount" 
 ,  SC07009    "WH" 
 , 'Warehousename          '       "WHName"
  INTO #Work322
  FROM [ScaCompanyDB]..SC010100     INNER JOIN    [ScaCompanyDB]..SC070100 
                                  ON   SC01001 = SC07003                                   
  WHERE SC07009   IN('88','90','91','92')
  
  GROUP BY  
	   SC07003
	 , SC01002
	 , SC01003
	 , SC07001
	 , SC07002
	 , SC07005
	 , SC07009
	 
 UPDATE #work322
 SET MINDATE =  (SELECT MIN(SC07002)
	FROM [ScaCompanyDB]..SC070100
	WHERE SC07003 = StockCode
	AND WH = SC07009
	GROUP BY StockCode)
								
UPDATE #work322
SET WHName =  (SELECT Description
				FROM KK_Warehouse 
 			Where WarehouseCode = WH Collate DataBase_Default
				)
				
SELECT Stockcode as wStockcode, WH as wwh, SUM(Qty) as wTotalQty
INTO #work322_2
FROM #work322
GROUP BY Stockcode,wh

UPDATE #work322
SET TotalQty  =  (SELECT wTotalQty
				FROM #work322_2 
			    WHERE StockCode = wStockcode
			    AND WH = wwh)
 			    				
 select * from #WORK322 WHERE TotalQty <> 0 Order By WH,Stockcode,DATE DESC


 

END 
