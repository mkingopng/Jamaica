USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00321_sel_com]    Script Date: 10/05/2021 11:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00321_sel_com]

AS 
BEGIN 
SELECT 
    T1.SC01001    "StockCode" 
 ,  T1.SC01002    "Description1" 
 ,  T1.SC01003    "Description2" 
 --,  T3.SC03010    "ROL"
 , SUM(Case When T2.SC07009 =  '13' Then T2.SC07004 End)   "SIT" 
 , SUM(Case When T2.SC07009 =  '03' Then T2.SC07004 End)   "POM" 
 , SUM(Case When T2.SC07009 =  '05' Then T2.SC07004 End)   "LAE" 
 , SUM(Case When T2.SC07009 =  '42' Then T2.SC07004 End)   "WH42" 
 --, SUM(Case When T2.SC07009 =  '13' Then T2.SC07004 End)   "SERVICE" 
 ,  T1.SC01043    "ReservedQty" 
 
 INTO #QRYTMP_91543468
 
 
 FROM [ScaCompanyDB]..SC010100 T1    INNER JOIN    [ScaCompanyDB]..SC070100 T2
                                  ON   T1.SC01001 = T2.SC07003
                                  --   INNER JOIN [ScaCompanyDB]..SC030100 T3
                                  --ON   T1.SC01001=T3.SC03001 
 
WHERE T1.SC01001   IN ('46-04-6512', 
'46-04-6514',
'46-04-6530',
'46-04-6536', 
'46-04-6538', 
'46-04-6543', 
'46-04-6546', 
'46-04-6554', 
'46-04-6556', 
'46-04-6622', 
'46-04-6634', 
'46-04-6700', 
'46-04-6701', 
'46-04-6710', 
'46-04-6800') 
GROUP BY  
   T1.SC01001
 , T1.SC01002
 , T1.SC01003
 , T1.SC01043
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
