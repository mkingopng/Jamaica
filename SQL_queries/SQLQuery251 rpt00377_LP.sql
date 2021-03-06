USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00377_LP]    Script Date: 10/05/2021 14:09:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00377_LP]
	-- Add the parameters for the stored procedure here
	--@SelectedMonth AS NVARCHAR(7), 
	--@Division AS NVARCHAR(20)
AS

--DECLARE @c as NVARCHAR(4000),
		--@DivisionalList NVARCHAR(56)

--BEGIN

DROP TABLE dbo.KK_Rpt00377Data_LP
CREATE TABLE dbo.KK_Rpt00377Data_LP
(
   su_stockcode nvarchar(35),
   su_description nvarchar(50),
   su_Per_Plt nvarchar(10),
   su_Forcst_lae nvarchar(10),
   su_Forcst_mnt nvarchar(10),
   su_WH3 numeric(20),
   su_WH4 numeric(20),
   su_WH5 numeric(20),
   su_WH13 numeric(20),
   su_WH14 numeric(20)
   --su_total_wh numeric(10)
  ) on [PRIMARY] 
 
 INSERT INTO dbo.KK_Rpt00377Data_LP
 SELECT HStockCode,
 NULL,
 HPer_Plt,
 HForecast_lae,
 HForecast_mnt,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL
 
 FROM IscalaAnalysis..StockForecast_LP
 
 UPDATE dbo.KK_Rpt00377Data_LP
 SET su_description = SC01002 + SC01003
 FROM ScaCompanyDB..SC010100 where su_stockcode COLLATE DATABASE_DEFAULT = SC01001 
 
 UPDATE dbo.KK_Rpt00377Data_LP
 SET su_WH3 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '03'
 
 UPDATE dbo.KK_Rpt00377Data_LP
 SET su_WH4 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '04'
 
 UPDATE dbo.KK_Rpt00377Data_LP
 SET su_WH5 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '05'
 
 UPDATE dbo.KK_Rpt00377Data_LP
 SET su_WH13 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '13'
 
 UPDATE dbo.KK_Rpt00377Data_LP
 SET su_WH14 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '14'
 
--UPDATE dbo.KK_Rpt00377Data
--SET su_total_wh  = su_WH3 + su_WH4 + su_WH5 + su_WH13 + su_wh14
--FROM IscalaAnalysis..KK_Rpt00377Data 
 
 SELECT * from IscalaAnalysis..KK_Rpt00377Data_LP
 
 
 
 
 
 
 
 
 
 
 
 
-- SELECT * from IscalaAnalysis.. Stockforecast
 
 --END