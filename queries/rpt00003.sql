USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00003]    Script Date: 10/04/2021 14:26:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[SSRS_RPT00003] 
	@StartDate as Datetime,
	@EndDate As Datetime
as
begin
set nocount on;

create table #bomtemp
(
	b_cStockcode nvarchar(35),
	b_cDescription nvarchar(100),
	b_cActualQty numeric(28,8),
	b_cUOMCode int,
	b_cUOM nvarchar(6)
)

insert into #bomtemp
select 
MP65004 "Component StockCode"
,NULL "Component Description"
,MP65016 "Actual Quantity"
,NULL "#UOMCode" 
,NULL "UOM"
from ScaCompanyDB..MP640100 inner join ScaCompanyDB..SC010100 ON SC01001=MP64002
							inner join ScaCompanyDB..MP650100 ON MP65001=MP64001
where MP64038 between @StartDate and @EndDate
group by 
MP65004,MP65016

update #bomtemp
set b_cDescription = SC01002 + ' ' + SC01003 from ScaCompanyDB..SC010100 where b_cStockcode = SC01001 collate Database_Default
update #bomtemp

set b_cUOMCode = SC01133 from ScaCompanyDB..SC010100 where b_cStockcode = SC01001 collate Database_Default

update #bomtemp
set b_cUOM = 'Each' where b_cUOMCode = '0'
update #bomtemp
set b_cUOM = 'KG' where b_cUOMCode = '1'
update #bomtemp 
set b_cUOM = 'Ltr' where b_cUOMCode = '2'
update #bomtemp
set b_cUOM = 'Box' where b_cUOMCode = '3'
update #bomtemp
set b_cUOM = 'Roll' where b_cUOMCode = '4'
update #bomtemp 
set b_cUOM = 'Pair' where b_cUOMCode = '5'
update #bomtemp 
set b_cUOM = 'KLtr' where b_cUOMCode = '6'
update #bomtemp 
set b_cUOM = 'Mtr' where b_cUOMCode = '7'
update #bomtemp 
set b_cUOM = 'Gram' where b_cUOMCode = '8'
update #bomtemp 
set b_cUOM = 'Pack' where b_cUOMCode = '9'
update #bomtemp 
set b_cUOM = 'Bale' where b_cUOMCode = '10'
update #bomtemp 
set b_cUOM = 'Ctn' where b_cUOMCode = '11'
update #bomtemp 
set b_cUOM = 'Drum' where b_cUOMCode = '12'
update #bomtemp 
set b_cUOM = 'Kit' where b_cUOMCode = '13'

select b_cStockcode, b_cDescription, SUM(b_cActualQty)"b_cActualQty", b_cUOM  from #bomtemp --where b_cStockcode IN ('12-01-9110') 
group by b_cStockcode, b_cDescription, b_cUOMCode, b_cUOM
drop table #bomtemp 

end