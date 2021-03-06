USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00298_GNS]    Script Date: 10/05/2021 11:02:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00298_GNS] 
	-- Add the parameters for the stored procedure here
	@Department NVARCHAR(50)
	--@Location NVARCHAR(3)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT YEAR,Division,k.Location,cast(Period as int)"Period",Salesman,Name,Budget,Sales,Per_1,Sales_30
	FROM KK_SalesmanBudgets_GNS k
	INNER JOIN [Kingston Hardware]..tbl_Staff
	ON Salesman = EmployeeId
	Where YEAR = DATEPART("yyyy",GetDate())
	AND Period <= DATEPART("mm",GetDate()) 
	--AND Division = @Department
	AND Division = @Department and Salesman NOT IN ('5548', '6996','6661') 	
	order by Period
END