USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00311_GNSCat]    Script Date: 10/05/2021 11:14:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================= --
-- Author:		Isaac Kababa							   --
-- Create date: 15/06/2014								   --
-- Description:	extract all sales data (volume)Retail Range--	
--              by customer for crrnt year & previous year --
--				Requested by Tom Willouby				   --
-- ======================================================= --
ALTER PROCEDURE [dbo].[SSRS_RPT00311_GNSCat] 
		@Department	 as NVARCHAR(256),
		@year integer
AS
DECLARE
		@cmd as VARCHAR(8000),
		@cmd2 as VARCHAR(8000),
		@cmd15 as VARCHAR(8000),
		@CostCentre as NVARCHAR(64),
		@Single as bit
	SET NOCOUNT ON;
	CREATE TABLE [dbo].[#work_SSRS311](
	[CustomerCode] [nchar](10) NOT NULL,
	[CustomerName] [nvarchar](35) NOT NULL,
	[StockCode] [nvarchar](35) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	[Department] [nvarchar](50) NOT NULL,
	[CYear] [varchar](4) NOT NULL,
	[AccountCode] [nvarchar](6) NULL,
	[CostCentre] [nvarchar] (4) NULL,
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
	[PJan] [numeric](38, 8) NULL,
	[PFeb] [numeric](38, 8) NULL,
	[PMar] [numeric](38, 8) NULL,
	[PApr] [numeric](38, 8) NULL,
	[PMay] [numeric](38, 8) NULL,
	[PJun] [numeric](38, 8) NULL,
	[PJul] [numeric](38, 8) NULL,
	[PAug] [numeric](38, 8) NULL,
	[PSep] [numeric](38, 8) NULL,
	[POct] [numeric](38, 8) NULL,
	[PNov] [numeric](38, 8) NULL,
	[PDec] [numeric](38, 8) NULL,

	[JanS] [numeric](38, 6) NULL,
	[FebS] [numeric](38, 6) NULL
) ON [PRIMARY]

	CREATE TABLE [dbo].[#temp_SSRS311](
	[CustomerCode] [nchar](10) NOT NULL,
	[CustomerName] [nvarchar](35) NOT NULL,
	[StockCode] [nvarchar](35) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	[CatCode] [nvarchar](10) NULL,
	[CatDescription1] [nvarchar](50) NULL,
	[Department] [nvarchar](50) NOT NULL,
	[CYear] [varchar](4) NOT NULL,
	[AccountCode] [nvarchar](6) NULL,
	[CostCentre] [nvarchar] (4) NULL,
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
	[PJan] [numeric](38, 8) NULL,
	[PFeb] [numeric](38, 8) NULL,
	[PMar] [numeric](38, 8) NULL,
	[PApr] [numeric](38, 8) NULL,
	[PMay] [numeric](38, 8) NULL,
	[PJun] [numeric](38, 8) NULL,
	[PJul] [numeric](38, 8) NULL,
	[PAug] [numeric](38, 8) NULL,
	[PSep] [numeric](38, 8) NULL,
	[POct] [numeric](38, 8) NULL,
	[PNov] [numeric](38, 8) NULL,
	[PDec] [numeric](38, 8) NULL,

	[JanS] [numeric](38, 6) NULL,
	[FebS] [numeric](38, 6) NULL
) ON [PRIMARY]
-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
SELECT @cmd = 'INSERT INTO #work_SSRS311 '
SELECT @cmd = @cmd + 'SELECT '
SELECT @cmd = @cmd + 'SL01001, '
SELECT @cmd = @cmd + 'SL01002,'
SELECT @cmd = @cmd + 'ST03017, '
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'Department  "Department",'
SELECT @cmd = @cmd + ' ''' + CAST( @year as CHAR(4)) + ''', '
SELECT @cmd = @cmd + 'NULL ,'
SELECT @cmd = @cmd  + 'SUBSTRING(ST03011,7,2), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M01'' Then (ST03020) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M02'' Then (ST03020) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M03'' Then (ST03020) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M04'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M05'' Then (ST03020) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M06'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M07'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M08'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M09'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M10'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M11'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M12'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M01'' Then (ST03020) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M02'' Then (ST03020) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M03'' Then (ST03020) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M04'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M05'' Then (ST03020) End) ,'
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M06'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M07'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M08'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M09'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M10'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M11'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M12'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @year-1 as CHAR(4)) + 'M11'' Then (ST03020) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @year-1 as CHAR(4)) + 'M12'' Then (ST03020) End) ' 

SELECT @cmd2 = 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @cmd2 = @cmd2 + 'INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @cmd2 = @cmd2 + ' ON   ST03008 = SL01001 '

SELECT @cmd2 = @cmd2 + 'INNER JOIN  KK_Departments '
SELECT @cmd2 = @cmd2 + ' ON   Department = ''' + @Department + ''' '

IF @Single = 1 
 SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
Else
 SELECT @cmd2 = @cmd2 +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @CostCentre + ' '

SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @cmd2 = @cmd2 + 'AND ST03017 <>  ''FREIGHT'' '
SELECT @cmd2 = @cmd2 + 'GROUP BY Department,SL01001, SL01002, SUBSTRING(ST03011,13,6), ST03017,ST03011 '
 
Execute (@cmd + ' ' + @cmd2)

UPDATE #work_SSRS311
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default

UPDATE #work_SSRS311
	SET	AccountCode = 'X'
WHERE AccountCode IS NULL

INSERT INTO #temp_SSRS311
SELECT
	CustomerCode,
	CustomerName,
	StockCode,
	Description1,
	Description2,
	NULL,
	NULL,
	Department,
	CYear,
	AccountCode,
	CostCentre,
	Jan,
	Feb,
	Mar,
	Apr,
	May,
	Jun,
	Jul,
	Aug,
	Sep,
	Oct,
	Nov,
	Dec,
	PJan,
	PFeb,
	PMar,
	PApr,
	PMay,
	PJun,
	PJul,
	PAug,
	PSep,
	POct,
	PNov,
	PDec,
	JanS,
	FebS
FROM #work_SSRS311 
WHERE  NOT AccountCode = 'AIXFRU'
AND NOT AccountCode = 'AWMAT'
AND NOT AccountCode = 'AIXPAL'
AND Jan IS NOT NULL OR Feb IS NOT NULL AND Mar IS NOT NULL OR Apr IS NOT NULL OR May IS NOT NULL OR Jun IS NOT NULL OR Jan IS NOT NULL 
OR Jul IS NOT NULL OR Aug IS NOT NULL OR Sep IS NOT NULL OR Oct IS NOT NULL OR Nov IS NOT NULL
OR Dec IS NOT NULL OR PJan IS NOT NULL OR PFeb IS NOT NULL OR PMar IS NOT NULL OR PApr IS NOT NULL
OR PApr IS NOT NULL OR PMay IS NOT NULL OR PJun IS NOT NULL OR PJul IS NOT NULL OR PAug IS NOT NULL
OR PSep IS NOT NULL OR POct IS NOT NULL OR PNov IS NOT NULL OR PDec IS NOT NULL
AND StockCode IN ('11-01-0004','11-01-0019','11-01-0026','11-01-0004','11-01-0027')

SELECT * FROM #temp_SSRS311