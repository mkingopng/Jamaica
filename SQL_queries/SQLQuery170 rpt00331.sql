USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00331_sel]    Script Date: 10/05/2021 11:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00331_sel] 
	-- Add the parameters for the stored procedure here
	@Year as NVARCHAR(4),
	@department	 as NVARCHAR(256)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Search as NVARCHAR(2048),
			@CostCentre as NVARCHAR(256),
			@Single as bit
				
-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

SELECT @search =  'SELECT '
SELECT @Search = @Search + '  T2.SL01001    "CustomerCode" ' 
SELECT @Search = @Search + ',  T2.SL01002    "CustomerName" ' 
SELECT @Search = @Search + ',  T3.SC01001    "StockCode" '
SELECT @Search = @Search + ',  T3.SC01002 + '' '' + T3.SC01003    "Description" '
SELECT @Search = @Search + ', SUM(T1.ST03020)   "Qty" '
SELECT @Search = @Search + ', SUM((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100))   "Net Value" '
SELECT @Search = @Search + ', SUM(((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100)) - (T1.ST03020 * T1.ST03023))   "Net Profit" '
SELECT @Search = @Search + ' FROM [ScaCompanyDB]..ST030100 T1 '    
SELECT @Search = @Search + ' INNER JOIN    [ScaCompanyDB]..SC010100 T3 '
SELECT @Search = @Search + ' ON   T1.ST03017 = T3.SC01001 '
SELECT @Search = @Search + ' INNER JOIN    [ScaCompanyDB]..SL010100 T2 '
SELECT @Search = @Search + ' ON   T1.ST03008 = T2.SL01001 '
SELECT @Search = @Search + ' LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T4 '
SELECT @Search = @Search + ' ON   T1.ST03007 = T4.SY24002  AND ''BK'' = T4.SY24001 '
IF @Single = 1 
	SELECT @search = @search +  'WHERE SUBSTRING(ST03011,7,2)  =  ' +  @costcentre  +  ' '
Else
	SELECT @search = @search +  'WHERE SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
SELECT @Search = @Search + ' AND   rtrim(cast(datepart(yyyy,T1.ST03015) as char))   =''' +   @Year + ''''
SELECT @Search = @Search + ' AND   T3.SC01039   LIKE ''%AIKWEL%'''
SELECT @Search = @Search + ' GROUP BY ' 
SELECT @Search = @Search + '  T2.SL01001 '
SELECT @Search = @Search + ', T2.SL01002 '
SELECT @Search = @Search + ', T3.SC01001 '
SELECT @Search = @Search + ', T3.SC01002 '
SELECT @Search = @Search + ', T3.SC01003 '
--SELECT @Search = @Search + ', ' +  @department + ' '
--SELECT @search
EXEC (@search)
 
END
