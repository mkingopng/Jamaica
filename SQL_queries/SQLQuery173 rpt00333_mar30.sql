USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00333_Mar30]    Script Date: 10/05/2021 11:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--****************************************************************************
--* Isaac Kababa 12/08/2016 
--****************************************************************************

ALTER PROCEDURE [dbo].[SSRS_RPT00333_Mar30] 
		@Department	 as NVARCHAR(256),
		@StartDate as Datetime = NULL,
		@EndDate as Datetime = NULL
AS
	DECLARE @cmd as VARCHAR(8000),
			@cmd2 as VARCHAR(8000),
			@CostCentre as NVARCHAR(64),
			@Single as bit

	CREATE TABLE [dbo].[work_SSRS333](
	[StockCode] [nvarchar](35) NULL,
    [Salesman][nvarchar](50) NULL,
	[Description1] [nvarchar](25) NULL,
	[Description2] [nvarchar](25) NULL,
	[Department] [nvarchar](50) NULL,
	[AccountCode] [nvarchar](6) NULL,
	[CostCentre] [nvarchar] (4) NULL,
	[MaginVal] [numeric](38,6) NULL,
	[MarginP] [numeric](38,6) NULL,
	[Sales] [numeric](38, 6) NULL,
	[Costs] [numeric](38, 6) NULL,
	[Qty] [numeric](38, 8) NULL
) ON [PRIMARY]

SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
SELECT @cmd = 'INSERT INTO work_SSRS333 '
SELECT @cmd = @cmd + 'SELECT '
SELECT @cmd = @cmd + 'ST03017, '					--stockcode
SELECT @cmd = @cmd + 'ST03007, '					--salesman code
SELECT @cmd = @cmd + 'NULL,'						--description1
SELECT @cmd = @cmd + 'NULL,'						--description2
SELECT @cmd = @cmd + 'Department  "Department",'	--department
SELECT @cmd = @cmd + 'NULL ,'						--account code
SELECT @cmd = @cmd  + 'SUBSTRING(ST03011,7,2), '	--cost centre
SELECT @cmd = @cmd + 'NULL ,'						--margin value
SELECT @cmd = @cmd + 'NULL ,'						--margin percentage
SELECT @cmd = @cmd + 'SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100))  ,' -- net sales value in kina
SELECT @cmd = @cmd + 'SUM(ST03020 * ST03023) ,'		--net cost of sales value in kina
SELECT @cmd = @cmd + 'SUM(ST03020) '				--qty sold in the period
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
SELECT @cmd2 = @cmd2 + 'AND ST03015 BETWEEN ''' +  (SELECT CONVERT(VARCHAR(10), @StartDate, 120) AS [YYYY-MM-DD]) + ''' and ''' +  (SELECT CONVERT(VARCHAR(10), @EndDate, 120) AS [YYYY-MM-DD]) + ''' '
SELECT @cmd2 = @cmd2 + 'GROUP BY ST03017, Department, ST03011, ST03007 '

Execute (@cmd + ' ' + @cmd2)

-- update temp table with stock decription
UPDATE work_SSRS333
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default

-- update temp table with margin value
UPDATE work_SSRS333
	SET	MaginVal = Sales-Costs
WHERE AccountCode IS NOT NULL

-- update temp table with margin percentage
UPDATE work_SSRS333
   SET MarginP = ((Sales-Costs)/NULLIF([Sales],0))*100
WHERE AccountCode IS NOT NULL

-- update temp table set acccount code to X if account code is null
UPDATE work_SSRS333
	SET	AccountCode = 'X'
WHERE AccountCode IS NULL

-- update temp table set sales to 0 if sales is null
UPDATE work_SSRS333
	SET Sales = '0'
WHERE Sales IS NULL	

-- update temp table set cost to 0 if cost is null
UPDATE work_SSRS333
	SET Costs = '0'
WHERE Costs IS NULL	

-- extract data from temp table
SELECT * FROM work_SSRS333
WHERE MarginP <= 30				--filter margin value let then or equal to 50
AND NOT AccountCode = 'AIXFRU'	--filter out account code = AIXFRU
AND NOT AccountCode = 'AWMAT'	--filter out account code = AWMAT
AND NOT AccountCode = 'AIXPAL'	--filter out account code = AIXPAL
AND Sales <> 0					--filter sales value greater then 0
ORDER BY StockCode ASC

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS333]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
	DROP TABLE [dbo].[work_SSRS333]
