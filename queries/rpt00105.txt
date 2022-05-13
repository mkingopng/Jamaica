USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00105_sel]    Script Date: 10/04/2021 14:43:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[SSRS_RPT00105_sel]
@Division as varchar(8000)= null,
@Location as varchar(40)= null

-- Obsolete Stock Report

-- Version 2
-- Wayne Dunn 4/1/2008
--  New version designed to save time and ensure that each of various runs of the report are based on consistent data
--  The process is that KK_RPT00105_CreateData & KK_RPT00105_CreateDataByWarehouse  is run automatically by SQL Server agent at the end of each month and captures 
--  all the data required to produce the report.  This means it is only runs once per month and then the report is run against with various parameters
--  required for each department .
--  N.B. Same name as the original script to ensure compatability with the report


AS

	SELECT	 * 
	From		KK_Rpt00105DivisionData
	WHERE       su_division collate database_default in (Select Value from dbo.Split(',',@Division)  ) 
	AND         su_location collate database_default in (Select Value from dbo.Split(',',@Location)  )
	AND         su_onhandqty > 0