USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00297]    Script Date: 10/05/2021 11:01:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00297] 
AS

--Create SSRS_RPt00297 Vsn 1.0
--Wayne Dunn 16/2/2010
--Select Sales and Budget for the current Year/Month 
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

SELECT @command = 'SELECT CostCentreDescription,'	
SELECT @command = @command + 'SUM(BudgetSalesValue)as Budget, '
SELECT @command = @command + 'SUM(SalesValue) as Sales ' 
SELECT @command = @command + 'FROM ' + @InputTable +  ' '
SELECT @command = @command +  'WHERE period = ' + @monthValue
SELECT @command = @command +  'AND CostCentre   < 90  '
SELECT @command = @command +  'GROUP BY CostCentreDescription' 
--SELECT @command
EXEC ( @command)
