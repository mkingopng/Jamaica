USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00298]    Script Date: 10/05/2021 11:01:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00298] 
	-- Add the parameters for the stored procedure here
	@Department NVARCHAR(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT YEAR,Division,k.Location,cast(Period as int)"Period",Salesman,Name,Budget,Sales,Comm,Per_1,Per_1_5,Per_2
	FROM KK_SalesmanBudgets_Commercial k
	INNER JOIN [Kingston Hardware]..tbl_Staff
	ON Salesman = EmployeeId
	Where YEAR = DATEPART("yyyy",GetDate())
	AND Period <= DATEPART("mm",GetDate())
--	AND Division = @Department
	AND Division = @Department and Salesman NOT IN ('4904','6771','6718','6669') 
	Order by Period
END
