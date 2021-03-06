USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00367_sel_WH_uom]    Script Date: 10/05/2021 14:00:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00367_sel_WH_uom] 
@Warehouse AS NVARCHAR(20)
WITH RECOMPILE 
AS 
BEGIN 
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF

create table #temp
(
	s_stockcode nvarchar(35),
	s_description1 nvarchar(25),
	s_description2 nvarchar(25),
	s_stockbal numeric(20),
	s_avgcost numeric(28,2),
	s_stdcost numeric(28,2),
    s_uomint int,
	s_uom nvarchar(25),
	s_wh nvarchar(6),
	s_suppcode nvarchar(10),
	s_altsuppcode nvarchar(35)
)
INSERT #temp
SELECT 
    SC03001    "StockCode" 
 ,  SC01002    "Description1" 
 ,  SC01003    "Description2" 
 ,  SC03003    "StockBal" 
 ,  SC03057    "AvgCost" 
 ,  SC03058    "StdCost" 
 ,  SC01227    "UOMCode"
 ,  Null	   "UOM"
 ,  SC03002    "WH" 
 ,  SC03022    "SuppCode"
 ,  SC01060    "AltSuppCode"
  
  FROM [ScaCompanyDB]..SC010100     INNER JOIN    [ScaCompanyDB]..SC030100 
                                  ON   SC01001 = SC03001                                   
  WHERE SC03002   =  @Warehouse  and SC03003 <> '0' and SC03001 <> ''
  
  GROUP BY  
	   SC03001
	 , SC01002
	 , SC01003
	 , SC03003
	 , SC03057
	 , SC03058
	 , SC01227
	 , SC03002
	 , SC03022
	 , SC01060 

update #temp set s_uom='Each' from ScaCompanyDB..SC010100 where s_uomint=0
update #temp set s_uom='Kg' from ScaCompanyDB..SC010100 where s_uomint=1
update #temp set s_uom='Lt' from ScaCompanyDB..SC010100 where s_uomint=2
update #temp set s_uom='Box' from ScaCompanyDB..SC010100 where s_uomint=3
update #temp set s_uom='Roll' from ScaCompanyDB..SC010100 where s_uomint=4
update #temp set s_uom='Pair' from ScaCompanyDB..SC010100 where s_uomint=5
update #temp set s_uom='Kltr' from ScaCompanyDB..SC010100 where s_uomint=6
update #temp set s_uom='Metre' from ScaCompanyDB..SC010100 where s_uomint=7
update #temp set s_uom='Gram' from ScaCompanyDB..SC010100 where s_uomint=8
update #temp set s_uom='Pack' from ScaCompanyDB..SC010100 where s_uomint=9
update #temp set s_uom='Bale' from ScaCompanyDB..SC010100 where s_uomint=10
update #temp set s_uom='Ctn' from ScaCompanyDB..SC010100 where s_uomint=11
update #temp set s_uom='Drum' from ScaCompanyDB..SC010100 where s_uomint=12
update #temp set s_uom='Kit' from ScaCompanyDB..SC010100 where s_uomint=13
update #temp set s_uom='Assy' from ScaCompanyDB..SC010100 where s_uomint=14
update #temp set s_uom='Set' from ScaCompanyDB..SC010100 where s_uomint=15
update #temp set s_uom='Btl' from ScaCompanyDB..SC010100 where s_uomint=16
update #temp set s_uom='MtrSq' from ScaCompanyDB..SC010100 where s_uomint=17
update #temp set s_uom='Ft' from ScaCompanyDB..SC010100 where s_uomint=18
update #temp set s_uom='Gal' from ScaCompanyDB..SC010100 where s_uomint=19
update #temp set s_uom='Lbs' from ScaCompanyDB..SC010100 where s_uomint=20
update #temp set s_uom='Unit' from ScaCompanyDB..SC010100 where s_uomint=21
update #temp set s_uom='Pc' from ScaCompanyDB..SC010100 where s_uomint=22
update #temp set s_uom='Pcs' from ScaCompanyDB..SC010100 where s_uomint=23
update #temp set s_uom='1000L Tank' from ScaCompanyDB..SC010100 where s_uomint=24
update #temp set s_uom='Case' from ScaCompanyDB..SC010100 where s_uomint=25
update #temp set s_uom='Reel' from ScaCompanyDB..SC010100 where s_uomint=26
update #temp set s_uom='5Ltr' from ScaCompanyDB..SC010100 where s_uomint=27
update #temp set s_uom='20Ltr' from ScaCompanyDB..SC010100 where s_uomint=28
update #temp set s_uom='22.5Ltr' from ScaCompanyDB..SC010100 where s_uomint=29
update #temp set s_uom='200Ltr' from ScaCompanyDB..SC010100 where s_uomint=30
update #temp set s_uom='25Ltr' from ScaCompanyDB..SC010100 where s_uomint=31
update #temp set s_uom='BAG' from ScaCompanyDB..SC010100 where s_uomint=32
update #temp set s_uom='M2' from ScaCompanyDB..SC010100 where s_uomint=33
update #temp set s_uom='Bundles' from ScaCompanyDB..SC010100 where s_uomint=34
update #temp set s_uom='Cone' from ScaCompanyDB..SC010100 where s_uomint=35
update #temp set s_uom='Gr' from ScaCompanyDB..SC010100 where s_uomint=36
update #temp set s_uom='grams' from ScaCompanyDB..SC010100 where s_uomint=37

Select * from #temp
drop table #temp

END
