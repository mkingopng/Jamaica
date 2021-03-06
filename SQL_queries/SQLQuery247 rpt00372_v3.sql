USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00372_sel_v3]    Script Date: 10/05/2021 14:08:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00372_sel_v3]
	@Warehouse as nvarchar(2)
AS 
BEGIN 

create table #temp1
(
	s_stockcode nvarchar(35),
	s_wh nvarchar(6),
	s_description1 nvarchar(25),
	s_description2 nvarchar(25),
	s_unitcode int,
	s_uom nvarchar(6),
	s_costprice1 numeric(28,8),
	s_price numeric(28,8),
	s_accountcode nvarchar(50),
	s_prodcatdescr nvarchar(25),
	s_prodgrpdescr nvarchar(25),
	s_stockbalance numeric(20),
	s_reservedqty nvarchar(20),
	s_backorderqty nvarchar(20),
	s_scqtyorder nvarchar(20),
	s_suppname nvarchar(35),
)
INSERT #temp1
SELECT 
    T1.SC01001    "StockCode" 
 ,  T5.SC03002    "WH" 
 ,  T1.SC01002    "Description1" 
 ,  T1.SC01003    "Description2" 
 ,	T1.SC01133    "UnitCode"
 ,	NULL           "UOM"
 ,  T1.SC01053    "StdCostPric1" 
 ,  T2.SC39004    "Price" 
 ,  T1.SC01039    "AccountCode" 
 ,  T3.SY24003    "ProdCat Descr" 
 ,  T4.SY24003    "ProdGrp Descr" 
-- ,  T1.SC01042    "StockBalance" 
 ,  T5.SC03003    "StockBalance" 
 ,  T1.SC01043    "ReservedQty" 
 ,  T1.SC01044    "BackOrdeQty" 
 ,  T1.SC01045    "SCQtyOrder" 
 ,  T6.PL01002	  "SuppName"
  FROM [ScaCompanyDB]..SC010100 T1 INNER JOIN    [ScaCompanyDB]..SC390100 T2
                                  ON   T1.SC01001 = T2.SC39001
                                  INNER JOIN    [ScaCompanyDB]..SC030100 T5
                                  ON   T1.SC01001 = T5.SC03001
                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T4
                                  ON   T1.SC01037 = T4.SY24002  AND 'IB' = T4.SY24001
                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T3
                                  ON   T1.SC01128 = T3.SY24002  AND 'II' = T3.SY24001
                                  INNER JOIN    [ScaCompanyDB]..PL010100 T6
                                  ON   T1.SC01058 = T6.PL01001

--WHERE T3.SY24003   =  'INDUSTRIAL SALES' AND T5.SC03002 = @Warehouse
--WHERE T3.SY24003   =  'INDUSTRIAL SALES' AND T5.SC03001='42-01-1085'AND T5.SC03002 = '12'
--WHERE T5.SC03001='42-01-1085'AND T2.SC39002=00 AND T5.SC03002 = '01'
--WHERE T3.SY24003   <> '' AND T2.SC39002=00 AND T5.SC03002 = '01'--@Warehouse
WHERE T2.SC39002=00 AND T5.SC03002 = @Warehouse

update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=0 and #temp1.s_unitcode=0
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=1 and #temp1.s_unitcode=1
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=2 and #temp1.s_unitcode=2
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=3 and #temp1.s_unitcode=3
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=4 and #temp1.s_unitcode=4
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=5 and #temp1.s_unitcode=5
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=6 and #temp1.s_unitcode=6
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=7 and #temp1.s_unitcode=7
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=8 and #temp1.s_unitcode=8
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=9 and #temp1.s_unitcode=9
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=10 and #temp1.s_unitcode=10
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=11 and #temp1.s_unitcode=11
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=12 and #temp1.s_unitcode=12
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=13 and #temp1.s_unitcode=13
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=14 and #temp1.s_unitcode=14
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=15 and #temp1.s_unitcode=15
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=16 and #temp1.s_unitcode=16
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=17 and #temp1.s_unitcode=17
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=18 and #temp1.s_unitcode=18
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=19 and #temp1.s_unitcode=19
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=20 and #temp1.s_unitcode=20
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=21 and #temp1.s_unitcode=21
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=22 and #temp1.s_unitcode=22
update #temp1
set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=23 and #temp1.s_unitcode=23
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=24 and #temp1.s_unitcode=24
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=25 and #temp1.s_unitcode=25
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=26 and #temp1.s_unitcode=26
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=27 and #temp1.s_unitcode=27
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=28 and #temp1.s_unitcode=28
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=29 and #temp1.s_unitcode=29
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=30 and #temp1.s_unitcode=30
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=31 and #temp1.s_unitcode=31
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=32 and #temp1.s_unitcode=32
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=33 and #temp1.s_unitcode=33
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=34 and #temp1.s_unitcode=34
--update #temp1
--set	s_uom = KK_UOM_1.Value from IscalaAnalysis..KK_UOM_1 where KK_UOM_1.Code=35 and #temp1.s_unitcode=35

SELECT * FROM #temp1

END