USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00298_Industrial]    Script Date: 10/05/2021 11:02:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00298_Industrial] 
	-- Add the parameters for the stored procedure here
	@Department NVARCHAR(50)
	--@Location NVARCHAR(3)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT YEAR,Division,k.Location,cast(Period as int)"Period",Salesman,Name,Budget,Per_1,Sales,Sales_30
	FROM KK_SalesmanBudgets_Industrial k
	INNER JOIN [Kingston Hardware]..tbl_Staff
	ON Salesman = EmployeeId
	Where YEAR = DATEPART("yyyy",GetDate())
	AND Period <= DATEPART("mm",GetDate()) 
	AND Division = @Department and Salesman NOT IN ('6662','6771','6718','6669','6759', '7611') 
	order by Period
END
