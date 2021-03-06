USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00311_Margin]    Script Date: 10/05/2021 11:15:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00311_Margin] 
		@Department	 as NVARCHAR(256),
		@year integer
AS
	DECLARE @cmd as VARCHAR(8000),
			@cmd2 as VARCHAR(8000),
--			@cmd3 as VARCHAR(8000),
			@CostCentre as NVARCHAR(64),
			@Single as bit
   -- SELECT @year = YEAR(GETDATE()) /* commented out to pick selected year from drop down list :: Isaac 26-02-2014*/
	SET NOCOUNT ON;
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311a]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS311a]
	CREATE TABLE [dbo].[work_SSRS311a](
	[CustomerCode] [nchar](10) NOT NULL,
	[CustomerName] [nvarchar](35) NOT NULL,
	[StockCode] [nvarchar](35) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	[Department] [nvarchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[AccountCode] [nvarchar](6) NULL,
	[CostCentre] [nvarchar] (4) NULL,
	[Jan Margin][numeric] (38,8) NULL,
	[Jan PMargin][numeric] (38, 8)NULL,

	[Jan iCount][numeric](20)NULL, 
	[Feb iCount][numeric](20)NULL, 
	[Mar iCount][numeric](20)NULL, 
	[Apr iCount][numeric](20)NULL, 
	[May iCount][numeric](20)NULL, 
	[Jun iCount][numeric](20)NULL, 
	[Jul iCount][numeric](20)NULL, 
	--[Aug iCount][numeric](20)NULL, 
	--[Sep iCount][numeric](20)NULL, 
	--[Oct iCount][numeric](20)NULL, 
	--[Nov iCount][numeric](20)NULL, 
	--[Dec iCount][numeric](20)NULL 

	[Jan Sales] [numeric](38, 6) NULL,
	[Feb Sales] [numeric](38, 6) NULL,
	[Mar Sales] [numeric](38, 6) NULL,
	[Apr Sales] [numeric](38, 6) NULL,
	[May Sales] [numeric](38, 6) NULL,
	[Jun Sales] [numeric](38, 6) NULL,
	[Jul Sales] [numeric](38, 6) NULL,
	[Aug Sales] [numeric](38, 6) NULL,
	[Sep Sales] [numeric](38, 6) NULL,
	[Oct Sales] [numeric](38, 6) NULL,
	[Nov Sales] [numeric](38, 6) NULL,
	[Dec Sales] [numeric](38, 6) NULL,
	[Jan Costs] [numeric](38, 6) NULL,
	[Feb Costs] [numeric](38, 6) NULL,
	[Mar Costs] [numeric](38, 6) NULL,
	[Apr Costs] [numeric](38, 6) NULL,
	[May Costs] [numeric](38, 6) NULL,
	[Jun Costs] [numeric](38, 6) NULL,
	[Jul Costs] [numeric](38, 6) NULL,
	[Aug Costs] [numeric](38, 6) NULL,
	[Sep Costs] [numeric](38, 6) NULL,
	[Oct Costs] [numeric](38, 6) NULL,
	[Nov Costs] [numeric](38, 6) NULL,
	[Dec Costs] [numeric](38, 6) NULL,

	[Jan Qtysl] [numeric](38, 8) NULL,
	[Feb Qtysl] [numeric](38, 8) NULL,
	[Mar Qtysl] [numeric](38, 8) NULL,
	[Apr Qtysl] [numeric](38, 8) NULL,
	[May Qtysl] [numeric](38, 8) NULL,
	[Jun Qtysl] [numeric](38, 8) NULL,
	[Jul Qtysl] [numeric](38, 8) NULL,
	[Aug Qtysl] [numeric](38, 8) NULL,
	[Sep Qtysl] [numeric](38, 8) NULL,
	[Oct Qtysl] [numeric](38, 8) NULL,
	[Nov Qtysl] [numeric](38, 8) NULL,
	[Dec Qtysl] [numeric](38, 8) NULL

) ON [PRIMARY]

SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
SELECT @cmd = 'INSERT INTO work_SSRS311a '
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
SELECT @cmd = @cmd + 'NULL ,'
SELECT @cmd = @cmd + 'NULL ,'

SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M01'' Then (ST03014) End),' -- invoice count
SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M02'' Then (ST03014) End),' 
SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M03'' Then (ST03014) End),' 
SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M04'' Then (ST03014) End),' 
SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M05'' Then (ST03014) End),' 
SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M06'' Then (ST03014) End),' 
SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M07'' Then (ST03014) End),' 
--SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M08'' Then (ST03014) End), ' 
--SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M09'' Then (ST03014) End), ' 
--SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M10'' Then (ST03014) End), ' 
--SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M11'' Then (ST03014) End), ' 
--SELECT @cmd = @cmd + 'COUNT(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M12'' Then (ST03014) End)' 

SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--Net Value (Sales Value
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) ,'
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 

SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M01'' Then (ST03020 * ST03023) End) , ' --Cost Value (CostOfSales
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M02'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M03'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M04'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M05'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M06'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M07'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M08'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M09'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M10'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M11'' Then (ST03020 * ST03023) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M12'' Then (ST03020 * ST03023) End) , ' 

SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M01'' Then (ST03020) End), ' -- Qty
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M02'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M03'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M04'' Then (ST03020) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M05'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M06'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M07'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M08'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M09'' Then (ST03020) End), ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M10'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M11'' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M12'' Then (ST03020) End) '

SELECT @cmd2 = 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @cmd2 = @cmd2 + 'INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @cmd2 = @cmd2 + ' ON   ST03008 = SL01001 '

SELECT @cmd2 = @cmd2 + 'INNER JOIN  KK_Departments '
SELECT @cmd2 = @cmd2 + ' ON   Department = ''' + @Department + ''' '

IF @Single = 1 
 SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
Else
 SELECT @cmd2 = @cmd2 +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '

SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @cmd2 = @cmd2 + 'AND ST03017 <>  ''FREIGHT'' '
SELECT @cmd2 = @cmd2 + 'GROUP BY Department,SL01001, SL01002, SUBSTRING(ST03011,13,6), ST03017,ST03011 '
 
--Execute (@cmd + ' ' + @cmd3 + ' ' + @cmd2)
Execute (@cmd + ' ' + @cmd2)

UPDATE work_SSRS311a
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default

UPDATE work_SSRS311a
	SET	AccountCode = 'X'
WHERE AccountCode IS NULL

UPDATE work_SSRS311a
	SET [Jan Sales] = '0'
WHERE [Jan Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Jan Costs] = '0'
WHERE [Jan Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Feb Sales] = '0'
WHERE [Feb Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Feb Costs] = '0'
WHERE [Feb Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Mar Sales] = '0'
WHERE [Mar Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Mar Costs] = '0'
WHERE [Mar Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Apr Sales] = '0'
WHERE [Apr Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Apr Costs] = '0'
WHERE [Apr Costs] IS NULL	

UPDATE work_SSRS311a
	SET [May Sales] = '0'
WHERE [May Sales] IS NULL	

UPDATE work_SSRS311a
	SET [May Costs] = '0'
WHERE [May Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Jun Sales] = '0'
WHERE [Jun Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Jun Costs] = '0'
WHERE [Jun Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Jul Sales] = '0'
WHERE [Jul Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Jul Costs] = '0'
WHERE [Jul Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Aug Sales] = '0'
WHERE [Aug Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Aug Costs] = '0'
WHERE [Aug Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Sep Sales] = '0'
WHERE [Sep Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Sep Costs] = '0'
WHERE [Sep Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Oct Sales] = '0'
WHERE [Oct Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Oct Costs] = '0'
WHERE [Oct Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Nov Sales] = '0'
WHERE [Nov Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Nov Costs] = '0'
WHERE [Nov Costs] IS NULL	

UPDATE work_SSRS311a
	SET [Dec Sales] = '0'
WHERE [Dec Sales] IS NULL	

UPDATE work_SSRS311a
	SET [Dec Costs] = '0'
WHERE [Dec Costs] IS NULL	

SELECT * FROM work_SSRS311a 
WHERE  NOT AccountCode = 'AIXFRU'
AND NOT AccountCode = 'AWMAT'
AND NOT AccountCode = 'AIXPAL'
AND [Jan Sales]<>0 OR [Feb Sales]<>0 OR [Mar Sales]<>0
OR [Apr Sales]<>0 OR [May Sales]<>0 OR [Jun Sales]<>0
OR [Jul Sales]<>0 OR [Aug Sales]<>0 OR [Sep Sales]<>0
OR [Oct Sales]<>0 OR [Nov Sales]<>0 OR [Dec Sales]<>0

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311a]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
	DROP TABLE [dbo].[work_SSRS311a]
