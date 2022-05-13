

create table #bomtemp
(
      b_cStockcode nvarchar(35),
      b_cDescription nvarchar(100),
      b_cActualJan20 numeric(28,8),
      b_cActualFeb20 numeric(28,8),
      b_cActualMar20 numeric(28,8),
      b_cActualApr20 numeric(28,8),
      b_cActualMay20 numeric(28,8),
      b_cActualJun20 numeric(28,8),
      b_cActualJul20 numeric(28,8),
      b_cActualAug20 numeric(28,8),
      b_cActualSep20 numeric(28,8),
      b_cActualOct20 numeric(28,8),
      b_cActualNov20 numeric(28,8),
      b_cActualDec20 numeric(28,8),
      b_cActualJan21 numeric(28,8),
      b_cActualFeb21 numeric(28,8),
      b_cActualMar21 numeric(28,8),
      b_cActualApr21 numeric(28,8),
      b_cActualMay21 numeric(28,8),
      b_cUOMCode int,
      b_cUOM nvarchar(6)
)

insert into #bomtemp
select 
MP65004 "Component StockCode"
,NULL "Component Description"
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M01' Then MP65016 End)   "Jan20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M02' Then MP65016 End)   "Feb20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M03' Then MP65016 End)   "Mar20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M04' Then MP65016 End)   "Apr20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M05' Then MP65016 End)   "May20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M06' Then MP65016 End)   "Jun20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M07' Then MP65016 End)   "Jul20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M08' Then MP65016 End)   "Aug20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M09' Then MP65016 End)   "Sep20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M10' Then MP65016 End)   "Oct20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M11' Then MP65016 End)   "Nov20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2020M12' Then MP65016 End)   "Dec20Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2021M01' Then MP65016 End)   "Jan21Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2021M02' Then MP65016 End)   "Feb21Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2021M03' Then MP65016 End)   "Mar21Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2021M04' Then MP65016 End)   "Apr21Qty" 
, SUM(Case When rtrim(cast(datepart(yyyy,MP64038) as char))+'M'+substring(cast(cast(datepart(mm,MP64038) as INT)+100 as char),2,2) =  '2021M05' Then MP65016 End)   "May21Qty" 
,NULL "#UOMCode" 
,NULL "UOM"
from ScaCompanyDB..MP640100 inner join ScaCompanyDB..SC010100 ON SC01001=MP64002
                                          inner join ScaCompanyDB..MP650100 ON MP65001=MP64001
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

select b_cStockcode, b_cDescription
, SUM(b_cActualJan20)"Jan2020Qty"
, SUM(b_cActualFeb20)"Feb2020Qty"
, SUM(b_cActualMar20)"Mar2020Qty"
, SUM(b_cActualApr20)"Apr2020Qty"
, SUM(b_cActualMay20)"May2020Qty"
, SUM(b_cActualJun20)"Jun2020Qty"
, SUM(b_cActualJul20)"Jul2020Qty"
, SUM(b_cActualAug20)"Aug2020Qty"
, SUM(b_cActualSep20)"Sep2020Qty"
, SUM(b_cActualOct20)"Oct2020Qty"
, SUM(b_cActualNov20)"Nov2020Qty"
, SUM(b_cActualDec20)"Dec2020Qty"
, SUM(b_cActualJan21)"Jan2021Qty"
, SUM(b_cActualFeb21)"Feb2021Qty"
, SUM(b_cActualMar21)"Mar2021Qty"
, SUM(b_cActualApr21)"Apr2021Qty"
, SUM(b_cActualMay21)"May2021Qty"
, b_cUOM  from #bomtemp 

where b_cStockcode IN ('15-02-1000','10-11-8023','10-01-0047','15-01-0200','12-01-9110') 
group by b_cStockcode, b_cDescription, b_cUOMCode, b_cUOM
drop table #bomtemp 


