declare @week as int --declare variale to hold the week number
declare @month as int --declare variable to hold the month number
declare @date as nvarchar(10) --declare date variable --script begins filter then
select @month= (select DATEPART(MONTH, GETDATE())) -- get SQL'Server's month number
select @date = '2020-' + CAST((@month-1)as char(2)) + '-01' --concat to form date in SQL date format
select @week= DATEPART(WEEK, GETDATE()) --get SQL Servers's week number
 
--production statistics - list of work orders
 
select
 MP64001 "WO#"
,MP64002 "SKU"
,MP64006 "ALT"
,MP64003 "WH#"
,MP64088 "Status"
,MP64013 "planned due date"
,DATEPART(ISO_WEEK,MP64038) "WK" --is this coming from your virtual table?
,MP64038 "WOCLOSEDATE"
,MP64014 "Actual Due Date"
,MP64004 "Planned Qty"
,MP64005 "Manufactured Qty"
,MP64093 "Rest Qty" --what is this?
,(MP64005/MP64004) "OVERRUN"
,MP64024 "PLANNER" --what is this?
,MP64036 "MATAVAIL" --this appears to have no function now. Can we set this up as a "case where" function?
,MP64017 "TEXT1"
,MP64018 "TEXT2"
,MP64019 "TEXT3"
from ScaCompanyDB..MP640100 
 where MP64014 >=@date --
and DATEPART(ISO_WEEK,MP64038) IN (@week,@week-1) --i'm guessing that this is from your virtual table?
order by MP64003, MP64014, MP64024, MP64038
--
--attainment calculations
--
create table #c_wk_attain -- current week calculations
(
      c_wh nvarchar(60),      --warehouse
      c_allwo numeric,  --all workorders count   
      c_closewo numeric,  --closed workorders count
      c_daydiff int,          --number of days between the planned and closed date
      c_ontime numeric(28,8),       --number of workorders closed on time as a percentage of all workorders
      c_latedays numeric(28,8),     --number of days 
      c_onqty numeric(28,8),        --
      c_overrun numeric(28,8),      --
      c_wk int                            --
)
 
-- populate wh number
insert into #c_wk_attain
select distinct MP64003,0,0,0,0,0,0,0,@week
from ScaCompanyDB..MP640100
where MP64014 >=@date order by MP64003
 
update #c_wk_attain
set c_allwo = (select COUNT(MP64001) from ScaCompanyDB..MP640100
      where MP64003 IN (c_wh collate database_default) and MP64014 >= @date
      and DATEPART(ISO_WEEK,MP64038) = @week),
 
      c_closewo = (select COUNT(MP64001) from ScaCompanyDB..MP640100
      where MP64003 IN (c_wh collate database_default) and MP64014 >= @date
      and (MP64013-MP64038=0)
      and DATEPART(ISO_WEEK,MP64038) = @week),
     
      c_daydiff = (select SUM(CAST ((MP64038) as int)- CAST ((MP64013) as int))
      from ScaCompanyDB..MP640100  where MP64003 IN (c_wh collate database_default) and MP64014 >= @date
      and DATEPART(ISO_WEEK,MP64038) = @week),
 
      c_latedays = (select SUM(cast ((MP64038) as int)- cast ((MP64013) as int))
      from ScaCompanyDB..MP640100
      where MP64003 IN (c_wh collate database_default) and MP64014 >= @date
      and DATEPART(ISO_WEEK,MP64038) = @week),
 
      c_onqty = (select COUNT(MP64001) from ScaCompanyDB..MP640100
      where MP64003 IN (c_wh collate database_default) and MP64014 >= @date
      and (MP64004-MP64005=0)
      and DATEPART(ISO_WEEK,MP64038) = @week),
 
      c_overrun = (select SUM((MP64005/MP64004)* 100) from ScaCompanyDB..MP640100
      where MP64003 IN (c_wh collate database_default) and MP64014 >= @date
      and DATEPART(ISO_WEEK,MP64038) = @week)
 
update #c_wk_attain set c_latedays = (c_daydiff/nullif(c_allwo,0))
update #c_wk_attain set c_ontime = (c_closewo/nullif(c_allwo,0)) * 100
update #c_wk_attain set c_onqty = (c_onqty/nullif(c_allwo,0)) * 100
update #c_wk_attain set c_overrun = (c_overrun/nullif(c_allwo,0))
 
update #c_wk_attain set c_daydiff = 0 from #c_wk_attain where c_daydiff IS NULL
update #c_wk_attain set c_latedays = 0 from #c_wk_attain where c_latedays IS NULL
update #c_wk_attain set c_ontime = 0 from #c_wk_attain where c_ontime IS NULL
update #c_wk_attain set c_onqty = 0 from #c_wk_attain where c_onqty IS NULL
update #c_wk_attain set c_overrun = 0 from #c_wk_attain where c_overrun IS NULL
 
create table #l_wk_attain -- previous weeks calculations
(
      l_wh nvarchar(60),      --warehouse
      l_allwo numeric,  --all workorders count   
      l_closewo numeric,  --closed workorders count
      l_daydiff int,          --number of days between the planned and closed date
      l_ontime numeric(28,8),       --number of workorders closed on time as a percentage of all workorders
      l_latedays numeric(28,8),     --number of days 
      l_onqty numeric(28,8),        --
      l_overrun numeric(28,8),      --
      m_wk int                            --
)
 
insert into #l_wk_attain
select distinct MP64003,0,0,0,0,0,0,0,@week-1
from ScaCompanyDB..MP640100
where MP64014 >=@date order by MP64003
 
update #l_wk_attain
set l_allwo = (select COUNT(MP64001) from ScaCompanyDB..MP640100
      where MP64003 IN (l_wh collate database_default) and MP64014 >= @date
      and DATEPART(ISO_WEEK,MP64038) = @week-1),
 
      l_closewo = (select COUNT(MP64001) from ScaCompanyDB..MP640100
      where MP64003 IN (l_wh collate database_default) and MP64014 >= @date
      and (MP64013-MP64038=0)
      and DATEPART(ISO_WEEK,MP64038) = @week-1),
     
      l_daydiff = (select SUM(CAST ((MP64038) as int)- CAST ((MP64013) as int))
      from ScaCompanyDB..MP640100  where MP64003 IN (l_wh collate database_default) and MP64014 >= @date
      and DATEPART(ISO_WEEK,MP64038) = @week-1),
 
      l_latedays = (select SUM(cast ((MP64038) as int)- cast ((MP64013) as int))
      from ScaCompanyDB..MP640100
      where MP64003 IN (l_wh collate database_default) and MP64014 >= @date
      and DATEPART(ISO_WEEK,MP64038) = @week-1),
 
      l_onqty = (select COUNT(MP64001) from ScaCompanyDB..MP640100
      where MP64003 IN (l_wh collate database_default) and MP64014 >= @date
      and (MP64004-MP64005=0)
      and DATEPART(ISO_WEEK,MP64038) = @week-1),
 
      l_overrun = (select SUM((MP64005/MP64004)* 100) from ScaCompanyDB..MP640100
      where MP64003 IN (l_wh collate database_default) and MP64014 >= @date
      and DATEPART(ISO_WEEK,MP64038) = @week-1)
 
update #l_wk_attain set l_latedays = (l_daydiff/nullif(l_allwo,0))
update #l_wk_attain set l_ontime = (l_closewo/nullif(l_allwo,0)) * 100
update #l_wk_attain set l_onqty = (l_onqty/nullif(l_allwo,0)) * 100
update #l_wk_attain set l_overrun = (l_overrun/nullif(l_allwo,0))
 
update #l_wk_attain set l_daydiff = 0 from #l_wk_attain where l_daydiff IS NULL
update #l_wk_attain set l_latedays = 0 from #l_wk_attain where l_latedays IS NULL
update #l_wk_attain set l_ontime = 0 from #l_wk_attain where l_ontime IS NULL
update #l_wk_attain set l_onqty = 0 from #l_wk_attain where l_onqty IS NULL
update #l_wk_attain set l_overrun = 0 from #l_wk_attain where l_overrun IS NULL
 
-- join last week attainment with current week attainment in one table-- union all
select * from #c_wk_attain
union all
select * from #l_wk_attain
 
drop table #c_wk_attain
drop table #l_wk_attain
