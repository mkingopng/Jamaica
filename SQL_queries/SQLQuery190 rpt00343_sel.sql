USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00343_Sel]    Script Date: 10/05/2021 12:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00343_Sel] 
	-- Add the parameters for the stored procedure here
	@year as char(4), 
	@month as char(2),
	@Location as nvarchar (4)
AS
BEGIN

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
SELECT @c = @c + 'PayDate "PaymentDate", '
SELECT @c = @c + 'Amount "Amount", '
--SELECT @c = @c + 'ST03040 "Amount", '
--SELECT @c = @c + 'ST03007 "SmanCode", '
SELECT @c = @c + 'SmanCode "SmanCode", '
SELECT @c = @c + 'Final_Amount "Final_Amount" '
SELECT @c = @c + 'FROM IscalaAnalysis..RPT343_1 '
SELECT @c = @c + ' WHERE rtrim(cast(datepart(yyyy,payDate) as char))+''M''+substring(cast(cast(datepart(mm,PayDate) as INT)+100 as char),2,2)   =''' +  @YearMonth  + ''' '

IF @Location = 'LAE' 
 SELECT @c = @c + 'AND CC = ''10''  '
ELSE
 SELECT @c = @c + 'AND CC IN (''20'')  '

--SELECT @c = @c + 'AND InvoiceNumber = ''11010691'' ' 
--SELECT @c = @c + 'AND SL21001 = ''LAEMAI2'' '
--SELECT @c = @c + 'AND ST03020 > 0 '
--GROUP BY SL21001,SL01002, SL21002,SL21005,ST03015,ST03009, ST03007, SY24003
--SELECT @c = @c + 'ORDER BY SY24003,SL21002 '
--SELECT @c
 EXEC (@c)

--SELECT @c = @c + 'AND SUBSTRING(ST03011,7,6) = ''20'' '

END
