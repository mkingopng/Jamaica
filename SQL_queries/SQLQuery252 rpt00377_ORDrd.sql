USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00377_ORDrd]    Script Date: 10/05/2021 14:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================
-- Isaac Kababa...
-- 14-10-2014 
-- ties recommend stock transfers with order qty
-- ===================================================
ALTER procedure [dbo].[SSRS_Rpt00377_ORDrd]
as

drop table dbo.KK_Rpt00377Data_ORDrd
create table dbo.KK_Rpt00377Data_ORDrd
(
   su_stockcode nvarchar(35),
   su_description nvarchar(50),
   su_Per_Plt nvarchar(10),
   su_Forcst_mnt nvarchar(10),
   su_WH3 numeric(20),
   su_WH4 numeric(20),
   su_WH5 numeric(20),
   su_WH13 numeric(20),
   su_WH14 numeric(20),
   bo_WH3 numeric(20),
   bo_WH5 numeric(20),
   bo_WH14 numeric(20)
  ) on [primary] 
 
 insert into dbo.KK_Rpt00377Data_ORDrd
 select HStockCode,
 NULL,
 HPer_Plt,
 HForecast_mnt,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL
 from IscalaAnalysis..StockForecast 
 
 update dbo.KK_Rpt00377Data_ORDrd
 set su_description = SC01002 + SC01003
 from ScaCompanyDB..SC010100 where su_stockcode collate database_default = SC01001 
 
 update dbo.KK_Rpt00377Data_ORDrd
 set su_WH3 = SC03003
 from ScaCompanyDB..SC030100 where su_stockcode collate database_default  = SC03001 
 and SC03002   = '03'
 
 update dbo.KK_Rpt00377Data_ORDrd
 set su_WH4 = SC03003
 from ScaCompanyDB..SC030100 where su_stockcode collate database_default  = SC03001 
 and SC03002   = '04'
 
 update dbo.KK_Rpt00377Data_ORDrd
 set su_WH5 = SC03003
 from ScaCompanyDB..SC030100 where su_stockcode collate database_default  = SC03001 
 and SC03002   = '05'
 
 update dbo.KK_Rpt00377Data_ORDrd
 set su_WH13 = SC03003
 from ScaCompanyDB..SC030100 where su_stockcode collate database_default  = SC03001 
 and SC03002   = '13'
 
 update dbo.KK_Rpt00377Data_ORDrd
 set su_WH14 = SC03003
 from ScaCompanyDB..SC030100 where su_stockcode collate database_default  = SC03001 
 and SC03002   = '14'
 
 update dbo.KK_Rpt00377Data_ORDrd
 set bo_WH3 = (select sum(OR03011)
 from ScaCompanyDB..OR030100 where su_stockcode collate database_default  = OR03005 
 and OR03019 > '2014-01-01'
 and OR03046 = '03'
 and OR03112 <> '0'
 and OR03051 IS NOT NULL)

 update dbo.KK_Rpt00377Data_ORDrd
 set bo_WH5 = (select sum(OR03011)
 from ScaCompanyDB..OR030100 where su_stockcode collate database_default  = OR03005 
 and OR03019 > '2014-01-01'
 and OR03046 = '05'
 and OR03112 <> '0'
 and OR03051 IS NOT NULL)

 update dbo.KK_Rpt00377Data_ORDrd
 set bo_WH14 = (select sum(OR03011)
 from ScaCompanyDB..OR030100 where su_stockcode collate database_default  = OR03005 
 and OR03019 > '2014-01-01'
 and OR03046 = '14'
 and OR03112 <> '0'
 and OR03051 IS NOT NULL)

 update dbo.KK_Rpt00377Data_ORDrd
 set bo_WH3 = 0 where bo_WH3 is null

 update dbo.KK_Rpt00377Data_ORDrd
 set bo_WH5 = 0 where bo_WH5 is null

 update dbo.KK_Rpt00377Data_ORDrd
 set bo_WH14 = 0 where bo_WH14 is null
 
 select * from IscalaAnalysis..KK_Rpt00377Data_ORDrd
 