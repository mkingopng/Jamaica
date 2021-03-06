USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00370_StkAdj]    Script Date: 10/05/2021 14:05:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00370_StkAdj]
		@Department	 as NVARCHAR(50),
		--@year as char(4), 
		--@month as char(2)
		@SelectedMonth AS NVARCHAR(7)
AS	
--BEGIN	
SET NOCOUNT ON
DECLARE @c as NVARCHAR(4000)
	--SELECT @YearMonth = @year + 'M' + @month
BEGIN
SET NOCOUNT ON;		

SELECT @c = 'SELECT '
--SELECT @c = @c + 'DISTINCT(Count(SC07003)) "Count", '
SELECT @c = @c + 'SC07003 "StockCode", ' 
SELECT @c = @c + 'SC01002 "Description1", '
SELECT @c = @c + 'SC01003 "Description2", ' 
SELECT @c = @c + 'SC07009 "WH", '
SELECT @c = @c + 'SC01038 "AltProd", '
SELECT @c = @c + 'SC07002 "TranDate", '
SELECT @c = @c + 'SC07004 "Qty", '
SELECT @c = @c + 'SC07006 "Reference", '
SELECT @c = @c + 'SC07005 "AvgCost", '
SELECT @c = @c + 'SC07005 * SC07004 "TotalCost", '
SELECT @c = @c + 'ABS(SC07005 * SC07004) "ABSCost", '
SELECT @c = @c + 'SC07007 "OrderNumber", '
SELECT @c = @c + 'Count(SC07003) "Count" '
--SELECT @c = @c + 'rtrim(cast(datepart(yyyy,SC07002) as char))+''M''+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)   =''' +  @YearMonth  + ''' ' 
SELECT @c = @c + 'FROM ScaCompanyDB..SC070100 ' 
--SELECT @c = @c + 'FROM ScaCompanyDB..SC070100 '
SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SC010100 '
SELECT @c = @c + 'ON SC01001 = SC07003 '  
--SELECT @c = @c + 'WHERE SC07002 >= ''2011-01-01:00:00:00.000'' '                                 
--SELECT @c = @c + 'WHERE rtrim(cast(datepart(yyyy,SC07002) as char))+''M''+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)   =''' +  @YearMonth  + ''' '
SELECT @c = @c + ' WHERE rtrim(cast(datepart(yyyy,SC07002) as char))+''M''+substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)   ='''  + @SelectedMonth  + ''' '
--SELECT @c = @c + 'AND SC07001 = ''2'' ' 
--SELECT @c = @c + 'AND SC01038 = ''CR'' '

SELECT @c = @c + 'AND SC07006 LIKE ''STK%AD%'' ' 
--SELECT @c = @c + 'OR SC07006 LIKE ''STK AD%'' '
IF @Department = 'Industrial' 
BEGIN
SELECT @c = @c + 'AND SC01038 IN (''IS'',''II'', ''IC'') '  
END
ELSE
IF @Department = 'Commercial'
BEGIN
SELECT @c = @c + 'AND SC01038 IN (''COS'',''COI'') ' 
END
ELSE
IF @Department = 'Retail'
BEGIN
SELECT @c = @c + 'AND SC01038 = ''RES''  '
END
ELSE
IF @Department = 'Raw Material'
BEGIN
SELECT @c = @c + 'AND SC01038 = ''RM''  '
END
ELSE
IF @Department = 'Service'
BEGIN
SELECT @c = @c + 'AND SC01038 = ''SE''  '
END
SELECT @c = @c + 'GROUP BY SC07003,SC01002,SC01003,SC07009,SC01038,SC07004,SC07006,SC07005,SC07007,SC07002 '
EXEC (@c)
END