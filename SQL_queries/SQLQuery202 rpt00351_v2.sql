USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00351_sel_v2]    Script Date: 10/05/2021 13:00:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00351_sel_v2] 
	-- Add the parameters for the stored procedure here
		@StartDate Datetime=NULL,
		@EndDate   Datetime=NULL,
		@Department	 as NVARCHAR(256)	
		--@Customer  NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @c as NVARCHAR(4000),
			@CostCentre as NVARCHAR(64),
			@Single as bit
 
	-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
	-- The users supplies the Division/Department and we apply the cost centres
	SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
	SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
 
	SELECT @c = 'SELECT  '
	SELECT @c = @c + 'ST03001    "CustCode"' 
    SELECT @c = @c + ',  SC01001    "StockCode"' 
	SELECT @c = @c + ',  SC01002    "Description1"' 
	SELECT @c = @c + ',  SC01003    "Description2" '
	SELECT @c = @c + ', SUM(ST03020)   "Qty"' 
	SELECT @c = @c + ', SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100))   "NetValue"' 
	SELECT @c = @c + ', SUM(ST03020 * ST03023)   "CostValue"' 
	SELECT @c = @c + ', ST03022   "Discount"'
	SELECT @c = @c + ', SUM(((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023))   "NetProfit" '
	SELECT @c = @c + ' FROM [ScaCompanyDB]..ST030100 '     
	SELECT @c = @c + 'INNER JOIN    [ScaCompanyDB]..SC010100 ' 
	SELECT @c = @c + 'ON   ST03017 =  SC01001 '
	SELECT @c = @c + 'INNER JOIN    [ScaCompanyDB]..SL010100 T3 '
	SELECT @c = @c + 'ON   ST03008 = SL01001 '
	SELECT @c = @c + 'WHERE ST03015 BETWEEN ''' + CAST(@StartDate as CHAR(20)) + ''' and ''' + CAST(@EndDate as CHAR(20)) + ''' ' 
IF @Single = 1 
	IF @Single = 1 
		SELECT @c = @c + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
	Else
		SELECT @c = @c +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
	SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
	SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
	SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
	SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIOSER'' '
	SELECT @c = @c + 'AND SL01001 Like ''MAD%''' 
	SELECT @c = @c + 'GROUP BY    ST03001, SC01001 , SC01002 , SC01003,ST03022 '
	
--SELECT @c 
EXEC (@c)
END
