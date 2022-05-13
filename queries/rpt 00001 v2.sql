USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00001_v2]    Script Date: 10/04/2021 14:21:42 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SSRS_RPT00001_v2]
as
begin
declare @yearvalue as int
declare @monthvalue as int
declare @rundate as datetime
declare @runday as datetime
declare @runmonth as nvarchar(10)
declare @tradingday as integer

select @yearvalue = datepart(year, getdate())
select @monthvalue = datepart(month, getdate())
select @rundate = (select dateadd(d, 0, datediff(d, 0, getdate())) )
select @runmonth=cast(@yearvalue as char(4)) + '-' + cast(@monthvalue as char(2)) + '-0' + cast(1 as char(1)) --for months with double digits
--select @runmonth=cast(@yearvalue as char(4)) + '-0' + cast(@monthvalue as char(1)) + '-0' + cast(1 as char(1)) --for months with single digit
select @runday = @rundate-2
select @tradingday=26
--
--
--
declare @weekstartdate as datetime
select @weekstartdate= '2021-10-04' --- manually change this date to started date of each new week

--select @runmonth='2021-09-01' -- manually run this on the first day of new month with first date of previous month
--select @runday = '2021-09-02' -- manually run this on the first day of new month with last date of previous month

create table #sales_cost_data
(
	st_account_sales nvarchar(50),
	st_account_costs nvarchar(50),
	st_costcentre numeric,
	st_projectcode nvarchar(50),
	st_division nvarchar(50),
	st_combined nvarchar(50),
	st_mtd_sales_budget numeric,
	st_mtd_sales_actual numeric(28,2),
	st_mtd_costs_actual numeric(28,2),
	st_dly_sales_actual numeric(28,2),
	st_dly_costs_actual numeric(28,2),
	
	st_wk_target numeric(28,2),
	st_wk_actual numeric(28,2),

	st_mt_target numeric(28,2),
	
	st_mtd_margin_actual numeric(28,2),
	st_mtd_var_bud_perc numeric(28,2),
	st_dly_var_bud_perc numeric(28,2),
	st_mtd_margin_budget numeric(28,2),
	st_mtd_sales_margin_perc numeric(28,2),
	st_mtd_ordervalue numeric(28,2),
	st_ytd_ordervalue numeric(28,2)
)
create table #tmpdata1
(
	d1_accstr nvarchar(50),
	d1_transno nvarchar(20),
	d1_transdate date,
	d1_amount numeric(28,2),
	d1_cc numeric(28),
	d1_accno nvarchar(10),
	d1_prj nvarchar(50)
)
create table #tmpdata2
(
	d2_accstr nvarchar(50),
	d2_transno nvarchar(20),
	d2_transdate date,
	d2_amount numeric(28,2),
	d2_cc numeric(28),
	d2_accno nvarchar(10),
	d2_prj nvarchar(50)
)
create table #mtddata
(
	mtd_costcentre integer,
	mtd_account nvarchar(20),
	mtd_sales numeric(28,2),
	mtd_costs numeric(28,2),
	mtd_dsale numeric(28,2),
	mtd_dcost numeric(28,2),
	mtd_wsale numeric(28,2)
	
)
-------------------------day count data
create table #tradedays
(
	t_days integer,
	t_count integer
)
create table #tmptradeday
(
	t_accstr nvarchar(50),
	t_transdate date,
)
insert into #tmptradeday select GL06001, GL06003 from ScaCompanyDB..GL060121 where GL06001 LIKE '30000011%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tradedays (t_days,t_count) values ('26',0)
update #tradedays set t_count = (select COUNT(distinct t_transdate)  from #tmptradeday)
---------------------------------------
insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000029','40000029','29','NULL','Lae Tuffa','Tuffa Sales','1100000',NULL,NULL,NULL,NULL,'200000',NULL,'1500000',NULL,NULL,NULL,'275000',NULL,NULL,NULL)
insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000030','40000030','30','NULL','Pom Tuffa','Tuffa Sales','550000',NULL,NULL,NULL,NULL,'200000',NULL,'550000',NULL,NULL,NULL,'137500',NULL,NULL,NULL)
insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000011','40000011','11','NULL','Lae Commercial','Chemical Commercial','2204900',NULL,NULL,NULL,NULL,'300000',NULL,'1100000',NULL,NULL,NULL,'507625',NULL,NULL,NULL)
insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000021','40000021','21','NULL','Pom Commercial','Chemical Commercial','949600',NULL,NULL,NULL,NULL,'350000',NULL,'750000',NULL,NULL,NULL,'407360',NULL,NULL,NULL)
--insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000038','40000038','38','NULL','Lae Plastics','Chemical Commercial','242000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'72600',NULL,NULL,NULL)
--insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000022','40000022','22','NULL','Lae Process Chemicals','Process Chemicals','751400',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'303945',NULL,NULL,NULL)
--insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000044','40000044','44','NULL','Pom Process Chemicals','Process Chemicals','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL)
insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000014','40000014','14','NULL','Lae Retail','Retail Sales','1733000',NULL,NULL,NULL,NULL,'200000',NULL,'1500000',NULL,NULL,NULL,'395450',NULL,NULL,NULL)
insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000024','40000024','24','NULL','Pom Retail','Retail Sales','1296100',NULL,NULL,NULL,NULL,'300000',NULL,'1000000',NULL,NULL,NULL,'303945',NULL,NULL,NULL)
--insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000031','40000031','31','NULL','Pom Hire','Hire','125000',NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,NULL,'125000',NULL,NULL,NULL)
--insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000033','40000033','33','NULL','Lae Hire','Hire','125000',NULL,NULL,NULL,NULL,'0',NULL,'0',NULL,NULL,NULL,'125000',NULL,NULL,NULL)
--insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000032','40000032','32','NULL','Pom Equipment Sales','Equipment Sales','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL)
--insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000034','40000034','34','NULL','Lae Equipment Sales','Equipment Sales','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL)
insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000019','40000019','19','NULL','Lae Oil Sales','Oil Sales','3500000',NULL,NULL,NULL,NULL,'1000000',NULL,'3500000',NULL,NULL,NULL,'391000',NULL,NULL,NULL)
insert into #sales_cost_data (st_account_sales,st_account_costs,st_costcentre,st_projectcode,st_division,st_combined,st_mtd_sales_budget,st_mtd_sales_actual,st_mtd_costs_actual,st_dly_sales_actual,st_dly_costs_actual,st_wk_target,st_wk_actual,st_mt_target,st_mtd_margin_actual,st_mtd_var_bud_perc,st_dly_var_bud_perc,st_mtd_margin_budget,st_mtd_sales_margin_perc,st_mtd_ordervalue,st_ytd_ordervalue) values ('30000040','40000040','40','NULL','Pom Oil Sales','Oil Sales','1130000',NULL,NULL,NULL,NULL,'1130000',NULL,'1130000',NULL,NULL,NULL,'139860',NULL,NULL,NULL)
update #sales_cost_data set st_mtd_sales_actual = 0, st_mtd_costs_actual=0, st_dly_sales_actual=0, st_dly_costs_actual=0, st_mtd_margin_actual=0, st_wk_actual=0
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 29, '30000029','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000029%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 29, '40000029','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000029%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 30, '30000030','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000030%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 30, '40000030','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000030%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 11, '30000011','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000011%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 11, '40000011','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000011%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 21, '30000021','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000021%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 21, '40000021','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000021%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 38, '30000038','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000038%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 38, '40000038','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000038%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 22, '30000022','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000022%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 22, '40000022','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000022%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 44, '30000044','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000044%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 44, '40000044','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000044%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 14, '30000014','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000014%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 14, '40000014','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000014%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 24, '30000024','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000024%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 24, '40000024','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000024%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 31, '30000031','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000031%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 31, '40000031','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000031%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 33, '30000033','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000033%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 33, '40000033','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000033%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 32, '30000032','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000032%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 32, '40000032','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000032%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 34, '30000034','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000034%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
--insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 34, '40000034','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000034%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 19, '30000019','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000019%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 19, '40000019','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000019%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004*-1, 40, '30000040','' from ScaCompanyDB..GL060121 where GL06001 LIKE '30000040%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
insert into #tmpdata1 select GL06001, GL06002, GL06003, GL06004, 40, '40000040','' from ScaCompanyDB..GL060121 where GL06001 LIKE '40000040%'AND GL06002 <> '000000000' AND GL06003 >= @runmonth order by GL06003
update #tmpdata1 set d1_prj= substring(d1_accstr,13,(len(d1_accstr) -6))
insert into #tmpdata2 select * from #tmpdata1 where d1_prj >= 'ACACON' and d1_prj <='AITMVS'
insert into #mtddata (mtd_account,mtd_costcentre, mtd_sales, mtd_costs, mtd_dsale, mtd_dcost, mtd_wsale) values (0,0,0,0,0,0,0)

update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000029' and d2_cc=29)
update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=29
update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000029' and d2_cc=29)
update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=29
update #mtddata set mtd_dsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000029' and d2_cc=29 and d2_transdate=@runday)
update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=29
update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000029' and d2_cc=29 and d2_transdate=@runday)
update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=29
update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000029' and d2_cc=29 and d2_transdate between @weekstartdate and @runday)
update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=29

update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000030' and d2_cc=30)
update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=30
update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000030' and d2_cc=30)
update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=30
update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000030' and d2_cc=30 and d2_transdate=@runday)
update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=30
update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000030' and d2_cc=30 and d2_transdate=@runday)
update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=30
update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000030' and d2_cc=30 and d2_transdate between @weekstartdate and @runday)
update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=30

update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000011' and d2_cc=11)
update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=11
update #mtddata set mtd_costs = (select sum(d2_amount)from #tmpdata2 where d2_accno='40000011' and d2_cc=11)
update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=11
update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000011' and d2_cc=11 and d2_transdate=@runday)
update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=11
update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000011' and d2_cc=11 and d2_transdate=@runday)
update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=11
update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000011' and d2_cc=11 and d2_transdate between @weekstartdate and @runday)
update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=11

update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000021' and d2_cc=21)
update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=21
update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000021' and d2_cc=21)
update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=21
update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000021' and d2_cc=21 and d2_transdate=@runday)
update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=21
update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000021' and d2_cc=21 and d2_transdate=@runday)
update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=21
update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000021' and d2_cc=21 and d2_transdate between @weekstartdate and @runday)
update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=21

--update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000038' and d2_cc=38)
--update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=38
--update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000038' and d2_cc=38)
--update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=38
--update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000038' and d2_cc=38 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=38
--update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000038' and d2_cc=38 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=38

--update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000022' and d2_cc=22)
--update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=22
--update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000022' and d2_cc=22)
--update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=22
--update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000022' and d2_cc=22 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=22
--update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000022' and d2_cc=22 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=22

--update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000044' and d2_cc=44)
--update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=44
--update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000044' and d2_cc=44)
--update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=44
--update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000044' and d2_cc=44 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=44
--update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000044' and d2_cc=44 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=44

update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000014' and d2_cc=14)
update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=14
update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000014' and d2_cc=14)
update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=14
update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000014' and d2_cc=14 and d2_transdate=@runday)
update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=14
update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000014' and d2_cc=14 and d2_transdate=@runday)
update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=14
update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000014' and d2_cc=14 and d2_transdate between @weekstartdate and @runday)
update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=14

update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000024' and d2_cc=24)
update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=24
update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000024' and d2_cc=24)
update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=24
update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000024' and d2_cc=24 and d2_transdate=@runday)
update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=24
update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000024' and d2_cc=24 and d2_transdate=@runday)
update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=24
update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000024' and d2_cc=24 and d2_transdate between @weekstartdate and @runday)
update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=24

--update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000031' and d2_cc=31)
--update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=31
--update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000031' and d2_cc=31)
--update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=31
--update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000031' and d2_cc=31 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=31
--update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000031' and d2_cc=31 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=31
--update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000031' and d2_cc=31 and d2_transdate between @weekstartdate and @runday)
--update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=31

--update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000033' and d2_cc=33)
--update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=33
--update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000033' and d2_cc=33)
--update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=33
--update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000033' and d2_cc=33 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=33
--update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000033' and d2_cc=33 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=33
--update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000033' and d2_cc=33 and d2_transdate between @weekstartdate and @runday)
--update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=33

--update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000032' and d2_cc=32)
--update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=32
--update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000032' and d2_cc=32)
--update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=32
--update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000032' and d2_cc=32 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=32
--update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000032' and d2_cc=32 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=32

--update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000034' and d2_cc=34)
--update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=34
--update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000034' and d2_cc=34)
--update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=34
--update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000034' and d2_cc=34 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=34
--update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000034' and d2_cc=34 and d2_transdate=@runday)
--update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=34

update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000019' and d2_cc=19)
update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=19
update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000019' and d2_cc=19)
update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=19
update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000019' and d2_cc=19 and d2_transdate=@runday)
update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=19
update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000019' and d2_cc=19 and d2_transdate=@runday)
update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=19
update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000019' and d2_cc=19 and d2_transdate between @weekstartdate and @runday)
update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=19

update #mtddata set mtd_sales = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000040' and d2_cc=40)
update #sales_cost_data set st_mtd_sales_actual = mtd_sales from #mtddata where #sales_cost_data.st_costcentre=40
update #mtddata set mtd_costs = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000040' and d2_cc=40)
update #sales_cost_data set st_mtd_costs_actual = mtd_costs from #mtddata where #sales_cost_data.st_costcentre=40
update #mtddata set mtd_dsale = (select sum(d2_amount) from #tmpdata2 where d2_accno='30000040' and d2_cc=40 and d2_transdate=@runday)
update #sales_cost_data set st_dly_sales_actual = mtd_dsale from #mtddata where #sales_cost_data.st_costcentre=40
update #mtddata set mtd_dcost = (select sum(d2_amount) from #tmpdata2 where d2_accno='40000040' and d2_cc=40 and d2_transdate=@runday)
update #sales_cost_data set st_dly_costs_actual = mtd_dcost from #mtddata where #sales_cost_data.st_costcentre=40
update #mtddata set mtd_wsale = (select sum(d2_amount)from #tmpdata2 where d2_accno='30000040' and d2_cc=40 and d2_transdate between @weekstartdate and @runday)
update #sales_cost_data set st_wk_actual = mtd_wsale from #mtddata where #sales_cost_data.st_costcentre=40

update #sales_cost_data set st_mtd_sales_actual=0 where st_mtd_sales_actual is null
update #sales_cost_data set st_dly_sales_actual=0 where st_dly_sales_actual is null
update #sales_cost_data set st_mtd_costs_actual=0 where st_mtd_costs_actual is null
update #sales_cost_data set st_dly_costs_actual=0 where st_dly_costs_actual is null
update #sales_cost_data set st_wk_actual=0 where st_wk_actual is null
update #sales_cost_data set st_mtd_margin_actual=st_mtd_sales_actual-st_mtd_costs_actual
update #sales_cost_data set st_mtd_var_bud_perc=((st_mtd_sales_actual-st_mtd_sales_budget)/nullif(st_mtd_sales_budget,0)) * 100
update #sales_cost_data set st_mtd_var_bud_perc=0 where st_mtd_var_bud_perc is null
update #sales_cost_data set st_dly_var_bud_perc = ((st_dly_sales_actual-(st_mtd_sales_budget/@tradingday))/nullif(st_mtd_sales_budget/@tradingday,0))*100
update #sales_cost_data set st_dly_var_bud_perc=0 where st_dly_var_bud_perc is null
update #sales_cost_data set st_mtd_sales_margin_perc=(st_mtd_margin_actual/nullif(st_mtd_sales_actual,0)) * 100
update #sales_cost_data set st_mtd_sales_margin_perc=0 where st_mtd_sales_margin_perc is null

--select * from #tmpdata1
--select * from #tmpdata2
--select * from #mtddata


create table #tmpmtdOrders
(
	m_costcentre integer,
	m_mtd_value numeric(28,2)
)
create table #tmpytdOrders
(
	y_costcentre integer,
	y_ytd_value numeric(28,2)
)
insert #tmpmtdOrders SELECT O_CostCentre, SUM(Value) FROM IscalaAnalysis..KK_OutstandingOrders where O_CostCentre in ('11','14','19','21','22','24','29','30','40','44') and OrderDate >= '2020-12-01' and OrderType >0 group by O_CostCentre
insert #tmpytdOrders SELECT O_CostCentre, SUM(Value) FROM IscalaAnalysis..KK_OutstandingOrders where O_CostCentre in ('11','14','19','21','22','24','29','30','40','44') and OrderDate >= '2019-01-01' and OrderType >0 group by O_CostCentre
update #sales_cost_data set st_mtd_ordervalue = m_mtd_value from #tmpmtdOrders where m_costcentre = st_costcentre
update #sales_cost_data set st_ytd_ordervalue = y_ytd_value from #tmpytdOrders where y_costcentre = st_costcentre
update #sales_cost_data set st_mtd_ordervalue=0 where st_mtd_ordervalue is null
update #sales_cost_data set st_ytd_ordervalue=0 where st_ytd_ordervalue is null
select * from #sales_cost_data
drop table #tradedays
drop table #tmptradeday
drop table #mtddata
drop table #tmpdata1
drop table #tmpdata2
drop table #tmpmtdOrders
drop table #tmpytdOrders
drop table #sales_cost_data
end
n