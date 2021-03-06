USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00311_RetailCatval]    Script Date: 10/05/2021 11:16:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================= --
-- Author:		Isaac Kababa							   --
-- Create date: 17/04/2016								   --
-- Description:	extract all sales data (value)GNS Range   --	
--              by customer for crrnt year & previous year --
--				Requested by Tom Willouby				   --
-- ======================================================= --
ALTER PROCEDURE [dbo].[SSRS_RPT00311_RetailCatval] 
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
	[CatCode] [nvarchar](2) NULL,
	[CatDescription1] [nvarchar](25) NULL,
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


--	SET @Department='Retail POM'		    
--	SET @year='2016'
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
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)  '
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
AND StockCode IN ('12-01-8110','12-01-8115','12-01-8120','12-01-8125','12-01-8130','12-01-8135',
				  '12-01-8140','12-01-8141','12-01-8008','12-01-8100','12-01-8105','12-01-8005',
				  '12-01-8055','12-01-8223','12-01-8828','12-01-8219','12-01-8217','12-01-8212',
				  '12-01-8214','12-01-8213','12-01-8250','12-01-8150','12-01-8155','12-01-8200',
				  '12-01-8202','12-01-8210','12-01-8215','12-01-8216','12-01-8220','12-01-8221',
				  '12-01-8222','12-01-8225','12-01-8230','12-01-8265','12-01-8256','12-01-8254',
				  '46-05-0076','46-05-0080','46-05-0084','12-01-8312','12-01-8313','12-01-8316',
				  '12-01-8320','12-01-8322','12-01-8324','12-01-9002','12-01-9010','12-01-9030',
				  '12-01-9041','12-01-9045','12-01-9050','12-01-9055','12-01-9060','12-01-9065',
                  ---lines added in 02/06/2016 - isaac
                  '12-10-3502','12-10-3505','12-10-3507','12-10-3510','12-10-3512',-- King's bleach range
				  '46-04-2055','46-04-2056','46-04-2058','46-04-3001', -- King's paper range
				  '46-04-3672','46-04-3674','46-04-3682','46-04-3684', -- Kleensorb range
				  ----------------------------------------------------------------------------------------
				  --lines added in 06/02/2018 - isaac
	              '46-04-3093','46-04-3691','12-01-8311','12-01-8314','12-01-8218','12-01-8211',
 				  ----------------------------------------------------------------------------------------
				  '46-04-1005','46-04-1015','46-04-2060','46-04-2062','46-04-2064','46-04-2068',
				  '46-04-3080','46-04-3086','46-04-3091','46-04-3096','46-04-2093','46-04-3092',
				  '46-04-3094','46-04-3600','46-04-3650','46-04-8055','46-04-3095','46-04-3099',
				  '46-04-4071','46-04-4067','46-04-4065','46-08-5056','46-08-5058','46-08-5060',
				  '46-04-3033','46-04-3032')

UPDATE #temp_SSRS311
	SET	CatCode = 'CC', CatDescription1='Car Care Range'
WHERE StockCode IN ('12-01-8110','12-01-8115','12-01-8120','12-01-8125','12-01-8130','12-01-8135','12-01-8140','12-01-8141')

UPDATE #temp_SSRS311
	SET	CatCode = 'AF', CatDescription1='Household Range'
WHERE StockCode IN ('12-01-8008','12-01-8100','12-01-8105','12-01-8005','12-01-8055','12-01-8223','12-01-8828',
					'12-01-8219','12-01-8217','12-01-8212','12-01-8214','12-01-8213','12-01-8250','12-01-8150',
					'12-01-8155','12-01-8200','12-01-8202','12-01-8210','12-01-8215','12-01-8216','12-01-8220',
					'12-01-8221','12-01-8222','12-01-8225','12-01-8230','12-01-8265','12-01-8256','12-01-8254',
					'46-05-0076','46-05-0080','46-05-0084','12-01-8312','12-01-8313','12-01-8316','12-01-8320',
					'12-01-8322','12-01-8324','12-01-8311','12-01-8314')
UPDATE #temp_SSRS311
	SET	CatCode = 'BL', CatDescription1='Bleach Range'
WHERE StockCode IN ('12-01-9002','12-01-9010','12-01-9030','12-01-9041','12-01-9045','12-01-9050','12-01-9055','12-01-9060','12-01-9065',
 				    '12-10-3502','12-10-3505','12-10-3507','12-10-3510','12-10-3512','12-01-8218','12-01-8211')--- codes added for king's paper range 02/06/2016

UPDATE #temp_SSRS311
	SET	CatCode = 'PP', CatDescription1='Paper Range'
WHERE StockCode IN ('46-04-1005','46-04-1015','46-04-2060','46-04-2062','46-04-2064','46-04-2068','46-04-3080',
					'46-04-3086','46-04-3091','46-04-3096','46-04-2093','46-04-3092','46-04-3094','46-04-3600',
					'46-04-3650','46-04-3672','46-04-3674','46-04-3682','46-04-3684','46-04-8055','46-04-3095',
					'46-04-3099','46-04-4071','46-04-4067','46-04-4065','46-08-5056','46-08-5058','46-08-5060',
					'46-04-3033','46-04-3032','46-04-2055','46-04-2056','46-04-2058','46-04-3001',
					'46-04-3093','46-04-3691')
                    -- note stock codes 46-04-3672','46-04-3674','46-04-3682','46-04-3684 added for the kleensorb range
                    --02/06/2016 - isaac 
SELECT * FROM #temp_SSRS311 where CatCode IN ('CC','AF','BL','PP')	order by StockCode