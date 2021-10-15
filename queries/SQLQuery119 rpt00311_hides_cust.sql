USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00311_Hides_Cust]    Script Date: 10/05/2021 11:15:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Manish Yadav
-- Create date: 05/03/2013
-- Description:	extract all sales data but customer for this year and last year
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00311_Hides_Cust] 
		--@Department	 as NVARCHAR(256),
		@Thisyearvalue integer
		--@AreaCode NVARCHAR(3) = NULL
		
AS
	DECLARE @cmd as VARCHAR(8000),
			@cmd2 as VARCHAR(8000),
			@CostCentre as NVARCHAR(64),
			@Single as bit
		

   -- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS311]
	
	CREATE TABLE [dbo].[work_SSRS311](
	[CustomerCode] [nchar](10) NOT NULL,
	[CustomerName] [nvarchar](35) NOT NULL,
	--[Salesman] [nvarchar](100) NULL,
	--[Location] NVARCHAR(3),
	[CostCentre] NVARCHAR(3),
	[StockCode] [nvarchar](35) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	--[Department] [nvarchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[AccountCode] [nvarchar](6) NULL,
	[AccountName] [nvarchar](50) NULL,
	[Jan] [numeric](38, 6) NULL,
	[Feb] [numeric](38, 6) NULL,
	[Mar] [numeric](38, 6) NULL,
	[Apr] [numeric](38, 6) NULL,
	[May] [numeric](38, 6) NULL,
	[Jun] [numeric](38, 6) NULL,
	[Jul] [numeric](38, 6) NULL,
	[Aug] [numeric](38, 6) NULL,
	[Sep] [numeric](38, 6) NULL,
	[Oct] [numeric](38, 6) NULL,
	[Nov] [numeric](38, 6) NULL,
	[Dec] [numeric](38, 6) NULL,
	[Jan Qty] [numeric](38, 8) NULL,
	[Feb Qty] [numeric](38, 8) NULL,
	[Mar Qty] [numeric](38, 8) NULL,
	[Apr Qty] [numeric](38, 8) NULL,
	[May Qty] [numeric](38, 8) NULL,
	[Jun Qty] [numeric](38, 8) NULL,
	[Jul Qty] [numeric](38, 8) NULL,
	[Aug Qty] [numeric](38, 8) NULL,
	[Sep Qty] [numeric](38, 8) NULL,
	[Oct Qty] [numeric](38, 8) NULL,
	[Nov Qty] [numeric](38, 8) NULL,
	[Dec Qty] [numeric](38, 8) NULL,
	[Jan GP] [numeric](38, 8) NULL,
	[Feb GP] [numeric](38, 8) NULL,
	[Mar GP] [numeric](38, 8) NULL,
	[Apr GP] [numeric](38, 8) NULL,
	[May GP] [numeric](38, 8) NULL,
	[Jun GP] [numeric](38, 8) NULL,
	[Jul GP] [numeric](38, 8) NULL,
	[Aug GP] [numeric](38, 8) NULL,
	[Sep GP] [numeric](38, 8) NULL,
	[Oct GP] [numeric](38, 8) NULL,
	[Nov GP] [numeric](38, 8) NULL,
	[Dec GP] [numeric](38, 8) NULL,
	GLNAME [nvarchar](50) NULL
) ON [PRIMARY]

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
--SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
--SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

SELECT @cmd = 'INSERT INTO work_SSRS311 '
SELECT @cmd = @cmd + 'SELECT '
SELECT @cmd = @cmd + 'CusCode, '
SELECT @cmd = @cmd + 'CusCode, '
--SELECT @cmd = @cmd + 'SalesRep,'
--SELECT @cmd = @cmd + 'Location, '
SELECT @cmd = @cmd + 'SUBSTRING(ST03011,7,2), '
SELECT @cmd = @cmd + 'ST03017, '
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'NULL,'
--SELECT @cmd = @cmd + 'Department  "Department",'
SELECT @cmd = @cmd + ' ''' + CAST( @ThisYearValue as CHAR(4)) + ''', '
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'NULL ,'
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M01'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M02'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M03'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M04'' Then (ST03020) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M05'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M06'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M07'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M08'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M09'' Then (ST03020) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M10'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M11'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M12'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M01'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M02'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M03'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M04'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M05'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M06'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M07'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M08'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M09'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M10'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M11'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M12'' Then (((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023)) End), ' 
SELECT @cmd = @cmd + 'SUBSTRING(ST03011,13,8)'


SELECT @cmd2 = 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @cmd2 = @cmd2 + 'INNER JOIN    [IscalaAnalysis]..Cust_Hides_Sales '
SELECT @cmd2 = @cmd2 + ' ON   ST03008 COLLATE Database_Default = CusCode '
--SELECT @cmd2 = @cmd2 + 'INNER JOIN    [ScaCompanyDB]..GL030110 '
--SELECT @cmd2 = @cmd2 + ' ON   SUBSTRING(ST03011,13,8) = GL03002 '
--inner join ScaCompanyDB.dbo.GL030110  on
--	SUBSTRING(SC07012,13,8)= GL03002 
--modified by harvox
--SELECT @cmd2 = @cmd2 + ' JOIN    [ScaCompanyDB]..SC010100 '
--SELECT @cmd2 = @cmd2 + ' ON   ST03017 = SC01001 '
--modified by harvox
--SELECT @cmd2 = @cmd2 + 'INNER JOIN  KK_Departments '
--SELECT @cmd2 = @cmd2 + ' ON   Department = ''' + @Department + ''' '
--SELECT @cmd2 = @cmd2 + 'LEFT OUTER JOIN  CustomerSalesmanBudget '
--SELECT @cmd2 = @cmd2 + ' ON   SL01001 = KK_CustomerCode Collate Database_Default AND SUBSTRING(KK_AreaCode,1,2) = ' +  @costcentre + ' '
--SELECT @cmd2 = @cmd2 + ' ON   SL01001 = KK_CustomerCode Collate Database_Default '
SELECT @cmd2 = @cmd2 + 'WHERE rtrim(cast(datepart(yyyy,ST03015) as char)) = ''' + CAST( @ThisYearValue as CHAR(4)) + ''' '
--IF @Single = 1 
--	SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
--Else
	--SELECT @cmd2 = @cmd2 +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
--SELECT @cmd2 = @cmd2 + 'AND ST03008 = '''+ @CusCode + ''' '
SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
--SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03011,7,6) IN (''11'',''21'',''13'') '
SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,3) <>  ''ZZZ'' '
--SELECT @cmd2 = @cmd2 + 'AND SL01001 IN (''LAECOC'', ''POMCOC'',''LAEGOO'',''POMHOR'',''LAEHOR'',''GORLAG'',
--''LAENES'',''POMPNG4'',''LAEPNG'',''LAESUN2'',''LAERIC'',''LIHLCC'',''LAERIC'',''LIHLIH'',''KAVLIH'',''MADMAR''
--,''TABOKT'',''LAEICI'',''PORPOR'',''HAGPOR'',''KAVSIMB'',''POMDOM'',''LAEWAFI'',''ALOWOO'',''POMFRI'',''ALOMIL''
--,''POPHIG'',''KIMNEW'',''KAVPOL'',''LAERAM'',''BIAHAR'',''LAEHIDD'') '

--(''LAECBI'',''POMCBI'',''POMCB&I'') '
--modified by harvox
--SELECT @cmd2 = @cmd2 + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
--SELECT @cmd2 = @cmd2 + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
--SELECT @cmd2 = @cmd2 + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
--modified by harvox
SELECT @cmd2 = @cmd2 + 'GROUP BY CusCode, SUBSTRING(ST03011,13,6), ST03017,ST03011 ' --KK_AreaCode,GL3003
 
--SELECT @cmd + ' ' + @cmd2
--SELECT @cmd2

--SELECT @cmd + ' ' + @cmd2
Execute (@cmd + ' ' + @cmd2)

UPDATE work_SSRS311
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default

UPDATE work_SSRS311
	SET AccountName = GL03003 
	FROM ScaCompanyDB..GL030100 
WHERE GLNAME = GL03002 COLLATE Database_Default -- COLLATE Database_Default

UPDATE work_SSRS311
	SET CustomerName = SL01002 
    FROM ScaCompanyDB..SL010100 
WHERE CustomerCode  = SL01001  COLLATE Database_Default

--UPDATE work_SSRS311
--SET
--[Jan GP] = [Jan GP]/[Jan],
--[Feb GP] = [Feb GP]/[Feb],
--[Mar GP] = [Mar GP]/[Mar],
--[Apr GP] = [Apr GP]/[Apr],
--[May GP] = [May GP]/[May],
--[Jun GP] = [Jun GP]/[Jun],
--[Jul GP] = [Jul GP]/[Jul],
--[Aug GP] = [Aug GP]/[Aug],
--[Sep GP] = [Sep GP]/[Sep],
--[Oct GP] = [Oct GP]/[Oct],
--[Nov GP] = [Nov GP]/[Nov],
--[Dec GP] = [Dec GP]/[Dec]


--UPDATE work_SSRS311
--	SET	AccountCode = 'X'
--WHERE AccountCode IS NULL

--UPDATE work_SSRS311
--	SET	AccountCode = 'X'
--WHERE AccountCode IS NULL

---- As Lae Industrial are the only division utilising this then clear it for the rest
----IF @CostCentre <> 10
----	UPDATE work_SSRS311
----	SET	AreaCode = ' '

---- Replaces the logic above
---- As work_SSRS311 only contains the relevent cost centre then set it to default 100 for all non allocated customers
--UPDATE work_SSRS311
--SET Areacode = '100'
--WHERE Areacode IS NULL


SELECT @cmd = 'SELECT * FROM work_SSRS311 ' 
SELECT @cmd = @cmd + 'WHERE  NOT AccountCode = ''AIXFRU'' '
SELECT @cmd = @cmd + 'AND NOT AccountCode = ''AWMAT'' '
SELECT @cmd = @cmd + 'AND NOT AccountCode = ''AIXPAL'' '
--IF @AreaCode IS NOT NULL 
	--SELECT @cmd = @cmd + 'AND AreaCode = ' +  @AreaCode  + ' '
EXEC (@cmd)



--SELECT @cmd = 'UPDATE work_SSRS311 ' 
---SELECT @cmd = 'SET AccountName = GL03002 ' 
--SELECT @cmd = 'FROM ScaCompanyDB..GL030100 where GLNAME = GL03002 COLLATE Database_Default WHERE GLNAME <> ''''' 
--EXEC (@cmd)

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS311]