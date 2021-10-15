create table #count
(
	w_wh nvarchar(60),
	w_all numeric,
	w_close numeric,
	w_actplandiff int,
	w_ot numeric(28,8),
	w_days numeric(28,8),
	w_qty numeric(28,8),
	w_run numeric(28,8)
)

insert into #count (w_wh,w_all,w_close, w_actplandiff, w_ot, w_days, w_qty, w_run) 
values 
(
 '40' 
,(
	select COUNT(MP64001) from ScaCompanyDB..MP640100 
	where MP64003='40' and MP64014 >= '2020-10-01' 
	and DATEPART(ISO_WEEK,MP64038) = '43'
 )
,(
	select COUNT(MP64001) from ScaCompanyDB..MP640100
	where MP64003='40' and MP64014 >= '2020-10-01'
	and (MP64013-MP64038=0) 
	and DATEPART(ISO_WEEK,MP64038) = '43'
 )
,(
	select SUM(cast ((MP64038) as int)- cast ((MP64013) as int))
	from ScaCompanyDB..MP640100 
	where MP64003='40' and MP64014 >= '2020-10-01'
	and DATEPART(ISO_WEEK,MP64038) = '43'
 )
,0 
,0
,0
,0
)

update #count
set w_ot = (w_close/nullif(w_all,0)) * 100,
    w_days = (w_actplandiff/w_close)

select * from #count
drop table #count


--Closed: Sum(PlnEndDate - ActualEndDate)=0)/Closed

-- try using this same approach for DIFOT