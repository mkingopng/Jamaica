USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00329_test]    Script Date: 10/05/2021 11:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00329_test]
		@Department	 as NVARCHAR(256),
		@StartDate as Datetime=NULL,
	    @EndDate as Datetime=NULL
AS


BEGIN


DECLARE		@c as NVARCHAR(4000),
			@CostCentre as NVARCHAR(64),
			@Single as bit
			
SELECT @CostCentre = (Select CostCentre From KK_LAEPOMCC Where Department = @Department)
		
SELECT @c = 'SELECT '
SELECT @c = @c + 'ST03009    "OrderNumber" '
SELECT @c = @c + ' ,  ST03014    "InvoicNumber" '
SELECT @c = @c + ' ,  ST03015    "InvOrderDate" '
SELECT @c = @c + ' ,  SL01001    "CustomerCode" '
SELECT @c = @c + ' ,  SL01002    "CustomerName" '
SELECT @c = @c + ' ,  SC01001    "StockCode" '
SELECT @c = @c + ' ,  SC01002    "Description1" '
SELECT @c = @c + ' ,  ST03022    "Discount" '
SELECT @c = @c + ' , SUM(ST03020)   "Qty" '
SELECT @c = @c + ' , SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100))   "NetValue" '
SELECT @c = @c + ' , SUM(ST03020 * ST03023)   "CostValue" '
SELECT @c = @c + ' ,  ST03007    "Salesman" '
SELECT @c = @c + ' ,  ST03029    "Warehouse" ' --added 09-08-2021 Julius's request

SELECT @c = @c + ' ,  SUBSTRING(ST03011,7,6)    "CostCentre" '

SELECT @c = @c + ' ,  OR20072    "CustPO" ' --added 11-06-2020

SELECT @c = @c + ' FROM [ScaCompanyDB]..ST030100     INNER JOIN    [ScaCompanyDB]..SC010100 '
SELECT @c = @c + ' ON   ST03017 = SC01001 '
SELECT @c = @c + ' INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @c = @c + ' ON   ST03008 = SL01001 '

SELECT @c = @c + ' INNER JOIN    [ScaCompanyDB]..OR200100 ' --added 11-06-2020
SELECT @c = @c + ' ON   ST03009 = OR20001 ' --added 11-06-2020


SELECT @c = @c + ' WHERE ST03015 BETWEEN ''' + CAST(@StartDate as CHAR(20)) + ''' and ''' + CAST(@EndDate as CHAR(20)) + ''' ' 
--IF @Department='LAE Cost Centres'
--Else
	SELECT @c = @c +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @CostCentre + ' '
--IF @Department='POM Cost Centres'
--	SELECT @c = @c +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
--	SELECT @c = @c +  'AND SUBSTRING(ST03011,7,2)  IN (''10'',''11'') '

SELECT @c = @c + 'AND SUBSTRING(ST03008,1,4) <> ''INTR'' '
--SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' ' commented out for Freight Charges to be reflective 09-08-2021 Julius's request
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
SELECT @c = @c + 'GROUP BY  ST03009 , ST03014 , ST03015 , SL01001 , SL01002 , SC01001 , SC01002 , ST03007 , SUBSTRING(ST03011,7,6),ST03022,OR20072,ST03029 '
SELECT @c = @c + 'order by ST03015 '
EXEC (@c)
End