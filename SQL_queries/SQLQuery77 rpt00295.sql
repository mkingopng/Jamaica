USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00295]    Script Date: 10/05/2021 11:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00295] 
	@StartDate as Datetime,
	@EndDate as Datetime,
	@WorkCentre aS NVARCHAR (64) = ''
AS
BEGIN 
/* ************************************************* */ 
DECLARE @command as NVARCHAR(4000)

SELECT @command = 'SELECT '
SELECT @command = @command + '	 MP64001    "WorkorderNo" '
SELECT @command = @command +  ', MP64002    "StockCode" '
SELECT @command = @command +  ', SC01002 + '' '' + SC01003 "Description" '
SELECT @command = @command +  ', MP64003    "Warehouse" ' 
SELECT @command = @command +  ', SUM(MP64004)   "PlannedQty" '
SELECT @command = @command +  ', MP67009    "UnitsPerHour" ' 
SELECT @command = @command +  ', MP67010 "RunTime" '
SELECT @command = @command +  ', (SUM(MP64004) * MP67010)   "RunTimeinHours" '
SELECT @command = @command +  ', MP67006 "WorkCentre" '
SELECT @command = @command +  'FROM [ScaCompanyDB]..MP640100 '
SELECT @command = @command +  'INNER JOIN [ScaCompanyDB]..MP670100 '
SELECT @command = @command +  'ON MP64001 = MP67001 '
SELECT @command = @command +  'INNER JOIN [ScaCompanyDB]..SC010100 '
SELECT @command = @command +  'ON MP64002 = SC01001 '
SELECT @command = @command +  'WHERE MP64012 Between ''' +  convert(nvarchar(20), @StartDate) + ''' and ''' +  convert(nvarchar(20), @EndDate)+ '''' 
IF @WorkCentre <> 'ALL'
	SELECT @command = @command +  'AND MP67006  =  ''' + @WorkCentre + ''''
SELECT @command = @command +  ' GROUP BY  '
SELECT @command = @command +  'MP64001'
SELECT @command = @command +  ',	MP67006'
SELECT @command = @command +  ',	MP64002'
SELECT @command = @command +  ',	SC01002'
SELECT @command = @command +  ' ,	SC01003'
SELECT @command = @command +  ',	MP64003'
SELECT @command = @command +  ' ,	MP67009'
SELECT @command = @command +  ',	MP67010 '
SELECT @command = @command +  'ORDER BY MP64001'
--SELECT @command
EXEC (@command)
END 



