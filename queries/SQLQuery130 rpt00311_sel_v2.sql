USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00311_sel_v2]    Script Date: 10/05/2021 11:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Isaac Kababa
-- Create date: 23/04/2014
-- Description:	extract all sales data but customer for this year and last year
-- Including the sales man code
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00311_sel_v2] 
		@Department	 as NVARCHAR(256),
		@Thisyearvalue integer
		--@CusCode NVARCHAR(10)
AS
	DECLARE @cmd as VARCHAR(8000),
			@cmd2 as VARCHAR(8000),
			@CostCentre as NVARCHAR(64),
			@Single as bit

   -- SELECT @Thisyearvalue = YEAR(GETDATE())
   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311v2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS311v2]
	
	CREATE TABLE [dbo].[work_SSRS311v2](
	[CustomerCode] [nchar](10) NOT NULL,
	[CustomerName] [nvarchar](35) NOT NULL,
	[Salesman] [nvarchar](100) NULL,
	[SalesmanName] [nvarchar](100) NULL,
	[StockCode] [nvarchar](35) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	[Department] [nvarchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[AccountCode] [nvarchar](6) NULL,
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
	[PDec] [numeric](38, 8) NULL
) ON [PRIMARY]

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

SELECT @cmd = 'INSERT INTO work_SSRS311v2 '
SELECT @cmd = @cmd + 'SELECT '
SELECT @cmd = @cmd + 'SL01001, '
SELECT @cmd = @cmd + 'SL01002,'
SELECT @cmd = @cmd + 'ST03007,'
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'ST03017, '
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'Department  "Department",'
SELECT @cmd = @cmd + ' ''' + CAST( @ThisYearValue as CHAR(4)) + ''', '
SELECT @cmd = @cmd + 'NULL ,'
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) ,'
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
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M12'' Then (ST03020) End) '
SELECT @cmd2 = 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @cmd2 = @cmd2 + 'INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @cmd2 = @cmd2 + ' ON   ST03008 = SL01001 '
SELECT @cmd2 = @cmd2 + 'INNER JOIN  KK_Departments '
SELECT @cmd2 = @cmd2 + ' ON   Department = ''' + @Department + ''' '
SELECT @cmd2 = @cmd2 + 'WHERE rtrim(cast(datepart(yyyy,ST03015) as char)) = ''' + CAST( @ThisYearValue as CHAR(4)) + ''' '
IF @Single = 1 
 SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
Else
  SELECT @cmd2 = @cmd2 +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @cmd2 = @cmd2 + 'GROUP BY Department,SL01001, SL01002, SUBSTRING(ST03011,13,6), ST03007, ST03017 '
 
Execute (@cmd + ' ' + @cmd2)

UPDATE work_SSRS311v2
	SET SalesmanName   = ST01002
    FROM ScaCompanyDB..ST010100 
WHERE Salesman   = ST01001   COLLATE Database_Default

UPDATE work_SSRS311v2
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default

UPDATE work_SSRS311v2
	SET	AccountCode = 'X'
WHERE AccountCode IS NULL

SELECT * FROM work_SSRS311v2 
WHERE  NOT AccountCode = 'AIXFRU'
AND NOT AccountCode = 'AWMAT'
AND NOT AccountCode = 'AIXPAL'

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311v2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS311v2]