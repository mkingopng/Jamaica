USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00413_sel]    Script Date: 10/05/2021 14:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00413_sel]
	@StartDate as Datetime,
	@EndDate as Datetime,
	@CostCentre as NVARCHAR(3),
	@Salesman as NVARCHAR(50)
AS 
BEGIN

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF

SELECT ST03017 AS StockCode,
	   SC01002 AS Descript1,
	   SC01003 AS Descript2,
	   ST03020 AS Quantity,
	   ST03015 AS InvOrdDate,
	   ST03011 AS AccCodeStr,
	   ST03001 AS CustomerCode,
	   SL01002 AS CustomerName,
	   ST01002 AS Salesman,
	   ST01021 AS CostCentre
FROM ScaCompanyDB..ST030100
 	 INNER JOIN ScaCompanyDB..SL010100 ON ST03001=SL01001 
 	 INNER JOIN ScaCompanyDB..ST010100 ON ST03007=ST01001 
	 LEFT OUTER JOIN ScaCompanyDB..SC010100 ON ST03017=SC01001
WHERE ST03015 between convert(nvarchar(20),@StartDate) AND convert(nvarchar(20),@EndDate)
	  AND ST01021 =11 or ST01021=21
	  
END