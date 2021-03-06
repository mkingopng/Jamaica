USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00383_Sales_Supp_V2]    Script Date: 10/05/2021 14:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Manish Yadav
-- Create date: 05/03/2013
-- Description:	extract all sales data but customer for this year and last year
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00383_Sales_Supp_V2] 
		--@Department	 as NVARCHAR(256),
		@Thisyearvalue integer,
		@SupplierCode NVARCHAR(10),
		--@Division NVARCHAR (3),
		@Warehouse NVARCHAR(3)
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
	[Warehouse] NVARCHAR(3),
	[StockCode] [nvarchar](35) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	[SuppStkCode] [nvarchar](35) ,
	[StockBal] [Numeric] (20) ,
	--[Department] [nvarchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[AccountCode] [nvarchar](6) NULL,
	[AccountName] [nvarchar](50) NULL,
	[BackOrder] [numeric](20) NULL,
	[WH120] [numeric](20) NULL,
	[WH125] [numeric](20) NULL,
	[WH126] [numeric](20) NULL,
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
	[Dec Qty] [numeric](38, 8) NULL
	--[IDENTIFIER][nvarchar](20) NULL
	
	
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
SELECT @cmd = @cmd + 'ST03029, '
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
SELECT @cmd = @cmd + 'SC01044,'
SELECT @cmd = @cmd + '0,'
SELECT @cmd = @cmd + '0,'
SELECT @cmd = @cmd + '0,'
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
----SELECT @cmd = @cmd + 'SUBSTRING(ST03011,13,8)'
SELECT @cmd2 = 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @cmd2 = @cmd2 + 'INNER JOIN    [ScaCompanyDB]..SC010100 '
SELECT @cmd2 = @cmd2 + ' ON   ST03017  = SC01001 '

SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
--SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03011,7,6) IN (''11'',''21'',''13'') '
SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,3) <>  ''ZZZ'' '

--IF @SupplierCode IS NOT NULL 
--SELECT @cmd2 = @cmd2 +  'AND SC01058   =  ''' + @SupplierCode +  ''' '

SELECT @cmd2 = @cmd2 + 'AND SC01058 = ''' + @SupplierCode + ''' ' 
IF @Warehouse = '14'
SELECT @cmd2 = @cmd2 + 'AND ST03029 = ''14'' '  --''' + @Warehouse + ''' ' 
ELSE IF @Warehouse = '01' 
SELECT @cmd2 = @cmd2 + 'AND ST03029 = ''01'' '
ELSE IF @Warehouse = '03' 
SELECT @cmd2 = @cmd2 + 'AND ST03029 = ''03'' '
ELSE IF @Warehouse = '05' 
SELECT @cmd2 = @cmd2 + 'AND ST03029 = ''05'' '
ELSE IF @Warehouse = '06' 
SELECT @cmd2 = @cmd2 + 'AND ST03029 = ''06'' '
ELSE IF @Warehouse = '126'
SELECT @cmd2 = @cmd2 + 'AND ST03029 IN (''01'',''14'',''120'',''125'',''126'') '
ELSE IF @Warehouse = '356' 
SELECT @cmd2 = @cmd2 + 'AND ST03029 IN (''03'',''05'',''06'') ' --,''05'',''06'') '

--SELECT @cmd2 = @cmd2 + 'AND ST03029 = ''14'' '

SELECT @cmd2 = @cmd2 + 'GROUP BY SC01058,SC01060,SC01042,ST03017,SC01023,ST03029,SC01044 ' --KK_AreaCode,GL3003
SELECT @cmd2 = @cmd2 + 'ORDER BY ST03029 ' 
 

Execute (@cmd + ' ' + @cmd2)

UPDATE work_SSRS383
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default

UPDATE work_SSRS383
	SET WH120  = SC03006
FROM ScaCompanyDB..SC030100
WHERE StockCode = SC03001 COLLATE Database_Default and SC03002 = '120'

UPDATE work_SSRS383
	SET WH125  = SC03006
FROM ScaCompanyDB..SC030100
WHERE StockCode = SC03001 COLLATE Database_Default and SC03002 = '125'

UPDATE work_SSRS383
	SET WH126  = SC03006
FROM ScaCompanyDB..SC030100
WHERE StockCode = SC03001 COLLATE Database_Default and SC03002 = '126'



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
--SELECT @cmd = @cmd + ' WHERE Warehouse IN (''01'',''14'') '
SELECT @cmd = @cmd + 'ORDER BY Warehouse '
--IF @AreaCode IS NOT NULL 
	--SELECT @cmd = @cmd + 'AND AreaCode = ' +  @AreaCode  + ' '
EXEC (@cmd)

DROP TABLE [dbo].[work_SSRS383]

--SELECT @cmd = 'UPDATE work_SSRS311 ' 
---SELECT @cmd = 'SET AccountName = GL03002 ' 
--SELECT @cmd = 'FROM ScaCompanyDB..GL030100 where GLNAME = GL03002 COLLATE Database_Default WHERE GLNAME <> ''''' 
--EXEC (@cmd)

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS383]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS383]