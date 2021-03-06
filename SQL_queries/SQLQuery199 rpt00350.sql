USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00350]    Script Date: 10/05/2021 12:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00350] 
	-- Add the parameters for the stored procedure here
	@year as char(4), 
	@month as char(2)
AS
BEGIN

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
INSERT INTO dbo.ST03TEMP (SmanCode , OrderDate ,OrderNumber, InvoiceNumber , CostCentre, StockCode, Amount, AccString  ) 	
SELECT DISTINCT	 ST03007, ST03015,ST03009, ST03014, ST03011, ST03017, ST03040 , ST03011
FROM ScaCompanyDB..ST030100 WHERE ST03015 > '2010-01-01 00:00:00.000'  

UPDATE ST03TEMP 
SET InvoiceNumber  = '12'+ InvoiceNumber 
WHERE OrderDate  >= '2012-01-01 00:00:00.000'

UPDATE ST03TEMP 
SET InvoiceNumber  = '11'+ InvoiceNumber 
WHERE OrderDate  between '2011-01-01 00:00:00.000' and '2011-12-31 00:00:00.000'
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	Declare @YearMonth as CHAR(7), @c as NVARCHAR(4000)
	SELECT @YearMonth = @year + 'M' + @month

    -- Insert statements for procedure here
SELECT @c = 'SELECT	DISTINCT '
SELECT @c = @c + 'SL21001 "Cuscode",'
SELECT @c = @c + 'KK_AreaCode "AreaCode",'
SELECT @c = @c + 'SL01002 "Name", '
SELECT @c = @c + 'SL01107 "GST", '
SELECT @c = @c + 'SUBSTRING(AccString,7,6) "CC", '
SELECT @c = @c + 'SL21004 "TransactNumber", '
SELECT @c = @c + 'SL21002 "InvoiceNo", '
SELECT @c = @c + 'StockCode "StockCode", '
SELECT @c = @c + 'OrderDate "OrderDate", '
SELECT @c = @c + 'OrderNumber "OrderNumber", '
SELECT @c = @c + 'SL21005 "PaymentDate", '
SELECT @c = @c + 'Amount "Amount", '
--SELECT @c = @c + 'SL21007 "Amount", '
SELECT @c = @c + 'SmanCode "SmanCode"'
--SELECT @c = @c + 'SY24003 "SalesmanName", '
--SELECT @c = @c + 'OR20017 "OurReference", '
--SELECT @c = @c + 'OR20018 "YourReference" '
SELECT @c = @c + 'FROM ScaCompanyDB..SL210100 '
SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SL010100 '
SELECT @c = @c + 'ON SL21001 = SL01001 '
SELECT @c = @c + 'INNER JOIN  CustomerSalesmanBudget '
SELECT @c = @c + ' ON   SL21001 = KK_CustomerCode Collate Database_Default '
SELECT @c = @c + 'INNER JOIN [dbo].[ST03TEMP] '
SELECT @c = @c + 'ON SL21002 = InvoiceNumber COLLATE DATABASE_DEFAULT '
SELECT @c = @c + 'INNER JOIN ScaCompanyDB..OR200100 '
SELECT @c = @c + 'ON  OR20001 = OrderNumber COLLATE DATABASE_DEFAULT '
--SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SY240100 '
--SELECT @c = @c + 'ON SY24002 = ST03007 '
SELECT @c = @c + ' WHERE rtrim(cast(datepart(yyyy,SL21005) as char))+''M''+substring(cast(cast(datepart(mm,SL21005) as INT)+100 as char),2,2)   =''' +  @YearMonth  + ''' '
SELECT @c = @c + 'AND SUBSTRING(SL21001,1,2) <> ''ZZ'' '
SELECT @c = @c + 'AND SUBSTRING(CostCentre,7,6) = ''10'' ' 
SELECT @c = @c + 'AND StockCode NOT LIKE ''15-03%'' ' 
SELECT @c = @c + 'AND StockCode NOT LIKE ''15-50%'' ' 
SELECT @c = @c + 'AND StockCode NOT LIKE ''FREIGHT'' ' 
--SELECT @c = @c + 'AND SUBSTRING(ST03011,7,6)=  ''20''  '
--SELECT @c = @c + 'AND ST03020 > 0 '
--GROUP BY SL21001,SL01002, SL21002,SL21005,ST03015,ST03009, ST03007, SY24003
--SELECT @c = @c + 'ORDER BY SY24003,SL21002 '
--SELECT @c
EXEC (@c)
END
