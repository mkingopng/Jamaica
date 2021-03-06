USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00354]    Script Date: 10/05/2021 13:31:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00354] 
	-- Add the parameters for the stored procedure here
	@year as char(4), 
	@month as char(2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	Declare @YearMonth as CHAR(7), @c as NVARCHAR(4000)
	SELECT @YearMonth = @year + 'M' + @month

    -- Insert statements for procedure here
SELECT @c = 'SELECT	DISTINCT '
SELECT @c = @c + 'SL21001 "Cuscode",'
--SELECT @c = @c + 'KK_AreaCode "AreaCode",'
SELECT @c = @c + 'SL01002 "Name", '
SELECT @c = @c + 'SL01107 "GST", '
SELECT @c = @c + 'SL21004 "TransactNumber", '
SELECT @c = @c + 'SL21002 "InvoiceNo", '
SELECT @c = @c + 'ST03015 "OrderDate", '
SELECT @c = @c + 'ST03009 "OrderNumber", '
SELECT @c = @c + 'SL21005 "PaymentDate", '
--SELECT @c = @c + 'SL21007 "Amount", '
SELECT @c = @c + 'ST03040 "Amount", '
SELECT @c = @c + 'ST03007 "SmanCode", '
--SELECT @c = @c + 'SY24003 "SalesmanName", '
SELECT @c = @c + 'OR20017 "OurReference", '
SELECT @c = @c + 'OR20018 "YourReference" '
SELECT @c = @c + 'FROM ScaCompanyDB..SL210100 '
SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SL010100 '
SELECT @c = @c + 'ON SL21001 = SL01001 '
--SELECT @c = @c + 'INNER JOIN  CustomerSalesmanBudget '
--SELECT @c = @c + ' ON   SL21001 = KK_CustomerCode Collate Database_Default '
SELECT @c = @c + 'INNER JOIN ScaCompanyDB..ST030100 '
SELECT @c = @c + 'ON SL21002 = ST03014 '
SELECT @c = @c + 'INNER JOIN ScaCompanyDB..OR200100 '
SELECT @c = @c + 'ON ST03009 = OR20001 '
--SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SY240100 '
--SELECT @c = @c + 'ON SY24002 = ST03007 '
SELECT @c = @c + ' WHERE rtrim(cast(datepart(yyyy,SL21005) as char))+''M''+substring(cast(cast(datepart(mm,SL21005) as INT)+100 as char),2,2)   =''' +  @YearMonth  + ''' '
SELECT @c = @c + 'AND SUBSTRING(SL21001,1,2) <> ''ZZ'' '
SELECT @c = @c + 'AND SUBSTRING(ST03011,7,6) = ''20'' '
SELECT @c = @c + 'AND ST03017 NOT LIKE ''15-03%'' ' 
SELECT @c = @c + 'AND ST03017 NOT LIKE ''15-50%'' ' 
SELECT @c = @c + 'AND ST03017 NOT LIKE ''FREIGHT'' ' 
--SELECT @c = @c + 'AND ST03020 > 0 '
--GROUP BY SL21001,SL01002, SL21002,SL21005,ST03015,ST03009, ST03007, SY24003
--SELECT @c = @c + 'ORDER BY SY24003,SL21002 '
--SELECT @c
EXEC (@c)
END
