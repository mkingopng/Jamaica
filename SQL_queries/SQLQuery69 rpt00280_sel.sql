USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00280_sel]    Script Date: 10/05/2021 10:56:20 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00280_sel]
@Division as varchar(8000)= null,
@Location as varchar(40)= null
-- Slow Moving Stock Report

-- Version 2
-- Wayne Dunn 4/1/2008
--  New version designed to save time and ensure that each of various runs of the report are based on consistent data
--  The process is that KK_RPT00231_GETDATA is run automatically by SQL Server agent at the end of each month and captures 
--  all the data required to produce the report.  This means it is only runs once per month and then the report is run against with various parameters
--  required for each department .
--  N.B. Same name as the original script to ensure compatability with the report

--Version 3
-- Wayne Dunn 10/6/08
-- Updated to ensure it always run as start of month


AS

	SELECT	 * 
	FROM		KK_Rpt00231Data 
	where UPPER(su_extendedproductgroup) in ("DNR","OBSOLETE")
	AND       su_division collate database_default in (Select Value from dbo.Split(',',@Division)  ) 
	AND       su_location collate database_default in (Select Value from dbo.Split(',',@Location)  )
	--WHERE 	su_onhandqty > su_stockhistory
	--AND		(su_firstorderdate <su_sixmonthsago OR su_firstorderdate  = NULL)
		
	ORDER BY 	su_sortvalue, su_item