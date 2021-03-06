USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00372_sel_v2]    Script Date: 10/05/2021 14:07:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00372_sel_v2]
	@Warehouse as nvarchar(2)
AS 
BEGIN 

SELECT 
    T1.SC01001    "StockCode" 
 ,  T5.SC03002    "WH" 
 ,  T1.SC01002    "Description1" 
 ,  T1.SC01003    "Description2" 
 ,  T1.SC01053    "StdCostPric1" 
 ,  T2.SC39004    "Price" 
 ,  T1.SC01039    "AccountCode" 
 ,  T3.SY24003    "ProdCat Descr" 
 ,  T4.SY24003    "ProdGrp Descr" 
-- ,  T1.SC01042    "StockBalance" 
 ,  T5.SC03003    "StockBalance" 
 ,  T1.SC01043    "ReservedQty" 
 ,  T1.SC01044    "BackOrdeQty" 
 ,  T1.SC01045    "SCQtyOrder" 
 FROM [ScaCompanyDB]..SC010100 T1 INNER JOIN    [ScaCompanyDB]..SC390100 T2
                                  ON   T1.SC01001 = T2.SC39001
                                  INNER JOIN    [ScaCompanyDB]..SC030100 T5
                                  ON   T1.SC01001 = T5.SC03001
                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T4
                                  ON   T1.SC01037 = T4.SY24002  AND 'IB' = T4.SY24001
                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T3
                                  ON   T1.SC01128 = T3.SY24002  AND 'II' = T3.SY24001
--WHERE T3.SY24003   =  'INDUSTRIAL SALES' AND T5.SC03002 = @Warehouse
--WHERE T3.SY24003   =  'INDUSTRIAL SALES' AND T5.SC03001='42-01-1085'AND T5.SC03002 = '12'
--WHERE T5.SC03001='42-01-1085'AND T2.SC39002=00 AND T5.SC03002 = '01'
--WHERE T3.SY24003   <> '' AND T2.SC39002=00 AND T5.SC03002 = '01'--@Warehouse
WHERE T2.SC39002=00 AND T5.SC03002 = @Warehouse

END