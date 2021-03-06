USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00301_sel]    Script Date: 10/05/2021 11:06:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00301_sel]
--DECLARE
		@s_date as datetime, 
		@e_date as datetime,
		@wh as varchar(100) = null

AS

 SELECT 
	SC07001
,	SC07002
,	SC01001
,	SC01002
,	SC01003
,	SC07004
,	SC07009
,	SC23002
,	SC03057
,	SC07006
,	SC01038
,	SC03058
,   SUM(SC07004*SC03058)
 FROM   ScaCompanyDB..SC010100  INNER JOIN ScaCompanyDB..SC070100 ON SC01001=SC07003 
 INNER JOIN ScaCompanyDB..SC030100 ON SC07003=SC03001 AND SC07009=SC03002
 INNER JOIN ScaCompanyDB..SC230100 ON SC07009=SC23001
 WHERE  SC07002>= @s_date AND SC07002 < @e_date
 AND SC07009 collate database_default in (select Value from dbo.Split(',',@wh) )
 AND SC07001='02' 
 AND SC01038 IN ('CHI','CHR','CHS','CHSP','COI','CON','COS','EMB','ENSP','FLSP','HISP','OII',
				 'OIL','OIR','OIS','OISP','PAI','PAR','PAS','PASP','PEI','PER', 'PES','PESP',
				 'PLI','PLR','PLS','PLSP','REI','RES','ROI','ROR','ROS','ROSP','SAF')
 GROUP BY SC07009, SC23002, SC01001, SC07002, SC01002, SC01003, SC07004, SC03057, SC03058, SC07006, SC07001, SC01038
--	WHERE       su_division  collate database_default in (Select Value from dbo.Split(',',@Division)  ) 

