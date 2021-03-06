USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00356_rachael]    Script Date: 10/05/2021 13:32:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================
-- Isaac Kababa...
-- 31-07-2014 
-- modified version of RPT00356 for Rachael Poloat
-- ===================================================
ALTER procedure [dbo].[SSRS_Rpt00356_rachael]
as

create table #rachael
(
   rs_stockcode nvarchar(35)NULL
 , rs_description1 nvarchar(35)NULL
 , rs_description2 nvarchar(35)NULL
 , rs_altprodgrp nvarchar(10)NULL
 , rs_statuscode nvarchar(4)NULL
 , rs_janvalue numeric(20,8)NULL
 , rs_febvalue numeric(20,8)NULL
 , rs_marvalue numeric(20,8)NULL
 , rs_aprvalue numeric(20,8)NULL
 , rs_mayvalue numeric(20,8)NULL
 , rs_junvalue numeric(20,8)NULL
 , rs_julvalue numeric(20,8)NULL
 , rs_augvalue numeric(20,8)NULL
 , rs_sepvalue numeric(20,8)NULL
 , rs_octvalue numeric(20,8)NULL
 , rs_novvalue numeric(20,8)NULL
 , rs_decvalue numeric(20,8)NULL
)
on [primary]

insert into #rachael
select 
    SC01001    "StockCode" 
 ,  SC01002    "Description1" 
 ,  SC01003    "Description2" 
 ,  SC01038    "AltProdGrp" 
 ,  SC01066    "Status Code"
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
 ,  NULL
from ScaCompanyDB..SC010100  
where SC01001 between '12-01-9000' and '12-99-9999'

update #rachael
set rs_janvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-01-01 00:00:00.00' and '2019-01-31 00:00:00.00')

update #rachael
set rs_febvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-02-01 00:00:00.00' and '2019-02-28 00:00:00.00')

update #rachael
set rs_marvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-03-01 00:00:00.00' and '2019-03-31 00:00:00.00')

update #rachael
set rs_aprvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-04-01 00:00:00.00' and '2019-04-30 00:00:00.00')

update #rachael
set rs_mayvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-05-01 00:00:00.00' and '2019-05-31 00:00:00.00')

update #rachael
set rs_junvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-06-01 00:00:00.00' and '2019-06-30 00:00:00.00')

update #rachael
set rs_julvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-07-01 00:00:00.00' and '2019-07-31 00:00:00.00')

update #rachael
set rs_augvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-08-01 00:00:00.00' and '2019-08-31 00:00:00.00')

update #rachael
set rs_sepvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-09-01 00:00:00.00' and '2019-09-30 00:00:00.00')

update #rachael
set rs_octvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-10-01 00:00:00.00' and '2019-10-31 00:00:00.00')

update #rachael
set rs_novvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-11-01 00:00:00.00' and '2019-11-30 00:00:00.00')

update #rachael
set rs_decvalue = (select sum(SC07004)
from ScaCompanyDB..SC070100 where rs_stockcode collate database_default  = SC07003 
and SC07001=00 and SC07002 between '2019-12-01 00:00:00.00' and '2019-12-31 00:00:00.00')

update #rachael
set rs_janvalue = 0 where rs_janvalue is null

update #rachael
set rs_febvalue = 0 where rs_febvalue is null

update #rachael
set rs_marvalue = 0 where rs_marvalue is null

update #rachael
set rs_junvalue = 0 where rs_junvalue is null

update #rachael
set rs_julvalue = 0 where rs_julvalue is null

update #rachael
set rs_augvalue = 0 where rs_augvalue is null

update #rachael
set rs_sepvalue = 0 where rs_sepvalue is null

update #rachael
set rs_octvalue = 0 where rs_octvalue is null

update #rachael
set rs_novvalue = 0 where rs_novvalue is null

update #rachael
set rs_decvalue = 0 where rs_decvalue is null

select * from #rachael

--drop table #rachael1