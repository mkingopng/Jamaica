USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00383_Sales_Supp]    Script Date: 10/05/2021 14:12:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Manish Yadav
-- Create date: 05/03/2013
-- Description:	extract all sales data but customer for this year and last year
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00383_Sales_Supp] 
		--@Department	 as NVARCHAR(256),
		@Thisyearvalue integer,
		@SupplierCode NVARCHAR(10)
		--@AreaCode NVARCHAR(3) = NULL
		
AS
	DECLARE @cmd as VARCHAR(8000),
			@cmd2 as VARCHAR(8000),
			@CostCentre as NVARCHAR(64),
			
			@Single as bit
		

   -- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS383]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS383]
	
	CREATE TABLE [dbo].[work_SSRS383](
	[SuppCode] [nchar](10) NOT NULL,
	[StockStatus] [nvarchar](35) NOT NULL,
	
	--[AreaCode] NVARCHAR(3),
	[StockCode] [nvarchar](35) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	[SuppStkCode] [nvarchar](35) ,
	[StockBal] [Numeric] (20) ,
	--[Department] [nvarchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[AccountCode] [nvarchar](6) NULL,
	[AccountName] [nvarchar](50) NULL,
	[YR-3] [numeric](38, 6) NULL,
	[YR-2] [numeric](38, 6) NULL,
	[YR-1] [numeric](38, 6) NULL,
	[YR] [numeric](38, 6) NULL,
	[YR-3-QTY] [numeric](38, 8) NULL,
	[YR-2-QTY] [numeric](38, 8) NULL,
	[YR-1-QTY] [numeric](38, 8) NULL,
	[YR-QTY] [numeric](38, 8) NULL
	--GLNAME [nvarchar](50) NULL
) ON [PRIMARY]

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
--SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
--SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

SELECT @cmd = 'INSERT INTO work_SSRS383 '
SELECT @cmd = @cmd + 'SELECT '
SELECT @cmd = @cmd + 'SC01058, '
SELECT @cmd = @cmd + 'SC01023, '
--SELECT @cmd = @cmd + 'SalesRep,'
--SELECT @cmd = @cmd + 'KK_AreaCode, '
SELECT @cmd = @cmd + 'ST03017, '
--SELECT @cmd = @cmd + 'SC01060, '
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'SC01060,'
SELECT @cmd = @cmd + 'SC01042,'
--SELECT @cmd = @cmd + 'Department  "Department",'
SELECT @cmd = @cmd + ' ''' + CAST( @ThisYearValue as CHAR(4)) + ''', '
SELECT @cmd = @cmd + 'NULL,'
SELECT @cmd = @cmd + 'NULL ,'
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))= ''' + CAST (@ThisYearValue-3 as CHAR(4)) + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))= ''' + CAST (@ThisYearValue-2 as CHAR(4)) + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))= ''' + CAST (@ThisYearValue-1 as CHAR(4)) + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))= ''' + CAST (@ThisYearValue as CHAR(4)) +   ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))= ''' + CAST (@ThisYearValue-3 as CHAR(4)) + ''' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))= ''' + CAST (@ThisYearValue-2 as CHAR(4)) + ''' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))= ''' + CAST (@ThisYearValue-1 as CHAR(4)) + ''' Then (ST03020) End), '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))= ''' + CAST (@ThisYearValue as CHAR(4)) + ''' Then (ST03020) End) '
--SELECT @cmd = @cmd + 'SUBSTRING(ST03011,13,8)'
SELECT @cmd2 = 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @cmd2 = @cmd2 + 'INNER JOIN    [ScaCompanyDB]..SC010100 '
SELECT @cmd2 = @cmd2 + ' ON   ST03017  = SC01001 '

SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
--SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03011,7,6) IN (''11'',''21'',''13'') '
SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,3) <>  ''ZZZ'' '
SELECT @cmd2 = @cmd2 + 'AND SC01058 = ''' + @SupplierCode + ''' ' 

SELECT @cmd2 = @cmd2 + 'GROUP BY SC01058,SC01060,SC01042,ST03017,SC01023 ' --KK_AreaCode,GL3003
 

Execute (@cmd + ' ' + @cmd2)

UPDATE work_SSRS383
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default

--UPDATE work_SSRS383
	--SET AccountName = GL03003 
	--FROM ScaCompanyDB..GL030100 
--WHERE GLNAME = GL03002 COLLATE Database_Default -- COLLATE Database_Default

--UPDATE work_SSRS383
	--SET CustomerName = SL01002 
   -- FROM ScaCompanyDB..SL010100 
--WHERE SuppCode   = SL01001  COLLATE Database_Default




SELECT @cmd = 'SELECT * FROM work_SSRS383 ' 
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

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS383]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS383]