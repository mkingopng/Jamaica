USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00298_Rotomould]    Script Date: 10/05/2021 11:03:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SSRS_Rpt00298_Rotomould] 
	-- Add the parameters for the stored procedure here
	@Department NVARCHAR(50)
	--@Location NVARCHAR(3)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT YEAR,Division,k.Location,cast(Period as int)"Period",Salesman,Name,Budget,Sales, Per_1,Sales_30
	FROM KK_SalesmanBudgets_Rotomould k
	INNER JOIN [Kingston Hardware]..tbl_Staff
	ON Salesman = EmployeeId
	Where YEAR = DATEPART("yyyy",GetDate())
	AND Period <= DATEPART("mm",GetDate()) 
	AND Division = @Department and Salesman NOT IN ('6662','6771','6718','6669') 
	order by Period
END

