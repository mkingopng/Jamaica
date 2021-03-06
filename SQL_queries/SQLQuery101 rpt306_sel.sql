USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00306_Sel]    Script Date: 10/05/2021 11:08:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00306_Sel]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT su_sortvalue,
	SUM(su_onhandvalue - su_stockhistory)
   FROM KK_RPT00231Data
   WHERE 	su_onhandqty > su_stockhistory
   AND		(su_firstorderdate <su_sixmonthsago OR su_firstorderdate  = NULL)
   Group by SU_sORTvALUE
   orDER bY sU_SORTvALUE
END
