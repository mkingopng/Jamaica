USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00352_sel_v2]    Script Date: 10/05/2021 13:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- ================================================= --
-- Author:		<Isaac Kababa>						 --
-- Create date: <16/08/2015>						 --
-- Description:	<Monthly sales activity by salesman> --
--				<Modified version of SSRS_RPT00352 > --
--				<capturing sales vs budgets for	   > --
--				<sales commission calculations	   > --
-- ================================================= --
ALTER procedure [dbo].[SSRS_RPT00352_sel_v2]
		@Year as nvarchar(4),
		@Month as nvarchar(2)
as
begin
	declare @YearMonth as nvarchar(7)
	select @YearMonth = @Year + 'M' + @Month
	set nocount on;	

	--create virtual table to hold rpt352 query result
	create table #rpt352data
	(
		r_salesmancode	nvarchar(3),
		r_salesmanname	nvarchar(50),
		r_salesman_id	nvarchar(4),
		r_salesdivision nvarchar(50),
		r_customercode	nvarchar(10),
		r_netvalue		numeric(20,8),
		r_costvalue		numeric(20,8),
		r_net_margin	numeric(20,8),
		r_budget		numeric(20,8),
		r_yearmnth		nvarchar(7),
		r_costcntr		nvarchar(3),
		r_costcntrname	nvarchar(50)
	)
	--creat virtual table to hold budget figures
	create table #tempbudgetsindustrial(
		b_division		nvarchar(50),
		b_salesman		nvarchar(50),
		b_period		nchar(2),
		b_year			nvarchar(4),
		b_budget		numeric(20,8)
	)	
	create table #tempbudgetscommercial(
		b_division		nvarchar(50),
		b_salesman		nvarchar(50),
		b_period		nchar(2),
		b_year			nvarchar(4),
		b_budget		numeric(20,8)
	)	
	create table #tempbudgetsretail(
		b_division		nvarchar(50),
		b_salesman		nvarchar(50),
		b_period		nchar(2),
		b_year			nvarchar(4),
		b_budget		numeric(20,8)
	)	
	create table #tempbudgetsgns(
		b_division		nvarchar(50),
		b_salesman		nvarchar(50),
		b_period		nchar(2),
		b_year			nvarchar(4),
		b_budget		numeric(20,8)
	)	

	create table #tempbudgetsroto(
		b_division		nvarchar(50),
		b_salesman		nvarchar(50),
		b_period		nchar(2),
		b_year			nvarchar(4),
		b_budget		numeric(20,8)
	)	

	create table #tempbudgetsmine(
		b_division		nvarchar(50),
		b_salesman		nvarchar(50),
		b_period		nchar(2),
		b_year			nvarchar(4),
		b_budget		numeric(20,8)
	)	

	if substring(@Month,1,1) <> '1'
	insert into #tempbudgetsindustrial	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Industrial
	where Year=@Year and Period=substring(@Month,2,1)
	else  
	insert into #tempbudgetsindustrial	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Industrial
	where Year=@Year and Period=@Month

	if substring(@Month,1,1) <> '1'
	insert into #tempbudgetscommercial	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Commercial
	where Year=@Year and Period=substring(@Month,2,1)
	else  
	insert into #tempbudgetscommercial	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Commercial
	where Year=@Year and Period=@Month

	if substring(@Month,1,1) <> '1'
	insert into #tempbudgetsretail	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Retail
	where Year=@Year and Period=substring(@Month,2,1)
	else
	insert into #tempbudgetsretail	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Retail
	where Year=@Year and Period=@Month

	if substring(@Month,1,1) <> '1'
	insert into #tempbudgetsgns	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_GNS
	where Year=@Year and Period=substring(@Month,2,1)
	else
	insert into #tempbudgetsgns	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_GNS
	where Year=@Year and Period=@Month

	if substring(@Month,1,1) <> '1'
	insert into #tempbudgetsroto	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Rotomould
	where Year=@Year and Period=substring(@Month,2,1)
	else
	insert into #tempbudgetsroto	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Rotomould
	where Year=@Year and Period=@Month

	if substring(@Month,1,1) <> '1'
	insert into #tempbudgetsmine	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Mining
	where Year=@Year and Period=substring(@Month,2,1)
	else
	insert into #tempbudgetsmine	
	select division, salesman,period,YEAR,budget from KK_SalesmanBudgets_Mining
	where Year=@Year and Period=@Month
	
	--collate invoice statistics in virtual rpt352 table
	insert into #rpt352data
	select
    T1.ST03007    "Salesman"
 , 	T2.SY24003    "Salesm Name"
 ,	NULL
 ,  NULL
 ,  T1.ST03001 "CustCode"
 , 	sum((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100))   "Net Value"
 ,	sum(T1.ST03020 * T1.ST03023)   "Cost Value"
 , 	sum(((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100)) - (T1.ST03020 * T1.ST03023))   "Net Profit"
 ,	NULL
 ,	@YearMonth  "Year Month"
 ,	substring(T1.ST03011,7,3) 'Cost Centre'
 ,	CostCentreName "Name"
	from [ScaCompanyDB]..SY240100 T2    
	right outer join    [ScaCompanyDB]..ST030100 T1
    on   T2.SY24002 = T1.ST03007  AND T2.SY24001 = 'BK'
    join KK_CostCentre
    on substring(T1.ST03011,7,3) = CostCentre collate database_default
	where rtrim(cast(datepart(yyyy,T1.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)   =  @YearMonth
   	group by
  	T1.ST03007
 ,	T2.SY24003,T1.ST03001
 ,	substring(T1.ST03011,7,3)
 ,  CostCentreName
	order by T1.ST03007

	--update rpt352 virtual table with salesman id/kkk employee id
	update #rpt352data
	set r_salesman_id = EmployeeID
	from [Kingston Hardware]..tbl_Staff
	where lower(Name)   = lower(r_salesmanname) collate database_default
	and Active = 1

	--update virtual budget table with each salesman division

	update #rpt352data
	set r_salesdivision = b_division, r_budget=b_budget
	from #tempbudgetsindustrial
	where r_costcntr = '10'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision = b_division, r_budget=b_budget
	from #tempbudgetsindustrial
	where r_costcntr = '20'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision = b_division, r_budget=b_budget
	from #tempbudgetscommercial
	where r_costcntr = '11'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision = b_division, r_budget=b_budget
	from #tempbudgetscommercial
	where r_costcntr = '21'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision = b_division, r_budget=b_budget
	from #tempbudgetsretail
	where r_costcntr = '14'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision = b_division, r_budget=b_budget
	from #tempbudgetsretail
	where r_costcntr = '24'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision =b_division, r_budget=b_budget
	from #tempbudgetsgns
	where r_costcntr = '19'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision =b_division, r_budget=b_budget
	from #tempbudgetsgns
	where r_costcntr = '40'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision =b_division, r_budget=b_budget
	from #tempbudgetsroto
	where r_costcntr = '29'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision =b_division, r_budget=b_budget
	from #tempbudgetsroto
	where r_costcntr = '30'
	and r_salesman_id =b_salesman collate database_default

	update #rpt352data
	set r_salesdivision =b_division, r_budget=b_budget
	from #tempbudgetsmine
	where r_costcntr = '22'
	and r_salesman_id =b_salesman collate database_default

	delete from kk_rpt00352data1

	insert into kk_rpt00352data1 select * from #rpt352data
	
	select * from kk_rpt00352data1 where r_budget is not null
end