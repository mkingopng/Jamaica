USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00372_sel]    Script Date: 10/05/2021 14:05:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00372_sel]

AS 
BEGIN 
SELECT 
    T1.SC01001    "StockCode" 
 ,  T1.SC01002    "Description1" 
 ,  T1.SC01003    "Description2" 
 ,  T1.SC01058    "Supplier"
 ,  T1.SC01005    "SellingPrice"
 ,  T1.SC01052    "AvgPrice"
 --,T3.SC03010    "ROL"
 , SUM(Case When T2.SC03002 =  '01' Then T2.SC03003 End)   "LAE Indust" 
 , SUM(Case When T2.SC03002 =  '02' Then T2.SC03003 End)   "LAE Showroom" 
 , SUM(Case When T2.SC03002 =  '03' Then T2.SC03003 End)   "POM W/H" 
 , SUM(Case When T2.SC03002 =  '04' Then T2.SC03003 End)   "POM Showroom" 
 , SUM(Case When T2.SC03002 =  '12' Then T2.SC03003 End)   "SIT POM-LAE" 
 , SUM(Case When T2.SC03002 =  '13' Then T2.SC03003 End)   "SIT LAE-POM" 
  
 --, SUM(Case When T2.SC07009 =  '13' Then T2.SC07004 End)   "SERVICE" 
 ,  T1.SC01043    "ReservedQty" 
 
 INTO #QRYTMP_91543468
 
 
 FROM [ScaCompanyDB]..SC010100 T1    INNER JOIN    [ScaCompanyDB]..SC030100 T2
                                  ON   T1.SC01001 = T2.SC03001
                                  --   INNER JOIN [ScaCompanyDB]..SC030100 T3
                                  --ON   T1.SC01001=T3.SC03001 
 
WHERE T1.SC01038 IN ('IS','II','IC') --   LIKE '46-04%'
--WHERE T1.SC01002   LIKE '%ELECTROLUX%'
  
GROUP BY  
   T1.SC01001
 , T1.SC01002
 , T1.SC01003
 , T1.SC01043
 , T1.SC01005
 , T1.SC01052
 , T1.SC01058 
 
 
 --, T3.SC03010
END 
/* ************************************************ */
/* SELECT THE RESULT FROM QUERY  */
/* ********************************************* */

SELECT * FROM #QRYTMP_91543468 
  

/* ************************************************ */
/* Drop Temp File                                  */
/* ********************************************** */
BEGIN 
DROP TABLE #QRYTMP_91543468 
END 
