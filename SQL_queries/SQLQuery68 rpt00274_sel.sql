USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00274_sel]    Script Date: 10/05/2021 10:56:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00274_sel]
	@StartDate as Datetime,
	@EndDate as Datetime,
	@CostCentre as NVARCHAR(3),
	@LowValue as Integer 
AS 
-- Quotation Reporting
--Wayne Dunn
--1/1/2010
 
SELECT 
 	OR01001 AS Order#,
	OR01019 AS  Sman, 
	OR01017 AS OurRef, 
  	OR01018 As YourRef,
  	OR01021 AS InvNum,     
	OR01015 AS OrderDate,   
 	OR03002 As Line#,
	OR03005 As StockCode,   
 	OR03006 As Description,  
 	OR03008 as UnitPrice,
 	ST01002 As Salesman, 
	SUM(OR03011) "Qty",
 	SUM(((OR03011 - OR03012) * OR03008) - ((OR03011 - OR03012) * OR03008 * OR03017 / 100)) "Value",   
	SUBSTRING(OR01025,7,2) as CC,
 	SL01001 As CusCode, 
	SL01002 as Customer,
	NULL as OrderTotal,
	CostCentreName
 INTO #Work
  FROM [ScaCompanyDB]..OR010100 
 INNER JOIN    [ScaCompanyDB]..OR030100 
 ON   OR01001 = OR03001
 INNER JOIN    [ScaCompanyDB]..SL010100
 ON   OR01003 = SL01001
 INNER JOIN    KK_CostCentre
 ON   SUBSTRING(OR01025,7,2) = CostCentre Collate Database_default
 INNER JOIN    [ScaCompanyDB]..ST010100
 ON   OR01019 = ST01001
 WHERE OR01002   =  '0'
 AND SUBSTRING(OR01025,7,2) = @CostCentre
 AND OR01015 Between @StartDate and @EndDate
 
GROUP BY  
   	OR01001,
	OR01019,
 	OR01017,
	OR01018,
	OR01021,
	OR01015,
	OR03002,
 	OR03005,
	OR03006,
	OR03008,
	SUBSTRING(OR01025,7,2),
 	SL01001,
	SL01002,
	ST01002,
	CostCentreName
Order BY  OR01001, OR03002

UPDATE #Work
	SET OrderTotal = (SELECT SUM(((OR03011 - OR03012) * OR03008) - ((OR03011 - OR03012) * OR03008 * OR03017 / 100))
	FROM [ScaCompanyDB]..OR030100
	WHERE Order# = OR03001)

SELECT * FROM #Work
WHERE OrderTotal >= @LowValue