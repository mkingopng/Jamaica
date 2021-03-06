USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00365]    Script Date: 10/05/2021 13:36:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00365] 
	-- Add the parameters for the stored procedure here
	--@year as char(4), 
	--@month as char(2)
	
	@StartDate as Datetime = null,
    @EndDate as Datetime = null 
AS
BEGIN
SET NOCOUNT ON
DECLARE
@year as Integer,
@month as Integer
IF (@StartDate) IS NULL
	BEGIN
		SELECT @year = DATEPART(year, GETDATE())
		SELECT @MONTH = DATEPART(month, GETDATE())
	
		SELECT @StartDate = CAST(@year as CHAR(4)) + '-' + CAST (@month as CHAR(2))+ '-01'
		SELECT @EndDate = GETDATE()
	END
--Declare @YearMonth as CHAR(7), 
Declare @c as NVARCHAR(4000)
Declare @c1 as NVARCHAR(4000)
--SELECT @YearMonth = @year + 'M' + @month
SELECT @c = 'SELECT	DISTINCT '
SELECT @c = @c + 'ST03001 "Cuscode",'
SELECT @c = @c + 'ST03009 "OrderNumber",'
SELECT @c = @c + 'ST03014 "InvoiceNumber", '
SELECT @c = @c + 'OR20015 "OrderDate", '
SELECT @c = @c + 'OR20016 "DeliveryDate", '
SELECT @c = @c + 'DATEPART(day, OR20016)- DATEPART(day,OR20015) "DaysTaken", '
SELECT @c = @c + 'ST03029 "W/H No.", '
SELECT @c = @c + 'Description "Description"'
SELECT @c = @c + 'FROM ScaCompanyDB..ST030100 '
SELECT @c = @c + 'INNER JOIN ScaCompanyDB..OR200100 '
SELECT @c = @c + 'ON ST03014 = OR20021 '
SELECT @c = @c + 'INNER JOIN IscalaAnalysis..KK_Warehouse ' 
SELECT @c = @c + 'ON WarehouseCode = ST03029 COLLATE DATABASE_DEFAULT '
--SELECT @c = @c + 'WHERE OR20015 BETWEEN ''2011-08-01 00:00:00.000 +  (SELECT CONVERT(VARCHAR(10), @StartDate, 120) AS [YYYY-MM-DD]) + ''' and ''' +  (SELECT CONVERT(VARCHAR(10), @EndDate, 120) AS [YYYY-MM-DD]) + ''' ' 
SELECT @c = @c + 'WHERE OR20015 BETWEEN ''2011-08-01 00:00:00.000'' and ''2011-12-31 00:00:00.000'''  
--SELECT @c = @c + 'GROUP BY ST03001,ST03009,ST03014,OR20015,OR20016,ST03029,Description '
EXEC (@c)

SELECT @c1 = 'SELECT COUNT(DISTINCT ST03009 )	 '
SELECT @c1 = @c1 + 'FROM ScaCompanyDB..ST030100 '
SELECT @c1 = @c1 + 'INNER JOIN ScaCompanyDB..OR200100 '
SELECT @c1 = @c1 + 'ON ST03014 = OR20021 '
SELECT @c1 = @c1 + 'INNER JOIN IscalaAnalysis..KK_Warehouse ' 
SELECT @c1 = @c1 + 'ON WarehouseCode = ST03029 COLLATE DATABASE_DEFAULT '
SELECT @c1 = @c1 + 'WHERE OR20015 BETWEEN ''' +  (SELECT CONVERT(VARCHAR(10), @StartDate, 120) AS [YYYY-MM-DD]) + ''' and ''' +  (SELECT CONVERT(VARCHAR(10), @EndDate, 120) AS [YYYY-MM-DD]) + ''' ' 
EXEC (@c1)
END