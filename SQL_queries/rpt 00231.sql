USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00231_1_7_sel]    Script Date: 10/04/2021 14:44:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SSRS_RPT00231_1_7_sel]

@Division as varchar(8000)= null,
@Location as varchar(40)= null

as

create table #temptable1 (
	t_item nvarchar(35) NULL,
	t_suppcode nvarchar(35) NULL,
	t_description nvarchar(25) NULL,
	t_description2 nvarchar(25) NULL,
	t_currentaveragecost numeric(20, 8) NULL,
	t_onhandqty numeric(20, 8) NULL,
	t_Laeonhandqty numeric(20, 8) NULL,
	t_POMonhandqty numeric(20, 8) NULL,
	t_onhandvalue numeric(20, 8) NULL,
	t_stockhistory numeric(20, 8) NULL,
	t_division nvarchar(32) NULL,
	t_location nvarchar(10) NULL,
	t_sortvalue nvarchar(50) NULL,
	t_firstorderdate datetime NULL,
	t_lastorderdate datetime NULL,
	t_rundate datetime NULL,
	t_sixmonthsago datetime NULL,
	t_sixmonthsmaxtrans nvarchar(16) NULL,
	t_twelvemonthsago datetime NULL,
	t_twelvemonthsmaxtrans nvarchar(16) NULL,
	t_extendedproductgroup nvarchar(20) NULL,
	t_tbl105_onhand numeric(20, 8) NULL,
	t_accstring nvarchar(50) NULL,
	t_accstringname nvarchar(25) NULL,
	t_excessqty numeric(20, 8) NULL,
	t_excessvalue numeric(20, 8) NULL,
	t_mnt_holding numeric(20, 8) NULL,
	t_displayfield numeric(20, 8) NULL
)

insert into #temptable1
select 
	su_item ,
	su_suppcode,
	su_description,
	su_description2,
	su_currentaveragecost,
	su_onhandqty,
	su_Laeonhandqty,
	su_POMonhandqty,
	su_onhandvalue,
	su_stockhistory,
	su_division,
	su_location,
	su_sortvalue,
	su_firstorderdate,
	su_lastorderdate,
	su_rundate,
	su_sixmonthsago,
	su_sixmonthsmaxtrans,
	su_twelvemonthsago,
	su_twelvemonthsmaxtrans,
	su_extendedproductgroup,
	su_tbl105_onhand,
	su_accstring,
	su_accstringname,
	0,0,0,0
from IscalaAnalysis.dbo.KK_Rpt00231Data

update #temptable1

set t_excessqty = t_onhandqty - t_stockhistory from #temptable1 where t_onhandqty > t_stockhistory
and t_firstorderdate < t_sixmonthsago or t_firstorderdate is null

update #temptable1
set t_excessqty = 0 from #temptable1 where t_onhandqty < t_stockhistory
and t_firstorderdate > t_sixmonthsago or t_firstorderdate is null

update #temptable1
set t_excessvalue = t_excessqty * t_currentaveragecost from #temptable1 where t_stockhistory >0

update #temptable1
set t_excessvalue = t_onhandvalue from #temptable1 where t_stockhistory <= 0

update #temptable1
set t_mnt_holding = 0 from #temptable1 where t_onhandqty <= 0 or t_stockhistory <= 0

update #temptable1
set t_mnt_holding = (t_onhandqty/t_stockhistory)*6 from #temptable1 where t_onhandqty > 0 and t_stockhistory > 0

--select * from #temptable1 where t_division='Raw Chemicals'
--order by t_item asc

select * from #temptable1
where t_division  collate database_default in (Select Value from dbo.Split(',',@Division)  ) 
and t_location collate database_default in (Select Value from dbo.Split(',',@Location)  )
order by t_sortvalue, t_item
