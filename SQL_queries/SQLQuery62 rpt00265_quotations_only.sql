USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00265_QuotationsOnly]    Script Date: 10/05/2021 10:53:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 15/07/2010
-- Description:	Extract records for KK_Quotations
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00265_QuotationsOnly] 
	
		@StartDate as Datetime = NULL,
		@EndDate as Datetime = NULL,
		@Department as NVARCHAR(64)= NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET	ANSI_NULLS OFF;
	
	
	DECLARE @year as Integer,
			@cmd as VARCHAR(8000)
			
	
	
	IF (@StartDate) IS NULL
	BEGIN
		SELECT @year = DATEPART(year, GETDATE())
		SELECT @year = @year -1
		SELECT @StartDate =CAST(@year as CHAR(4)) + '-01-01'
		SELECT @EndDate =  GETDATE()
	END

	SELECT @cmd ='SELECT * FROM KK_Quotations WHERE OrderDate BETWEEN ''' +  (SELECT CONVERT(VARCHAR(10), @StartDate, 120) AS [YYYY-MM-DD]) + ''' and ''' +  (SELECT CONVERT(VARCHAR(10), @EndDate, 120) AS [YYYY-MM-DD]) + ''' '
	IF NOT @Department IS NULL
		SELECT @cmd = @cmd + 'AND O_Department = ''' +  @Department +  ''' '
		
	SELECT @cmd = @cmd + 'AND OrderType = ''0'' '
	--SELECT @cmd
	EXEC (@cmd)
END


