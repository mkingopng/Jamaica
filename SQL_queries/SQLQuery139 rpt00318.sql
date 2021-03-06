USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00318_sel]    Script Date: 10/05/2021 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 25/01/10
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00318_sel]
	-- Add the parameters for the stored procedure here
	@YearValue NVARCHAR(4),
	@MonthValue CHAR(02) = NULL
AS
/* ************************************************* */

DECLARE @cmd as NVARCHAR(4000),
		@currentmonth as CHAR(7),
		@runvalue as CHAR(7)	
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[KK_RetailSummary]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[KK_RetailSummary]

CREATE TABLE KK_RetailSummary
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
		TotalProdVariance			NUMERIC(28, 8),
		ReportFlag					CHAR(1)
	)	
SET ANSI_NULLS ON
SET NOCOUNT ON

SELECT @runvalue = @YearValue + 'M' + @MonthValue
SELECT @currentmonth = rtrim(cast(datepart(yyyy,GETDATE()) as char))+ 'M' + substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2) 

SELECT @cmd = 'INSERT INTO KK_RetailSummary '
SELECT @cmd = @cmd + 'SELECT '
SELECT @cmd = @cmd +  ' SC01001 '
SELECT @cmd = @cmd +  ',  SC01002 + '' '' + SC01003 '
SELECT @cmd = @cmd +  ',  SUBSTRING(ST03011,13,6) '
SELECT @cmd = @cmd +  ',  GL03003 '
SELECT @cmd = @cmd +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M' + @MonthValue + ''' AND SUBSTRING(ST03011,7,2) = ''14'' Then (ST03020) End)  '
SELECT @cmd = @cmd +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M' + @MonthValue + ''' AND SUBSTRING(ST03011,7,2) = ''24 '' Then (ST03020) End)  '
SELECT @cmd = @cmd +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M' + @MonthValue + ''' AND SUBSTRING(ST03011,7,2) = ''16 '' Then (ST03020) End)  '
SELECT @cmd = @cmd +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M' + @MonthValue + ''' Then (ST03020) End)  '
SELECT @cmd = @cmd +  ', 0, 0, 0, 0, 0, 0, 0 '
SELECT @cmd = @cmd +  'FROM [ScaCompanyDB]..ST030100 '
SELECT @cmd = @cmd +  'INNER JOIN    [ScaCompanyDB]..SC010100 ON   ST03017 = SC01001  '
SELECT @cmd = @cmd +  'INNER JOIN    [ScaCompanyDB]..GL0301' + SUBSTRING(@YearValue,3,2) + ' ON   SUBSTRING(SC01039,13,6) = GL03002 AND GL03001 = ''C''  '
SELECT @cmd = @cmd +  'WHERE SUBSTRING(ST03011,13,6) IN (''ACTDAZ'',''ACJDOM'',''ACTDLP'',''ACHDIA'',''ACDSAC'',''ACTDHR'',''ACMCCR'',''ACHMYS'',''ACLCAT'',''ACHCLE'',''ACHCAR'', ''ACUOIL'') '
SELECT @cmd = @cmd +  'AND rtrim(cast(datepart(yyyy,ST03015) as char)) = ''' + @YearValue + ''' '
SELECT @cmd = @cmd +  'AND NOT SUBSTRING(ST03008,1,4) = ''INTR'''
SELECT @cmd = @cmd +  'GROUP BY  SUBSTRING(ST03011,13,6),GL03003,SC01001, SC01002, SC01003 '
SELECT @cmd = @cmd +  'ORDER BY SUBSTRING(ST03011,13,6), SC01001, SC01002' 
EXEC (@cmd)

IF @runvalue >=@currentmonth 
		BEGIN
			UPDATE KK_RetailSummary
			SET ReportFlag =1
		END
	else
		BEGIN
			UPDATE KK_RetailSummary
			SET ReportFlag =0
		END
		
IF @runvalue <'2010M07' 
		BEGIN
			UPDATE KK_RetailSummary
			SET ReportFlag =2
		END


SELECT @cmd = ' UPDATE KK_RetailSummary '
SELECT @cmd = @cmd +  'SET TotalProdVolume =  (SELECT SUM(Case When rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M' + @MonthValue + '''  Then (SC07004) End)  ' 
SELECT @cmd = @cmd +  'FROM ScaCompanyDB.. SC070100  '
SELECT @cmd = @cmd +  'WHERE SC07003 = oStockCode  COLLATE DATABASE_DEFAULT '
SELECT @cmd = @cmd +  'AND rtrim(cast(datepart(yyyy,SC07002) as char)) = ''' + @YearValue + ''' '
SELECT @cmd = @cmd +  'AND SC07001 = ''00'') '
EXEC (@cmd)

UPDATE KK_RetailSummary
SET  LaeVolume =  0
WHERE LaeVolume is NULL

UPDATE KK_RetailSummary
SET  POMVolume =  0
WHERE POMVolume is NULL

UPDATE KK_RetailSummary
SET  ExportVolume =  0
WHERE ExportVolume is NULL

UPDATE KK_RetailSummary
SET  TotalVolume =  0
WHERE TotalVolume is NULL

UPDATE KK_RetailSummary
SET  TotalProdVolume =  0
WHERE TotalProdVolume is NULL

IF @runvalue >=@currentmonth 
	BEGIN
			IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[KK_RetailSummarywork]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
			DROP TABLE [dbo].[KK_RetailSummarywork]

			CREATE TABLE KK_RetailSummarywork
				(
					wStockCode					NVARCHAR(35),
					wSOH						NUMERIC(28, 8)
				)	
				
			INSERT INTO KK_RetailSummarywork
			SELECT SC03001,SUM(SC03003)
			FROM ScaCompanyDB..SC030100
			GROUP BY SC03001
		
			SELECT @cmd = ' UPDATE KK_RetailSummary '
			SELECT @cmd = @cmd + 'SET TotalOutstandingVolume = (SELECT SUM(OutstandingOrders)  '
			SELECT @cmd = @cmd + 'FROM KK_StockSummary s '
			SELECT @cmd = @cmd + 'WHERE oStockCode = s.StockCode )  '
			--SELECT @cmd = @cmd + 'GROUP BY ostockcode ) '
			--SELECT @cmd
			Exec (@cmd)

			SELECT @cmd = ' UPDATE KK_RetailSummary '
			SELECT @cmd = @cmd + 'SET TotalSOH = (SELECT wSOH  '
			SELECT @cmd = @cmd + 'FROM KK_RetailSummarywork '
			SELECT @cmd = @cmd + 'WHERE oStockCode = wStockCode )  '
			--SELECT @cmd
			Exec (@cmd)
			
			DROP TABLE [dbo].[KK_RetailSummarywork]
	END
ELSE
	BEGIN
			SELECT @cmd = ' UPDATE KK_RetailSummary '
			SELECT @cmd = @cmd + 'SET TotalOutstandingVolume = (SELECT OutstandingOrders  '
			SELECT @cmd = @cmd + 'FROM KK_StockSummary s '
			SELECT @cmd = @cmd + 'WHERE oStockCode = s.StockCode '
			SELECT @cmd = @cmd + 'AND YearMonth = ''' + @RunValue + ''') '
			--SELECT @cmd
			Exec (@cmd)

			SELECT @cmd = ' UPDATE KK_RetailSummary '
			SELECT @cmd = @cmd + 'SET TotalSOH = (SELECT SOH  '
			SELECT @cmd = @cmd + 'FROM KK_StockSummary s '
			SELECT @cmd = @cmd + 'WHERE oStockCode = s.StockCode '
			SELECT @cmd = @cmd + 'AND YearMonth = ''' + @RunValue + ''') '
			--SELECT @cmd
			Exec (@cmd)
	END
	
UPDATE KK_RetailSummary
SET  TotalOutstandingVolume =  0
WHERE TotalOutstandingVolume is NULL

UPDATE KK_RetailSummary
SET  TotalSOH=  0
WHERE TotalSOH is NULL

UPDATE KK_RetailSummary
SET TotalRequirement = TotalVolume + TotalOutstandingVolume

UPDATE KK_RetailSummary
SET TotalAvailability = TotalSOH + TotalProdVolume

UPDATE KK_RetailSummary
SET TotalProdVariance = TotalAvailability - TotalRequirement 

SELECT * FROM KK_RetailSummary 

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[KK_RetailSummary]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[KK_RetailSummary]