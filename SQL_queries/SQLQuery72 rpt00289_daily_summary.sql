USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00289_DailySummary_sel]    Script Date: 10/05/2021 10:57:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00289_DailySummary_sel]
	@YearValue As NVARCHAR(4) = NULL ,
	@PeriodValue Integer = NULL
	
AS

SET NOCOUNT ON

DECLARE @OutputTable as NVARCHAR(32),
		@command as NVARCHAR(2048),
		@currentvalue as char(7),
		@parameter as NVARCHAR(128),
		@output1 as Datetime,
		@output2  as NVARCHAR(256),
		@output3  as NVARCHAR(256)
	
SELECT @output1 = GETDATE()
SELECT @output2= '##KK' + Replace(REPLACE(REPLACE(REPLACE(@output1,'-',''),' ',''),':',''),'.','') + 'a'
SELECT @output3= '##KK' + Replace(REPLACE(REPLACE(REPLACE(@output1,'-',''),' ',''),':',''),'.','') + 'b'
SELECT @parameter = '''IsUserTable'''

IF @YearValue is NULL
	SELECT @YearValue = YEAR(GETDATE())

IF @PeriodValue is NULL
	SELECT @PeriodValue = Month(GETDATE())
	
SELECT @currentvalue = @YearValue + 'M' + substring(cast(@PeriodValue + 100 as char),2,2)
 
SELECT @OutputTable = 't_kpi_sales_' + @YearValue

SELECT @command = 'if exists (select * from dbo.sysobjects where id = object_id(''' + @output2 + ''')' 
SELECT @command = @command + ' and OBJECTPROPERTY(id, N' + @parameter + ') = 1)'
SELECT @command = @command +  '   BEGIN drop table ' + @output2 + ' END' 
EXEC  (@command)

SELECT @command = 'Create Table ' +  @output2 + ' '
 SELECT @command = @command + '( '
 SELECT @command = @command + 'Period Integer, '
 SELECT @command = @command + 'CostCentre Integer, '
 SELECT @command = @command + 'Product NVARCHAR(32), '
 SELECT @command = @command + 'SalesValue NUMERIC(20,8), '
 SELECT @command = @command + 'BudgetSalesValue  NUMERIC(20,8), '
 SELECT @command = @command + 'Difference  NUMERIC(20,8), '
 SELECT @command = @command + 'Percentage  NUMERIC(20,8), '
 SELECT @command = @command + 'CostCentreName   NVARCHAR(128), '
 SELECT @command = @command + 'ProductDescription   NVARCHAR(128),'
 SELECT @command = @command + 'OutstandingOrders NUMERIC(20,8), '
 SELECT @command = @command + 'LaeServiceInternalSales NUMERIC(20,8), '
 SELECT @command = @command + 'POMServiceInternalSales NUMERIC(20,8), '
 SELECT @command = @command + 'Category INTEGER, '
 SELECT @command = @command + 'CategoryName NVARCHAR(64), '
 SELECT @command = @command + 'KKGrp NVARCHAR(128) '
 SELECT @command = @command + ') ON [PRIMARY]'
 --SELECT @command
 EXEC (@command)

SELECT @command = 'INSERT INTO ' +  @output2 + ' '  
SELECT @command = @command + 'SELECT Period, '
SELECT @command = @command + 'CostCentre, '
SELECT @command = @command + 'Product, '
SELECT @command = @command + 'ABS(SalesValue), '
SELECT @command = @command + 'BudgetSalesValue, '
SELECT @command = @command + '(SELECT BudgetSalesValue - ABS(SalesValue)), '
SELECT @command = @command + '0,'
SELECT @command = @command + 'CostCentreDescription, '
SELECT @command = @command + 'productDescription, '
SELECT @command = @command + 'OutstandingOrders,'
SELECT @command = @command + '0,'
SELECT @command = @command + '0,'
SELECT @command = @command + '1,'
SELECT @command = @command + 'NULL,  ' 
SELECT @command = @command + 'NULL  ' 
SELECT @command = @command + 'FROM '  + @OutputTable + ' '
SELECT @command = @command + 'WHERE  CostCentre  < ''90'' '
IF @PeriodValue IS NOT NULL	
	SELECT @command = @command + 'AND  Period  = ''' + Str(@PeriodValue) + ''' '
SELECT @command = @command + ' ORDER BY CostCentre,Period,ProductDescription'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''1'', CategoryName  = ''Lae Industrial Sales'', KKGrp = ''Industrial''  '
SELECT @command = @command + 'WHERE  CostCentre = 10'
SELECT @command = @command + 'and Product IN (''AIBAIR'',''AIAABR'',''AICHAN'',''AIDCLE'',''AIEMET'',''AIFMIS'',''AIGNAI'',''AIHPAC'',''AIIPOW'',''AIJSAF'',''AILWOO'',''AINWOR'',''AISSUN'',''ACSOLL'',''AIDRNK'',''AISHAR'',''AIXABC'')'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''2'', CategoryName  = ''Lae Rotomoulding Sales (Ind Sales)'', KKGrp = ''Industrial'' '
SELECT @command = @command + 'WHERE Product = ''AIPROT'' AND CostCentre = 10 '
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''3'', CategoryName  = ''Lae Equipment Sales (Ind Sales)'', KKGrp = ''Industrial'' '
SELECT @command = @command + 'WHERE Product = ''AIBAIE'' AND CostCentre = 10 '
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''4'', CategoryName  = ''Lae Generator Sales (Ind Sales)'', KKGrp = ''Industrial'' '
SELECT @command = @command + 'WHERE Product = ''AIDGDI'' AND CostCentre = 10 '
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''5'', CategoryName  = ''Lae Welding Sales (Ind Sales)'', KKGrp = ''Industrial''  '
SELECT @command = @command + 'WHERE Product = ''AIKWEL'' AND CostCentre = 10 '
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''6'', CategoryName  = ''Lae Commercial Sales'', KKGrp = ''Commercial''  '
SELECT @command = @command + 'WHERE CostCentre = 11'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''7'', CategoryName  = ''Lae Plastic Bottles & Caps Sales'', KKGrp = ''Commercial''  '
SELECT @command = @command + 'WHERE Product = ''ACBBOT'' AND CostCentre = 11'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''8'', CategoryName  = ''Export Industrial'', KKGrp = ''Industrial''  '
SELECT @command = @command + 'WHERE CostCentre = 12'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''9'', CategoryName  = ''Export Commerical'', KKGrp = ''Commercial''  '
SELECT @command = @command + 'WHERE CostCentre = 13'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''10'', CategoryName  = ''Lae Retail Sales'', KKGrp = ''Retail''  '
SELECT @command = @command + 'WHERE CostCentre = 14'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''11'', CategoryName  = ''Lae Service Sales (External)'', KKGrp = ''Service''  '
SELECT @command = @command + 'WHERE CostCentre = 15'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''12'', CategoryName  = ''Export Retail Sales'' , KKGrp = ''Retail'' '
SELECT @command = @command + 'WHERE CostCentre = 16'
EXEC (@command)


SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''13'', CategoryName  = ''Pom Industrial Sales'', KKGrp = ''Industrial''  '
SELECT @command = @command + 'WHERE CostCentre = 20'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''14'', CategoryName  = ''POM Rotomoulding Sales (Ind Sales)'' , KKGrp = ''Industrial'' '
SELECT @command = @command + 'WHERE Product = ''AIPROT'' AND CostCentre = 20 '
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''15'', CategoryName  = ''POM Rotomoulding Sales (Ind Sales)'', KKGrp = ''Industrial''  '
SELECT @command = @command + 'WHERE Product = ''AIBAIE'' AND CostCentre = 20 '
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''16'', CategoryName  = ''POM Generator Sales (Ind Sales)'', KKGrp = ''Industrial''  '
SELECT @command = @command + 'WHERE Product = ''AIDGDI'' AND CostCentre = 20 '
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''17'', CategoryName  = ''POM Welding Sales (Ind Sales)'', KKGrp = ''Industrial''  '
SELECT @command = @command + 'WHERE Product = ''AIKWEL'' AND CostCentre = 20 '
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''18'', CategoryName  = ''POM Commercial Sales'' , KKGrp = ''Commercial'' '
SELECT @command = @command + 'WHERE CostCentre = 21'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''19'', CategoryName  = ''POM Plastic Bottles & Caps Sales'', KKGrp = ''Commercial''  '
SELECT @command = @command + 'WHERE Product = ''ACBBOT'' AND CostCentre = 21'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''20'', CategoryName  = ''POM Retail Sales'', KKGrp = ''Retail''  '
SELECT @command = @command + 'WHERE CostCentre = 24'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''21'', CategoryName  = ''POM Service Sales (External)'' , KKGrp = ''Service'' '
SELECT @command = @command + 'WHERE CostCentre = 25'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''22'', CategoryName  = ''Industrial Contracts'' , KKGrp = ''Industrial'' '
SELECT @command = @command + 'WHERE CostCentre = 30'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''23'', CategoryName  = ''Industrial Hire'' , KKGrp = ''Industrial'' '
SELECT @command = @command + 'WHERE CostCentre = 31'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''100'', CategoryName  = ''Oil Sales'' , KKGrp = ''Retail'' ' 
SELECT @command = @command + 'WHERE CostCentre = 19'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''24'', CategoryName  = ''Internal Maintainence'' , KKGrp = ''Industrial'' '
SELECT @command = @command + 'WHERE CostCentre = 46'
EXEC (@command)

SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Category = ''25'', CategoryName  = ''Lae Industrial Equip Hire'' , KKGrp = ''Industrial'' '
SELECT @command = @command + 'WHERE CostCentre = 33'
EXEC (@command)

SELECT @command = 'SELECT  Category "wcategory", SUM(BudgetSalesValue) "Budget", SUM(SalesValue) "Sales" INTO ##work2 FROM ' +  @output2 + ' Group BY Category '
EXEC (@command)


SELECT @command = 'UPDATE ' + @output2 + ' '
SELECT @command = @command + 'SET Percentage  = Sales / Budget  '
SELECT @command = @command + 'FROM ##work2 '
SELECT @command = @command + 'WHERE Category = wCategory AND Budget<> 0 '
--SELECT @command
EXEC (@command)

DROP Table ##work2

SELECT @command = 'UPDATE  ' + @output2 + ' '
SELECT @command = @command + ' SET LaeServiceInternalSales = ' 
SELECT @command = @command + '(SELECT SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) ' 
SELECT @command = @command + 'FROM ScaCompanyDB..ST030100 '
SELECT @command = @command + 'WHERE SUBSTRING(ST03011,7,2) = ''15'' ' 
SELECT @command = @command + 'AND cast(datepart(yyyy,ST03015) as char(4))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @CurrentValue + ''' '
SELECT @command = @command + 'AND SUBSTRING(ST03001,1,4) = ''INTR'' ) '  
--SELECT @command
EXEC (@command)

SELECT @command = 'Update ' + @output2 + ' SET LaeServiceInternalSales = 0 WHERE LaeServiceInternalSales IS NULL '
EXEC (@command)

SELECT @command = 'UPDATE  ' + @output2 + ' '
SELECT @command = @command + ' SET POMServiceInternalSales = ' 
SELECT @command = @command + '(SELECT SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) ' 
SELECT @command = @command + 'FROM ScaCompanyDB..ST030100 '
SELECT @command = @command + 'WHERE SUBSTRING(ST03011,7,2) = ''25'' ' 
SELECT @command = @command + 'AND cast(datepart(yyyy,ST03015) as char(4))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @CurrentValue + ''' '
SELECT @command = @command + 'AND SUBSTRING(ST03001,1,4) = ''INTR'' ) '  
--SELECT @command
EXEC (@command)

SELECT @command = 'Update ' + @output2 + ' SET POMServiceInternalSales = 0 WHERE POMServiceInternalSales IS NULL '
EXEC (@command)


SELECT @command = 'SELECT Category,CategoryName, KKGrp, SalesValue, BudgetSalesValue , Difference, Percentage, OutstandingOrders,LaeServiceInternalSales, PomServiceInternalSales FROM ' + @output2  + ' '
SELECT @command = @command + 'Order By Category '
EXEC (@command)

SELECT @command = 'DROP TABLE ' +  @output2 + ' '
EXEC (@command)

