USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00296]    Script Date: 10/05/2021 11:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00296] 
AS

--Create SSRS_RPt00296 Vsn 1.0
--Wayne Dunn 16/2/2010
--Select Sales and Budget for the current Year/Month  -  display as screen saver
--Written as exec commands so values can be calculated

SET NOCOUNT ON

DECLARE @MonthValue as CHAR(7),
		@YearValue as CHAR(7),
		@InputTable as NVARCHAR(128),
		@command as NVARCHAR(2048)
		
SELECT @MonthValue =  datepart(MM,GETDATE()) 	
SELECT @YearValue =  datepart(YY,GETDATE()) 
--substring(cast(cast

--Calculate tablenames
SELECT @InputTable = 't_kpi_sales_' + @YearValue

SELECT @command = 'SELECT	SUM(BudgetSalesValue)as Budget, '
SELECT @command = @command + 'SUM(SalesValue) as Sales ' 
SELECT @command = @command + 'FROM ' + @InputTable +  ' '
SELECT @command = @command +  'WHERE period = ' + @monthValue
SELECT @command = @command +  'AND CostCentre   = 99'
--SELECT @command
EXEC ( @command)
