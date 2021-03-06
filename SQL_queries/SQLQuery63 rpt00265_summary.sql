USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00265_Summary]    Script Date: 10/05/2021 10:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 15/7/2010
-- Description:	Extract Sum of a Departments outstanding orders
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00265_Summary]
	@Department as NVARCHAR(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT SUM(Value) FROM KK_OutstandingOrders
	WHERE O_Department = @Department
	AND OrderType > '0'
	
END
