USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00382_sel]    Script Date: 10/05/2021 14:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 22/7/2010
-- Description:	extract all sales data but customer for this year and last year
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00382_sel] 
		@Department	 as NVARCHAR(256),
		@Thisyearvalue integer
		--@AreaCode NVARCHAR(3) = NULL
		--@CusCode NVARCHAR(10)
AS
	DECLARE @c as VARCHAR(8000),
			@c2 as VARCHAR(8000),
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
	[StockCode] [nvarchar](35) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	[Department] [nvarchar](50) NOT NULL,
	[SuppCode] [nvarchar](25) NULL,
	[AreaCode] NVARCHAR(3),
	[Year] [varchar](4) NOT NULL,
	[AccountCode] [nvarchar](6) NULL,
	[AccountName] [nvarchar] (50) NULL,
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
	[Dec Qty] [numeric](38, 8) NULL
) ON [PRIMARY]

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

SELECT @c = 'INSERT INTO work_SSRS311 '
SELECT @c = @c + 'SELECT '
SELECT @c = @c + 'SL01001, '
SELECT @c = @c + 'SL01002,'
SELECT @c = @c + 'ST03017,'
SELECT @c = @c + 'NULL,'
SELECT @c = @c + 'NULL,'
SELECT @c = @c + 'Department  "Department", '
SELECT @c = @c + 'SC01058,'
SELECT @c = @c + 'NULL, ' --KK_AreaCode, '
SELECT @c = @c + ' ''' + CAST( @ThisYearValue as CHAR(4)) + ''', '
SELECT @c = @c + 'NULL ,'
SELECT @c = @c + 'NULL ,'
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) ,'
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M01'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M02'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M03'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M04'' Then (ST03020) End), ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M05'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M06'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M07'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M08'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M09'' Then (ST03020) End), ' 
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M10'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M11'' Then (ST03020) End), '
SELECT @c = @c + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @ThisYearValue as CHAR(4)) + 'M12'' Then (ST03020) End) '
SELECT @c2 = 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @c2 = @c2 + 'INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @c2 = @c2 + ' ON   ST03008 = SL01001 '
--SELECT @c2 = @c2 + 'INNER JOIN    [ScaCompanyDB]..SC010100 '
--SELECT @c2 = @c2 + ' ON   ST03017 = SC01001 '
SELECT @c2 = @c2 + 'INNER JOIN    [ScaCompanyDB]..SC010100 '
SELECT @c2 = @c2 + ' ON   ST03017 = SC01001 '

SELECT @c2 = @c2 + 'INNER JOIN  KK_Departments '
SELECT @c2 = @c2 + ' ON   Department = ''' + @Department + ''' '
--SELECT @c2 = @c2 + 'LEFT OUTER JOIN  CustomerSalesmanBudget '
--SELECT @c2 = @c2 + ' ON   SL01001 = KK_CustomerCode Collate Database_Default AND SUBSTRING(KK_AreaCode,1,2) = ' +  @costcentre + ' '
--SELECT @c2 = @c2 + ' ON   SL01001 = KK_CustomerCode Collate Database_Default '
SELECT @c2 = @c2 + 'WHERE rtrim(cast(datepart(yyyy,ST03015) as char)) = ''' + CAST( @ThisYearValue as CHAR(4)) + ''' '
IF @Single = 1 
	SELECT @c2 = @c2 + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
Else
	SELECT @c2 = @c2 +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
--SELECT @c2 = @c2 + 'AND ST03008 = '''+ @CusCode + ''' '
SELECT @c2 = @c2 + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @c2 = @c2 + 'AND SUBSTRING(ST03008,1,3) <>  ''ZZZ'' '
--SELECT @c2 = @c2 + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
--SELECT @c2 = @c2 + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
--SELECT @c2 = @c2 + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
SELECT @c2 = @c2 + 'GROUP BY Department,  SUBSTRING(ST03011,13,6),ST03017, SC01058,SL01125,SL01001,SL01002 ' --KK_AreaCode,
 
--SELECT @c + ' ' + @c2
--SELECT @c2

Execute (@c + ' ' + @c2)

UPDATE work_SSRS311
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default

UPDATE work_SSRS311
	SET	AccountCode = 'X'
WHERE AccountCode IS NULL

UPDATE work_SSRS311
	SET AccountName = GL03003
		--AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..GL030100
WHERE AccountCode  = GL03002  COLLATE Database_Default
-- As Lae Industrial are the only division utilising this then clear it for the rest
--IF @CostCentre <> 10
--	UPDATE work_SSRS311
--	SET	AreaCode = ' '
	
-- Replaces the logic above
-- As work_SSRS311 only contains the relevent cost centre then set it to default 100 for all non allocated customers
--UPDATE work_SSRS311
--SET Areacode = '100'
--WHERE Areacode IS NULL
	
SELECT @c = 'SELECT * FROM work_SSRS311 ' 
SELECT @c = @c + 'WHERE  NOT AccountCode = ''AIXFRU'' '
SELECT @c = @c + 'AND NOT AccountCode = ''AWMAT'' '
SELECT @c = @c + 'AND NOT AccountCode = ''AIXPAL'''
--IF @AreaCode IS NOT NULL 
--	SELECT @c = @c + 'AND AreaCode = ' +  @AreaCode  + ' '
EXEC (@c)

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
   DROP TABLE [dbo].[work_SSRS311]