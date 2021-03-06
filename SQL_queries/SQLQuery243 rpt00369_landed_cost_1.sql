USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00369_LandCost_1]    Script Date: 10/05/2021 14:03:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00369_LandCost_1]
@StockCode As NVARCHAR(35),
@SuppCode AS NVARCHAR(20)
AS
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF
DROP TABLE COST
CREATE TABLE COST
 (
   c_stockcode nvarchar(35),
   c_description nvarchar(50),
   c_Supp nvarchar(10),
   c_ref nvarchar(10),
   c_t_Date datetime,
   c_b_no  nvarchar(10) ,
   c_cost numeric (20,2),
   c_Fob numeric(20,4),
   c_qty numeric (20,2),
   c_Fob_Tot numeric (20,4),
   c_Landed_cost numeric(20,4)
   
 )

DROP TABLE COST_1 
 CREATE TABLE COST_1
 (
   r_stockcode nvarchar(35),
   r_description nvarchar(50),
   r_Supp nvarchar(10),
   r_t_Date datetime,
   r_b_no  nvarchar(10) ,
   s_Fob numeric(20,4),
   S_qty numeric (20,2),
   S_Fob_Tot numeric (20,4),
   S_LandedCost numeric(20,4),
   r_Gl_no nvarchar(20)
   
 )

 DROP TABLE COST_2
 CREATE TABLE COST_2
 (
   r2_stockcode nvarchar(35),
   r2_t_Date datetime,
   r2_b_no  nvarchar(10),
   r2_cost numeric(20,4),
   r2_ref nvarchar(10),
   r2_qty numeric (20,2),
   r2_gl_no NVARCHAR(20) 
   --r2_cost numeric(20),
  -- r2_ref  nvarchar(20)
  )
 INSERT INTO COST_1 
 SELECT SC07003,SC01002,SC07006,SC07002,SC07007, SC07005, SC07004, SC07004*SC07005,(SC07004*SC07005/SC07004),SC07020
 FROM ScaCompanyDB..SC070100 INNER JOIN ScaCompanyDB..SC010100 ON SC01001 = SC07003 and SC07001 = '00' 
 and SC07003 = @StockCode  and SC07006 = @SuppCode --'15-01-0200' and SC07006 = 'AUDPRI' and SC07007  = '0000075095'

 INSERT INTO COST_2 
 SELECT SC07003,SC07002,SC07007,SC07005,SC07006,(SC07004),SC07020
 --SUM(Case When SC03002 =  '02' Then SC03003 End ),
-- SUM( Case When SC03002 =  '03' Then SC03003 End ),
 --SUM( Case When SC03002 =  '05' Then SC03003 End ),
 --SUM( Case When SC03002 =  '12' Then SC03003 End) ,
-- SUM( Case When SC03002 =  '13' Then SC03003 End ),
 --SUM( Case When SC03002 =  '03' Then SC03005 End ),
-- SUM( Case When SC03002 =  '05' Then SC03005 End ),
 --SUM( Case When SC03002 =  '03' Then SC03003-(SC03004+SC03005) End),
-- SUM( Case When SC03002 =  '05' Then SC03003-(SC03004+SC03005) End )
 FROM ScaCompanyDB..SC070100 INNER JOIN COST_1  ON r_stockcode COLLATE DATABASE_DEFAULT =  SC07003 
 where  r_b_no COLLATE DATABASE_DEFAULT = SC07007
 --where SC07007 = r_b_no COLLATE DATABASE_DEFAULT 
 --GROUP BY SC03001
GROUP BY SC07003,SC07007,SC07005,SC07006,SC07002,SC07004,SC07020 



INSERT INTO COST 
 SELECT r2_stockcode,0,0,r2_ref,0,r2_b_no,r2_cost,0,r2_qty,0,0
 --SUM(Case When r2_b_no  = r2_b_no  Then c_cost End )
 FROM COST_2 

UPDATE COST 
SET 
c_description = r_description,
c_Supp = r_Supp,
c_Fob = s_Fob, 
--C_qty = S_qty,
c_Fob_Tot = S_Fob_Tot
--c_Landed_cost = S_LandedCost

FROM COST_1 where  r_b_no = C_b_no
UPDATE COST 
SET c_cost = '0', c_ref = 'NULL'
where c_qty <> '0'

SELECT * from COST
