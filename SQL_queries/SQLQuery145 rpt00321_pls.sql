USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00321_sel_pls]    Script Date: 10/05/2021 11:24:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00321_sel_pls]

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
 --, SUM(Case When T2.SC07009 =  '13' Then T2.SC07004 End)   "SERVICE" 
 ,  T1.SC01043    "ReservedQty" 
 
 FROM [ScaCompanyDB]..SC010100 T1    INNER JOIN    [ScaCompanyDB]..SC070100 T2
                                  ON   T1.SC01001 = T2.SC07003
                                  --   INNER JOIN [ScaCompanyDB]..SC030100 T3
                                  --ON   T1.SC01001=T3.SC03001 
 
--WHERE T1.SC01001   LIKE '46-04%'
WHERE T1.SC01001   IN (
'11-01-0012',
'11-01-0008',
'11-01-0019',
'11-01-0011',
'11-01-0026',
'11-01-0013',
'11-01-0004',
'11-01-0030',
'11-01-0050',
'11-01-0060',
'11-01-0021',
'11-01-0022',
'11-01-0024',
'11-01-0025'
)
  
GROUP BY  
   T1.SC01001
 , T1.SC01002
 , T1.SC01003
 , T1.SC01043
 --, T3.SC03010
END 
