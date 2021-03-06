USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00319_sel]    Script Date: 10/05/2021 11:22:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 25/01/10
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00319_sel]
	-- Add the parameters for the stored procedure here
	@YearValue NVARCHAR(4)= NULL
AS
/* ************************************************* */

DECLARE @cmd as NVARCHAR(4000),
		@runvalue as CHAR(7)	
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[KK_AnnualRetailSummary]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[KK_AnnualRetailSummary]

CREATE TABLE KK_AnnualRetailSummary
	(
		oStockCode					NVARCHAR(35),
		Description					NVARCHAR(51),
		AccountGrp					NCHAR(10),
		AccountGrpDescription       NVARCHAR(35),	
		LaeVolume					NUMERIC(28, 8),		
		POMVolume					NUMERIC(28, 8),	
		ExportVolume				NUMERIC(28, 8),	
		TotalVolume					NUMERIC(28, 8),	
		TotalOutstandingVolume		NUMERIC(28, 8),
		TotalRequirement			NUMERIC(28, 8),
		TotalSOH					NUMERIC(28, 8),
		TotalProdVolume				NUMERIC(28, 8),
		TotalAvailability			NUMERIC(28, 8),
		TotalProdVariance			NUMERIC(28, 8)
	)	
SET ANSI_NULLS ON
SET NOCOUNT ON



SELECT @cmd = 'INSERT INTO KK_AnnualRetailSummary '
SELECT @cmd = @cmd + 'SELECT '
SELECT @cmd = @cmd +  ' SC01001 '
SELECT @cmd = @cmd +  ',  SC01002 + '' '' + SC01003 '
SELECT @cmd = @cmd +  ',  SUBSTRING(SC01039,13,6) '
SELECT @cmd = @cmd +  ',  GL03003 '
SELECT @cmd = @cmd +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + @yearvalue +  ''' AND SUBSTRING(ST03011,7,2) = ''14'' Then (ST03020) End)  '
SELECT @cmd = @cmd +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + @yearvalue +  ''' AND SUBSTRING(ST03011,7,2) = ''24 '' Then (ST03020) End)  '
SELECT @cmd = @cmd +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + @yearvalue +  ''' AND SUBSTRING(ST03011,7,2) = ''16 '' Then (ST03020) End)  '
SELECT @cmd = @cmd +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + @yearvalue +  ''' AND SUBSTRING(ST03011,7,2) = ''16 ''Then (ST03020) End)  '
SELECT @cmd = @cmd +  ', 0, 0, 0, 0, 0, 0 '
SELECT @cmd = @cmd +  'FROM [ScaCompanyDB]..ST030100 '
SELECT @cmd = @cmd +  'INNER JOIN    [ScaCompanyDB]..SC010100 ON   ST03017 = SC01001  '
SELECT @cmd = @cmd +  'INNER JOIN    [ScaCompanyDB]..GL0301' + SUBSTRING(@YearValue,3,2) + ' ON   SUBSTRING(SC01039,13,6) = GL03002 AND GL03001 = ''C''  '
SELECT @cmd = @cmd +  'WHERE SUBSTRING(ST03011,13,6) IN (''ACTDAZ'',''ACJDOM'',''ACTDLP'',''ACHDIA'') '
SELECT @cmd = @cmd +  'AND NOT SUBSTRING(ST03008,1,4) = ''INTR'''
SELECT @cmd = @cmd +  'GROUP BY  SUBSTRING(SC01039,13,6),GL03003,SC01001, SC01002, SC01003 '
SELECT @cmd = @cmd +  'ORDER BY SUBSTRING(SC01039,13,6), SC01001, SC01002' 
EXEC (@cmd)

SELECT @cmd = ' UPDATE KK_AnnualRetailSummary '
SELECT @cmd = @cmd +  'SET TotalProdVolume =  (SELECT SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char)) =  ''' + @yearvalue + '''  Then (SC07004) End)  ' 
SELECT @cmd = @cmd +  'FROM ScaCompanyDB.. SC070100  '
SELECT @cmd = @cmd +  'WHERE SC07003 = oStockCode  COLLATE DATABASE_DEFAULT '
SELECT @cmd = @cmd +  'AND SC07001 = ''00'') '
EXEC (@cmd)

UPDATE KK_AnnualRetailSummary
SET  LaeVolume =  0
WHERE LaeVolume is NULL

UPDATE KK_AnnualRetailSummary
SET  POMVolume =  0
WHERE POMVolume is NULL

UPDATE KK_AnnualRetailSummary
SET  ExportVolume =  0
WHERE ExportVolume is NULL

UPDATE KK_AnnualRetailSummary
SET  TotalVolume =  0
WHERE TotalVolume is NULL

UPDATE KK_AnnualRetailSummary
SET  TotalProdVolume =  0
WHERE TotalProdVolume is NULL



SELECT @cmd = ' UPDATE KK_AnnualRetailSummary '
SELECT @cmd = @cmd + 'SET TotalOutstandingVolume = (SELECT SUM(OutstandingOrders)  '
SELECT @cmd = @cmd + 'FROM KK_StockSummary s '
SELECT @cmd = @cmd + 'WHERE oStockCode = s.StockCode '
SELECT @cmd = @cmd + 'AND  SUBSTRING(YearMonth,1,4)= ''' + @YearValue + ''' '
SELECT @cmd = @cmd +  'GROUP BY StockCode) '
--SELECT @cmd
Exec (@cmd)

SELECT @cmd = ' UPDATE KK_AnnualRetailSummary '
SELECT @cmd = @cmd + 'SET TotalSOH = (SELECT SUM(SOH)  '
SELECT @cmd = @cmd + 'FROM KK_StockSummary s '
SELECT @cmd = @cmd + 'WHERE oStockCode = s.StockCode '
SELECT @cmd = @cmd + 'AND  SUBSTRING(YearMonth,1,4)= ''' + @YearValue + ''' '
SELECT @cmd = @cmd +  'GROUP BY StockCode) '
--SELECT @cmd
Exec (@cmd)

UPDATE KK_AnnualRetailSummary
SET  TotalOutstandingVolume =  0
WHERE TotalOutstandingVolume is NULL

UPDATE KK_AnnualRetailSummary
SET  TotalSOH =  0
WHERE TotalSOH is NULL

UPDATE KK_AnnualRetailSummary
SET TotalRequirement = TotalVolume + TotalOutstandingVolume

UPDATE KK_AnnualRetailSummary
SET TotalProdVariance = TotalRequirement - TotalProdVolume



SELECT * FROM KK_AnnualRetailSummary 