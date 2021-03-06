USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00343_OrderDate]    Script Date: 10/05/2021 12:56:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00343_OrderDate] 
	-- Add the parameters for the stored procedure here
	@year as char(4), 
	@month as char(2),
	@Location as nvarchar (4)
AS
BEGIN

EXEC [dbo].[SSRS_RPT00343-2]
--drop table [KK_StockSuplier]
drop table [dbo].[ST03TEMP]
create table [dbo].[ST03TEMP](
	
	SmanCode			varchar(5),	
	OrderDate			datetime,
	OrderNumber			varchar(15),
	InvoiceNumber       nvarchar(15),
	CostCentre			nvarchar(50),
	StockCode           nvarchar(35),  
	Amount              numeric(28),
	AccString           nvarchar(50)	
	)	
--INSERT INTO dbo.ST03TEMP (SmanCode , OrderDate ,OrderNumber, InvoiceNumber , CostCentre, StockCode, Amount, AccString  ) 	
--SELECT DISTINCT	 ST03007, ST03015,ST03009, ST03014, ST03011, ST03017, ST03040 , ST03011
--FROM ScaCompanyDB..ST030100 WHERE ST03015 > '2010-01-01 00:00:00.000'  

--UPDATE ST03TEMP 
--SET InvoiceNumber  = '13'+ InvoiceNumber 
--WHERE OrderDate  >= '2012-12-29 00:00:00.000'

--UPDATE ST03TEMP 
--SET InvoiceNumber  = '12'+ InvoiceNumber 
--WHERE OrderDate  between '2012-01-01 00:00:00.000' and '2012-12-28 00:00:00.000'
    
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	Declare @YearMonth as CHAR(7), @c as NVARCHAR(4000)
	SELECT @YearMonth = @year + 'M' + @month

    -- Insert statements for procedure here
SELECT @c = 'SELECT	 '
SELECT @c = @c + 'Cuscode "Cuscode",'
--SELECT @c = @c + 'KK_AreaCode "AreaCode",'
SELECT @c = @c + 'Name "Name", '
SELECT @c = @c + 'CC "CostCentre" ,'
--SELECT @c = @c + 'SUBSTRING(ST03011,7,6) "CostCentre",'
SELECT @c = @c + 'GST "GST", '
SELECT @c = @c + 'TranNum "TransactNumber", '
SELECT @c = @c + 'InvoiceNo "InvoiceNo", '
SELECT @c = @c + 'OrderDate "OrderDate", '
--SELECT @c = @c + 'ST03015 "OrderDate", '
--SELECT @c = @c + 'OrderNumber "OrderNumber", '
--SELECT @c = @c + 'ST03009 "OrderNumber", '
--SELECT @c = @c + 'PayDate "PaymentDate", '
SELECT @c = @c + 'Amount "Amount", '
--SELECT @c = @c + 'ST03040 "Amount", '
--SELECT @c = @c + 'ST03007 "SmanCode", '
SELECT @c = @c + 'SmanCode "SmanCode", '
SELECT @c = @c + 'Final_Amount "Final_Amount" '
SELECT @c = @c + 'FROM IscalaAnalysis..RPT343_2 '
SELECT @c = @c + ' WHERE rtrim(cast(datepart(yyyy,OrderDate) as char))+''M''+substring(cast(cast(datepart(mm,OrderDate) as INT)+100 as char),2,2)   =''' +  @YearMonth  + ''' '

IF @Location = 'LAE' 
 SELECT @c = @c + 'AND CC = ''10''  '
IF @Location = 'POM' 
 SELECT @c = @c + 'AND CC IN (''20'',''30'')  '
IF @Location = 'ALL'
 SELECT @c = @c + 'AND CC NOT IN (''10'',''20'')  '

--SELECT @c = @c + 'AND InvoiceNumber = ''11010691'' ' 
--SELECT @c = @c + 'AND SL21001 = ''LAEMAI2'' '
--SELECT @c = @c + 'AND ST03020 > 0 '
--GROUP BY SL21001,SL01002, SL21002,SL21005,ST03015,ST03009, ST03007, SY24003
--SELECT @c = @c + 'ORDER BY SY24003,SL21002 '
--SELECT @c
 EXEC (@c)

--SELECT @c = @c + 'AND SUBSTRING(ST03011,7,6) = ''20'' '

END
