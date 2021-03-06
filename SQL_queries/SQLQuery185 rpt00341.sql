USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00341_sel]    Script Date: 10/05/2021 12:55:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00341_sel]
	-- Add the parameters for the stored procedure here
	@Year AS INTEGER
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT SC01001 "StockCode",
	SC01002 + ' ' + SC01003 "Description",
	SC33002 "Batch Warehouse",
	SC33005 "Batch Balance",
	SC33013 "Batch Date"
	into #work341
	FROM ScaCompanyDB..SC330100
	INNER JOIN ScaCompanyDB..SC030100
	ON SC33001 = SC03001
	INNER JOIN ScaCompanyDB..SC010100
	ON SC33001 = SC01001 
	INNER JOIN ScaCompanyDB..SY240100
	ON SY24002 = SC01037
	WHERE SC01037 = '5205' 
	AND SC33005 > 0
	AND YEAR(SC33013) = @Year
	GROUP BY SC01001, SC01002, SC01003, SC33005,SC33013, SC33002
	ORDER BY SC33013 DESC
	
	UPDATE #work341
	SET [Batch Warehouse] = 'LAE'
	WHERE [Batch Warehouse] IN ('01','12')
	
	UPDATE #work341
	SET [Batch Warehouse] = 'POM'
	WHERE [Batch Warehouse] IN ('03','04','13','14','15')
	SELECT * FROM #work341 ORder BY [Batch Date]
END
