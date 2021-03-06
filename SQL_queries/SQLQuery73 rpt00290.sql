USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00290_sel]    Script Date: 10/05/2021 10:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00290_sel] 
	@StartDate as Datetime = NULL,
	@EndDate as Datetime = NULL,
	@department	 as NVARCHAR(256),
	@AllRecords as bit = NULL,
	@StartofMonthDate as Datetime = NULL
	 
AS
DECLARE @DateSelected as BIT,
	@StartofMonthSwitch as BIT,
	@command as NVARCHAR(2048),
	@ThisMonth as NVARCHAR(7),
	@work as NVARCHAR(7),
	@DateRange as NVARCHAR(50),
	@CostCentre as NVARCHAR(256),
	@Single as bit

---KK_SSRS_Rpt00290_sel
--Wayne Dunn
--Salesman Report -  Summary Customer Sales BY Date Range
--Parameters 
--	Start Date
--	End Date	
--	Cost Centre
--	Actual - Actual Sales or accounting sales
--	StartofMonthDate - For Month reporting when last month flows over
--

SELECT @StartofMonthSwitch = 0

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)


IF @StartDate IS NULL	
	SELECT @EndDate = NULL

IF @EndDate IS NULL	
	SELECT @StartDate = NULL
	
SELECT @ThisMonth =  rtrim(cast(datepart(yyyy,GETDATE()) as char))+ 'M' + substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2) 	

IF @StartDate IS NULL 
	BEGIN
	SELECT @DateSelected = 0 
	SELECT @DateRange = @ThisMonth
	END
ELSE
	BEGIN
		SELECT @DateSelected = 1 
		SELECT @DateRange = (rtrim(cast(datepart(yyyy,@StartDate) as char))+ 'M' + substring(cast(cast(datepart(mm,@StartDate) as INT)+100 as char),2,2))
		SELECT @DateRange = @DateRange + ' to '
		SELECT @DateRange = @DateRange + (rtrim(cast(datepart(yyyy,@EndDate) as char))+ 'M' + substring(cast(cast(datepart(mm,@EndDate) as INT)+100 as char),2,2)) 	 	
		SELECT @StartofMonthDate =  NULL
	END


If NOT @StartofMonthDate Is NULL
	SELECT @work = rtrim(cast(datepart(yyyy,@StartofMonthDate) as char))+ 'M' + substring(cast(cast(datepart(mm,@StartofMonthDate) as INT)+100 as char),2,2) 	
ELSE
	SELECT @work = '2999M12'
	
IF @work <> @ThisMonth
	SELECT @StartofMonthDate =  NULL
	
IF NOT @StartofMonthDate is NULL 
	SELECT @StartofMonthSwitch = 1
	
SELECT @command = ' SELECT '
SELECT @command = @command + 'SY24003    "SalesmanName", '
SELECT @command = @command + 'ST03007    "SalesmanCode", '
SELECT @command = @command + 'SL01001    "CustomerCode", ' 
SELECT @command = @command + 'SL01002    "CustomerName", ' 
SELECT @command = @command + 'ST03015    "InvOrderDate", ' 
SELECT @command = @command + 'ST03014    "InvoicNumber", '
SELECT @command = @command + 'SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100))   "Net Value", ' 
SELECT @command = @command + 'SUBSTRING(ST03011,7,6) as CostCentre, '
SELECT @command = @command + ' ''' + @Department + ''' as CostCentreName, '
SELECT @command = @command + ' ''' + @DateRange + ''' "DateRange" '
SELECT @command = @command + 'FROM [ScaCompanyDB]..ST030100 '   
SELECT @command = @command + ' INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @command = @command + ' ON   ST03008 = SL01001 '
SELECT @command = @command + 'LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 '
SELECT @command = @command + 'ON   SY24002 = ST03007  AND SY24001 = ''BK'' '
IF @DateSelected = 1
	SELECT @command = @command + ' WHERE ST03015  BETWEEN ''' + convert(nvarchar(20), @StartDate) + ''' AND ''' + convert(nvarchar(20), @EndDate) + ''' '
ELSE
	SELECT @command = @command +  'WHERE (rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @ThisMonth  + ''') '
IF @Single = 1 
	SELECT @command = @command +  'AND SUBSTRING(ST03011,7,2)  =  ' +  @costcentre  +  ' '
Else
	SELECT @command = @command +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
IF @StartofMonthSwitch = 1
	SELECT @command = @command +  'AND ST03015 >= ''' +  convert(nvarchar(20), @StartofMonthDate) + '''  '
If @AllRecords =0
	SELECT @command = @command +  'AND (SUBSTRING(ST03011,13,6) <> ''AIXPAL'' AND SUBSTRING(ST03011,13,6) <> ''AIXFRU'') '
SELECT @command = @command + ' GROUP BY    SUBSTRING(ST03011,7,6), ST03014,ST03015, SL01001 , SL01002 ,ST03007, SY24003 '
--SELECT @command

EXEC (@command)


