USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00377_SR]    Script Date: 10/05/2021 14:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00377_SR]
AS
DROP TABLE dbo.KK_Rpt00377Data_SR
CREATE TABLE dbo.KK_Rpt00377Data_SR
(
   su_stockcode nvarchar(35),
   su_description nvarchar(50),
   su_WH05_bal numeric(20),
   su_WH01_bal numeric(20),
   su_pref_lvl numeric(20),
   su_trf_qty numeric(10)
  ) on [PRIMARY] 
 
 INSERT INTO dbo.KK_Rpt00377Data_SR
 SELECT HStockCode,
 NULL,
 HWH05Bal,
 HWH01Bal,
 HPrefLvl,
 NULL
 FROM IscalaAnalysis..StockForecast_SR
 
 UPDATE dbo.KK_Rpt00377Data_SR
 SET su_description = SC01002 + SC01003
 FROM ScaCompanyDB..SC010100 where su_stockcode COLLATE DATABASE_DEFAULT = SC01001 

 UPDATE dbo.KK_Rpt00377Data_SR
 SET su_trf_qty = 0
 FROM IscalaAnalysis..StockForecast_SR WHERE su_stockcode COLLATE DATABASE_DEFAULT  = HStockcode
 AND (HPrefLvl-HWH01Bal) <= 0
 
 UPDATE dbo.KK_Rpt00377Data_SR
 SET su_trf_qty = (HPrefLvl-HWH01Bal)
 FROM IscalaAnalysis..StockForecast_SR WHERE su_stockcode COLLATE DATABASE_DEFAULT  = HStockcode
 AND (HPrefLvl-HWH01Bal) > 0
 
 SELECT * from IscalaAnalysis..KK_Rpt00377Data_SR