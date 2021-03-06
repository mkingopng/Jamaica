USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00265_v3]    Script Date: 10/05/2021 10:54:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	Extract records for KK_OutstandingOrders
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00265_v3] 
	
		@StartDate as Datetime = NULL,
		@EndDate as Datetime = NULL,
		@Department as NVARCHAR(64)= NULL,
		@Variation as CHAR(1) = NULL
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET	ANSI_NULLS OFF;
	
	
	DECLARE @year as Integer,
			@cmd as VARCHAR(8000)
		    --@ALLDepartment as NVARCHAR(64)
	
	IF (@StartDate) IS NULL
	BEGIN
		SELECT @year = DATEPART(year, GETDATE())
		SELECT @year = @year -1
		SELECT @StartDate =CAST(@year as CHAR(4)) + '-01-01'
		SELECT @EndDate = GETDATE()
	END

	SELECT Order# as SelectedOrders,
			SUM(FullFilledCount) as FFCount,
			SUM(LineCount) AS LCount,
			'0' AS Complete
	INTO #work265s
	FROM KK_OutstandingOrders
	GROUP BY Order#	
	
	Update #work265s
		Set Complete = '1'
		WHERE FFCount = LCount	
			
	Update #work265s
		Set Complete = '2'
		WHERE LCount > FFCount
		AND FFCount > 0
	
	Update #work265s
		Set Complete = '3'
		WHERE FFCount = 0

--	SELECT @ALLDepartment=NULL

	SELECT @cmd ='SELECT * FROM KK_OutstandingOrders  '
	SELECT @cmd = @cmd + 'INNER JOIN #work265s ON Order# = SelectedOrders '
	SELECT @cmd = @cmd + 'WHERE OrderDate BETWEEN ''' +  (SELECT CONVERT(VARCHAR(10), @StartDate, 120) AS [YYYY-MM-DD]) + ''' and ''' +  (SELECT CONVERT(VARCHAR(10), @EndDate, 120) AS [YYYY-MM-DD]) + ''' '
	
	IF NOT @Department IS NULL
	SELECT @cmd = @cmd + 'AND O_Department = ''' +  @Department +  ''' '
 --   ELSE 
	--SELECT @cmd = @cmd + 'AND O_Department = ''' +  @ALLDepartment +  ''' '
     
	SELECT @cmd = @cmd + 'AND OrderType > ''0'' '
	
	IF NOT @Variation IS NULL
	SELECT @cmd = @cmd + 'AND Complete = ''' + @Variation + ''' '
	--SELECT @cmd
	EXEC (@cmd)
END