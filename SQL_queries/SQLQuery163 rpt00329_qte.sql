USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00329_sel_qte]    Script Date: 10/05/2021 11:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00329_sel_qte]
		@StartDate as Datetime=NULL,
	    @EndDate as Datetime=NULL
AS
BEGIN
DECLARE		@c as NVARCHAR(4000)

SELECT @c = 'SELECT '
SELECT @c = @c + 'OR01001    "OrderNumber" '
SELECT @c = @c + ' ,  OR01015    "OrderDate" '
SELECT @c = @c + ' ,  OR01019    "Salesman" '
SELECT @c = @c + ' ,  SL01001    "CustomerCode" '
SELECT @c = @c + ' ,  SL01002    "CustomerName" '
SELECT @c = @c + ' , SUM(((OR03011 - OR03012) * OR03008) - ((OR03011 - OR03012) * OR03008 * OR03017 / 100))   "Net Value" '
SELECT @c = @c + ' FROM [ScaCompanyDB]..OR010100     INNER JOIN    [ScaCompanyDB]..OR030100 '
SELECT @c = @c + ' ON   OR01001 = OR03001 '
SELECT @c = @c + ' INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @c = @c + ' ON   OR03003 = SL01001 '
SELECT @c = @c + ' WHERE OR01015 BETWEEN ''' + CAST(@StartDate as CHAR(20)) + ''' and ''' + CAST(@EndDate as CHAR(20)) + ''' ' 
--SELECT @c = @c + 'AND OR01002  =  ''0'' '
SELECT @c = @c + 'GROUP BY  OR01001 , OR01015 , OR01019 , SL01001 , SL01002 '
SELECT @c = @c + 'ORDER by OR01015 '
EXEC (@c)
END