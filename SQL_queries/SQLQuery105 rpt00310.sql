USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00310_sel]    Script Date: 10/05/2021 11:09:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 08/07/2010>
-- Description:	Calculated invoice processing days>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00310_sel] 
	@startDate as Date,
	@endDate as date,
	@Department as nvarchar(256)
AS

DECLARE @cmd as NVARCHAR(2048),
	@CostCentre as NVARCHAR(256),
	@Single as bit

--

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work310]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	Drop table #work310
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work310_totals]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	Drop table #work310_totals


CREATE TABLE #work310
	(
		OrderNo			nvarchar(10),
		OrderDate       dateTime,	
		Cusno           nvarchar(10),
		CusName         NVARCHAR(35),
		InvoiceDate		DateTime,		
		OrderValue	    NUMERIC(20,8) null,
		CC				CHAR(2) NULL,
		ProcessDays     Integer NULL,
		MonthName       NVARCHAR(16),
		Department      NVARCHAR(256),
		RecordCount		NUMERIC(20,8),
		TotalProcessDays NUMERIC(20,8) NULL,
		MeanProcessDays NUMERIC(20,8) null,
		StatDevProcessDays  NUMERIC(20,8) null         
	)

SELECT @cmd = 'INSERT INTO #work310 '
SELECT @cmd = @cmd + 'SELECT ST03009 ,'
SELECT @cmd = @cmd + 'NULL, '
SELECT @cmd = @cmd + 'NULL, '
SELECT @cmd = @cmd + 'NULL, '
SELECT @cmd = @cmd + 'MAX(ST03015), '
SELECT @cmd = @cmd + 'NULL, '
SELECT @cmd = @cmd + 'SUBSTRING(ST03011,7,2) , '
SELECT @cmd = @cmd + 'NULL , '
SELECT @cmd = @cmd + 'NULL , '
SELECT @cmd = @cmd + 'NULL, '
SELECT @cmd = @cmd + 'NULL, '
SELECT @cmd = @cmd + 'NULL, '
SELECT @cmd = @cmd + 'NULL, '
SELECT @cmd = @cmd + 'NULL '
SELECT @cmd = @cmd + 'FROM ScaCompanyDB..ST030100 '
SELECT @cmd = @cmd + 'WHERE ST03015 BETWEEN ''' + CAST(@startdate as CHAR(10)) +  ''' '
SELECT @cmd = @cmd + 'AND  ''' + CAST(@enddate as CHAR(10)) +  ''' '
IF NOT @Department = 'All '
	IF @Single = 1 
		SELECT @cmd = @cmd +  'AND SUBSTRING(ST03011,7,2)  =  ''' +  @costcentre  +  ''' '
	Else
		SELECT @cmd = @cmd +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
SELECT @cmd = @cmd + 'GROUP BY ST03009, SUBSTRING(ST03011,7,2) '
EXECUTE (@cmd)


UPDATE #work310
Set OrderValue= OR20024,
	OrderDate = OR20015,
	Cusno =  OR20003
FROM ScaCompanyDB..OR200100 
WHERE OrderNo = OR20001 COLLATE Database_Default

UPDATE #work310
Set CusName= SL01002
FROM ScaCompanyDB..SL010100 
WHERE Cusno = SL01001 COLLATE Database_Default

DELETE FROM #work310 WHERE SUBSTRING(cusno,1,4) = 'INTR'
IF @Department = 'Commercial POM '
DELETE FROM #work310 WHERE Cusno  = 'POMPAC3'

IF @Department = 'Industrial '
DELETE FROM #work310 WHERE Cusno  = 'INTRHKKIND'
IF @Department = 'Industrial Lae '
DELETE FROM #work310 WHERE Cusno  = 'INTRHKKIND'
IF @Department = 'Industrial POM '
DELETE FROM #work310 WHERE Cusno  = 'INTRHKKIND'
IF @Department = 'Industrial Contracts '
DELETE FROM #work310 WHERE Cusno  = 'INTRHKKIND'
UPDATE #work310
Set ProcessDays = (DATEDIFF(dd,OrderDate, InvoiceDate) + 1)

UPDATE #work310
 SET MonthName = (SELECT CONVERT(varchar(3), InvoiceDate, 100) as Month)
   
Update #work310
SET Department = CostCentreName
FROm KK_CostCentre
WHERE CC=CostCentre COLLATE Database_Default
     


	SELECT CC "SCC",
	'PD' "Stype",
	SUM(ProcessDays) "SPD" 
	INTO #work310_totals
	FROM #work310 
	GROUP BY CC

INSERT INTO #work310_totals
	SELECT CC "SCC",
	'RC' "Stype",
	COUNT(*) "SPD"
	FROM #work310 
	GROUP BY CC
	
INSERT INTO #work310_totals
	SELECT CC "SCC",
	'SD' "Stype",
	StDev(ProcessDays) "SPD" 
	FROM #work310 
	GROUP BY CC
	

UPDATE #work310
SET TotalProcessDays = SPD
FROM #work310_totals
WHERE CC = SCC
AND Stype = 'PD'

UPDATE #work310
SET RecordCount = SPD
FROM #work310_totals
WHERE CC = SCC
AND Stype = 'RC'

UPDATE #work310
SET StatDevProcessDays = SPD
FROM #work310_totals
WHERE CC = SCC
AND Stype = 'SD'

UPDATE #work310
SET MeanProcessDays = (TotalProcessDays /  RecordCount)


IF @Department = 'Commercial POM '
SELECT @cmd = 'SELECT * from #WORK310 WHERE Cusno <> ''POMPAC3'' Order By CC, OrderNo '
--SELECT @cmd = @cmd +'WHERE Cusno <> ''POMPAC3'' '
--SELECT @cmd = @cmd + 'Order By CC, OrderNo'
--SELECT @cmd
--EXECUTE(@cmd)
ELSE
SELECT @cmd = 'SELECT * from #WORK310 Order By CC, OrderNo '
--SELECT @cmd = @cmd +'WHERE Cusno <> POMPAC3 '
--SELECT @cmd = @cmd + 'Order By CC, OrderNo'
--SELECT @cmd
EXECUTE(@cmd)

END
