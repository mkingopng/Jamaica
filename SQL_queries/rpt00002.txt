USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00002]    Script Date: 10/04/2021 14:24:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[SSRS_RPT00002]
		@c_week as int
as
begin
declare @r_date as datetime		--variable to hold the current system date
declare @s_date as datetime		--variable to hold the start date
declare @e_date as datetime		--variable to hold the end date
select @r_date = (select dateadd(d, 0, datediff(d, 0, getdate())) )	--variable to hold current system date
--select @c_week = (select datepart(wk, @r_date))						--variable to hold current calender week
--set @c_week = '28'
create table #cweek				--temporary table to hold the calender week break up
(
	c_wk int,
	c_cwk int,
	c_datestart datetime,
	c_datend datetime
)
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('1','1','2021-01-04','2021-01-10')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('2','2','2021-01-11','2021-01-17')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('3','3','2021-01-18','2021-01-24')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('4','4','2021-01-25','2021-01-31')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('5','5','2021-02-01','2021-02-07')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('6','6','2021-02-08','2021-02-14')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('7','7','2021-02-15','2021-02-21')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('8','8','2021-02-22','2021-02-28')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('9','9','2021-03-01','2021-03-07')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('10','10','2021-03-08','2021-03-14')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('11','11','2021-03-15','2021-03-21')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('12','12','2021-03-22','2021-03-28')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('13','13','2021-03-29','2021-04-04')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('14','14','2021-04-05','2021-04-11')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('15','15','2021-04-12','2021-04-18')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('16','16','2021-04-19','2021-04-25')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('17','17','2021-04-26','2021-05-02')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('18','18','2021-05-03','2021-05-09')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('19','19','2021-05-10','2021-05-16')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('20','20','2021-05-17','2021-05-23')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('21','21','2021-05-24','2021-05-30')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('22','22','2021-05-31','2021-06-06')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('23','23','2021-06-07','2021-06-13')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('24','24','2021-06-14','2021-06-20')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('25','25','2021-06-21','2021-06-27')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('26','26','2021-06-28','2021-07-04')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('27','27','2021-07-05','2021-07-11')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('28','28','2021-07-12','2021-07-18')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('29','29','2021-07-19','2021-07-25')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('30','30','2021-07-26','2021-08-01')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('31','31','2021-08-02','2021-08-08')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('32','32','2021-08-09','2021-08-15')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('33','33','2021-08-16','2021-08-22')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('34','34','2021-08-23','2021-08-29')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('35','35','2021-08-30','2021-09-05')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('36','36','2021-09-06','2021-09-12')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('37','37','2021-09-13','2021-09-19')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('38','38','2021-09-20','2021-09-26')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('39','39','2021-09-27','2021-10-03')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('40','40','2021-10-04','2021-10-10')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('41','41','2021-10-11','2021-10-17')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('42','42','2021-10-18','2021-10-24')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('43','43','2021-10-25','2021-10-31')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('44','44','2021-11-01','2021-11-07')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('45','45','2021-11-08','2021-11-14')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('46','46','2021-11-15','2021-11-21')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('47','47','2021-11-22','2021-11-28')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('48','48','2021-11-29','2021-12-05')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('49','49','2021-12-06','2021-12-12')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('50','50','2021-12-13','2021-12-19')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('51','51','2021-12-20','2021-12-26')
insert into #cweek (c_wk,c_cwk,c_datestart,c_datend) values ('52','52','2021-12-27','2021-01-02')


select @s_date = (select c_datestart from #cweek where c_cwk = @c_week)
select @e_date = (select c_datend from #cweek where c_cwk = @c_week)
--select @r_date, @c_week, @s_date "day1", @e_date, @s_date + 1 "day2", @s_date + 2 "day3", @s_date + 3 "day4", @s_date + 4 "day5", @s_date + 5 "day6"
create table #data
(
	s_sku nvarchar(35),
	s_dscrp nvarchar (100),
	s_prdgrp nvarchar (4),
	s_pkqty numeric(18,3),
	s_soh numeric,
	s_fcst numeric,
	s_pln numeric,
	s_plnv numeric,
	s_act numeric,
	s_actv numeric,
	d_cwk int,
	s_factory nvarchar(35),
	s_rptgrp nvarchar(50),
	s_wh nvarchar(2),
	s_day1 numeric,
	s_day2 numeric,
	s_day3 numeric,
	s_day4 numeric,
	s_day5 numeric,
	s_day6 numeric,
	s_day7 numeric,
	s_inv numeric

)
--extract sku, descrption, product group, stock balance from the stock master file
insert into #data 
select SC01001, SC01002 + ' ' + SC01003, SC01037, p_pkqty, SC01042, 0,0,0,0,0,@c_week,p_factory,p_wc,p_wh,0,0,0,0,0,0,0,0 from ScaCompanyDB..SC010100 
inner join tbl_productionskus ON SC01001 = p_sku collate database_default
where SC01001 in (select p_sku collate database_default from tbl_productionskus)


create table #fcst
(
	f_sku nvarchar(35),
	f_fcst numeric
)
--extract forecast value from forecast table
insert into #fcst
select distinct MP95004, MP95008 from ScaCompanyDB..MP950100  
where MP95002='0003' 
and MP95004 IN (select s_sku collate database_default from #data) 
update #data set s_fcst = f_fcst from #fcst where s_sku = f_sku 

create table #workorders
(
	w_sku nvarchar (35),
	w_wh nvarchar(2), --added 18-02-2021
	w_pln numeric,
	w_act numeric,
	w_day1 numeric,
	w_day2 numeric,
	w_day3 numeric,
	w_day4 numeric,
	w_day5 numeric,
	w_day6 numeric,
	w_day7 numeric
)

create table #dayqty
(
	d_sku nvarchar (35),
	d_wh nvarchar(2), --added 18-02-2021
	d_dayqty numeric,
)

-- extract planned and actual values from workorders table
insert into #workorders
select MP64002,MP64003,SUM(MP64004),SUM(MP64005),0,0,0,0,0,0,0 from ScaCompanyDB..MP640100 where MP64013 between @s_date and @e_date 
and MP64002 IN (select s_sku collate database_default from #data) 
group by MP64002, MP64003
update #data set s_pln= w_pln from #workorders where w_sku=s_sku 
update #data set s_act= w_act from #workorders where w_sku=s_sku 
update #data set s_plnv = s_pln * s_pkqty
update #data set s_actv = s_act * s_pkqty

--select * from #workorders

insert into #dayqty
select SC07003,SC07009,SUM(SC07004) from ScaCompanyDB..SC070100 where SC07002 = @s_date 
and SC07003 IN (select s_sku collate database_default from #data) and SC07001='00'
group by SC07003,SC07009
update #data set s_day1 = d_dayqty from #dayqty where d_sku = s_sku and d_wh = s_wh
delete from #dayqty


insert into #dayqty
select SC07003,SC07009,SUM(SC07004) from ScaCompanyDB..SC070100 where SC07002 = @s_date + 1
and SC07003 IN (select s_sku collate database_default from #data) and SC07001='00'
group by SC07003,SC07009
update #data set s_day2 = d_dayqty from #dayqty where d_sku = s_sku and d_wh = s_wh
delete from #dayqty

insert into #dayqty
select SC07003,SC07009,SUM(SC07004) from ScaCompanyDB..SC070100 where SC07002 = @s_date + 2
and SC07003 IN (select s_sku collate database_default from #data) and SC07001='00'
group by SC07003,SC07009
update #data set s_day3 = d_dayqty from #dayqty where d_sku = s_sku and d_wh = s_wh
delete from #dayqty

insert into #dayqty
select SC07003,SC07009,SUM(SC07004) from ScaCompanyDB..SC070100 where SC07002 = @s_date + 3
and SC07003 IN (select s_sku collate database_default from #data) and SC07001='00'
group by SC07003,SC07009

update #data set s_day4 = d_dayqty from #dayqty where d_sku = s_sku and d_wh = s_wh
delete from #dayqty

insert into #dayqty
select SC07003,SC07009,SUM(SC07004) from ScaCompanyDB..SC070100 where SC07002 = @s_date + 4
and SC07003 IN (select s_sku collate database_default from #data) and SC07001='00'
group by SC07003,SC07009
update #data set s_day5 = d_dayqty from #dayqty where d_sku = s_sku and d_wh=s_wh
delete from #dayqty

insert into #dayqty
select SC07003,SC07009,SUM(SC07004) from ScaCompanyDB..SC070100 where SC07002 = @s_date + 5
and SC07003 IN (select s_sku collate database_default from #data) and SC07001='00'
group by SC07003,SC07009
update #data set s_day6 = d_dayqty from #dayqty where d_sku = s_sku and d_wh = s_wh
delete from #dayqty

insert into #dayqty
select SC07003,SC07009,SUM(SC07004) from ScaCompanyDB..SC070100 where SC07002 = @s_date + 6
and SC07003 IN (select s_sku collate database_default from #data) and SC07001='00'
group by SC07003,SC07009
update #data set s_day7 = d_dayqty from #dayqty where d_sku = s_sku and d_wh = s_wh
delete from #dayqty

create table #invoiced
(
	i_sku nvarchar(35),
	i_wh nvarchar(6),
	i_qty numeric,
)
--extract invoiced qty
insert into #invoiced
select ST03017, ST03029, SUM(ST03020) from ScaCompanyDB..ST030100 where ST03015 between @s_date and @e_date 
and ST03017 IN (select s_sku collate database_default from #data) group by ST03017, ST03029
update #data set s_inv = i_qty from #invoiced where i_sku = s_sku and i_wh = s_wh

--select * from #workorders
--update 

select * from #data 
--where s_actv <> '0'
order by s_factory asc

drop table #data
drop table #cweek
drop table #fcst
drop table #workorders
drop table #dayqty
drop table #invoiced

endn