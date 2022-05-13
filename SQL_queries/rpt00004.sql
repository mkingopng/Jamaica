USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00004]    Script Date: 10/04/2021 14:26:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SSRS_RPT00004]
	@s_date datetime=NULL, @e_date datetime=NULL
as
begin
create table #stdcoststore
(     t_stockcode nvarchar (20),
      t_description nvarchar (50),
      t_wh nvarchar(2),
      t_currstdcost numeric (28,8),
      t_prevstdcost numeric (28,8),
      t_landedcost numeric(28,8),
      t_datelastupdate datetime,
      t_datelastcalculation datetime,
      t_rundate date
 )
insert into #stdcoststore
select 
 SC03001
,SC01002 + '' + SC01003
,SC03002
,SC03058
,SC03059
,SC03079
,SC03097
,SC03033
,GETDATE()
from ScaCompanyDB..SC030100 INNER JOIN ScaCompanyDB..MP570100 ON MP57001 = SC03001
							INNER JOIN ScaCompanyDB..SC010100 ON SC01001 = SC03001		
where SC03002=MP57070
if @s_date is not null 
	begin
	select * from IscalaAnalysis..tbl_StandardCostUpdateStore where t_rundate between @s_date and @e_date order by t_stockcode, t_rundate
	end
if @s_date is null  
	begin
	select * from #stdcoststore
	end
drop table #stdcoststore
end