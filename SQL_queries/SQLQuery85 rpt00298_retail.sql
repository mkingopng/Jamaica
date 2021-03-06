USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00298_Retail]    Script Date: 10/05/2021 11:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SSRS_Rpt00298_Retail] 
	@Department NVARCHAR(50)
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT YEAR,Division,k.Location,cast(Period as int)"Period",Salesman,Name,Budget,Sales,Per_1,Sales_30
	FROM KK_SalesmanBudgets_Retail k
	INNER JOIN [Kingston Hardware]..tbl_Staff
	ON Salesman = EmployeeId
	Where YEAR = DATEPART("yyyy",GetDate())
	AND Period <= DATEPART("mm",GetDate()) 
--	AND Division = @Department
	AND Division = @Department and Salesman NOT IN ('5548', '6996', '6661') 
--K343,000.00 - 	
	order by Period
END

