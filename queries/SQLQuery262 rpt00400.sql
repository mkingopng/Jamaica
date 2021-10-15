USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00400CreateData]    Script Date: 10/05/2021 14:13:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SSRS_RPT00400CreateData]
AS
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF

Declare @currdate as datetime

Set @currdate = GETDATE()

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#temptable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#temptable]

create table #temptable
(
currdate			 datetime,
item				 nvarchar(35),	
description			 nvarchar(60),
Warehouse			 NVARCHAR(6),
AverageCost			 Numeric(20,8)
)	

INSERT INTO #temptable
SELECT ''+ @currDate +'',SC01001, SC01002, SC03002, SC03057 
FROM ScaCompanyDB..SC010100
INNER JOIN ScaCompanyDB..SC030100 ON SC01001=SC03001
WHERE SC01001='11-01-0008' And SC03002='05'

INSERT INTO #temptable
SELECT ''+ @currDate +'',SC01001, SC01002, SC03002, SC03057 
FROM ScaCompanyDB..SC010100
INNER JOIN ScaCompanyDB..SC030100 ON SC01001=SC03001
WHERE SC01001='11-01-0018' And SC03002='05'

INSERT INTO #temptable
SELECT ''+ @currDate +'',SC01001, SC01002, SC03002, SC03057 
FROM ScaCompanyDB..SC010100
INNER JOIN ScaCompanyDB..SC030100 ON SC01001=SC03001
WHERE SC01001='11-01-0019' And SC03002='05'

INSERT INTO #temptable
SELECT ''+ @currDate +'',SC01001, SC01002, SC03002, SC03057 
FROM ScaCompanyDB..SC010100
INNER JOIN ScaCompanyDB..SC030100 ON SC01001=SC03001
WHERE SC01001='11-01-0026' And SC03002='05'

INSERT INTO #temptable
SELECT ''+ @currDate +'',SC01001, SC01002, SC03002, SC03057 
FROM ScaCompanyDB..SC010100
INNER JOIN ScaCompanyDB..SC030100 ON SC01001=SC03001
WHERE SC01001='11-01-0004' And SC03002='05'

INSERT INTO #temptable
SELECT ''+ @currDate +'',SC01001, SC01002, SC03002, SC03057 
FROM ScaCompanyDB..SC010100
INNER JOIN ScaCompanyDB..SC030100 ON SC01001=SC03001
WHERE SC01001='11-01-0027' And SC03002='05'

INSERT INTO #temptable
SELECT ''+ @currDate +'',SC01001, SC01002, SC03002, SC03057 
FROM ScaCompanyDB..SC010100
INNER JOIN ScaCompanyDB..SC030100 ON SC01001=SC03001
WHERE SC01001='11-01-0050' And SC03002='05'

INSERT INTO IscalaAnalysis..KK_RPT00400Data
SELECT * FROM #temptable


--- 11-01-0050
--- 11-01-0008

