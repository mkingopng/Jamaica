USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00377_v1]    Script Date: 10/05/2021 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00377_v1]
AS

DROP TABLE dbo.KK_Rpt00377Data_v1
CREATE TABLE dbo.KK_Rpt00377Data_v1
(
   su_stockcode nvarchar(35),
   su_description nvarchar(50),
   su_Per_Plt nvarchar(10),
   su_Forcst_mnt nvarchar(10),
   su_MIN nvarchar(10),
   su_MAX nvarchar(10),
   su_WH1 numeric(20),
   su_WH2 numeric(20),
   su_WH3 numeric(20),
   su_WH4 numeric(20),
   su_WH5 numeric(20),
   su_WH13 numeric(20),
   su_WH14 numeric(20)
  ) on [PRIMARY] 
 
 INSERT INTO dbo.KK_Rpt00377Data_v1
 SELECT HStockCode,
 NULL,
 HPer_Plt,
 HForecast_mnt,
 Min_ROL,
 Max_ROL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL
 FROM IscalaAnalysis..StockForecast_Roto 
 
 UPDATE dbo.KK_Rpt00377Data_v1
 SET su_description = SC01002 + SC01003
 FROM ScaCompanyDB..SC010100 where su_stockcode COLLATE DATABASE_DEFAULT = SC01001 

 UPDATE dbo.KK_Rpt00377Data_v1
 SET su_WH1 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '01'
 
  UPDATE dbo.KK_Rpt00377Data_v1
 SET su_WH2 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '02'

 UPDATE dbo.KK_Rpt00377Data_v1
 SET su_WH3 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '03'
 
 UPDATE dbo.KK_Rpt00377Data_v1
 SET su_WH4 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '04'
 
 UPDATE dbo.KK_Rpt00377Data_v1
 SET su_WH5 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '05'
 
 UPDATE dbo.KK_Rpt00377Data_v1
 SET su_WH13 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '13'
 
 UPDATE dbo.KK_Rpt00377Data_v1
 SET su_WH14 = SC03003
 FROM ScaCompanyDB..SC030100 WHERE su_stockcode COLLATE DATABASE_DEFAULT  = SC03001 
 AND SC03002   = '14'
 
 SELECT * from IscalaAnalysis..KK_Rpt00377Data_v1
