USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00348_History_subrpt]    Script Date: 10/05/2021 12:58:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00348_History_subrpt] 
		@PONumber	 as NVARCHAR(256)
--	 ST080100.ST08022, ST080100.ST08024 AS 'Inv No (Batch)'
AS
BEGIN
		SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF
DECLARE @StartDate as Datetime=NULL,
	    @EndDate as Datetime=NULL
		,@DateSelected as BIT
        ,@command as NVARCHAR(4000)
	    ,@ThisMonth as NVARCHAR(7)
	    ,@DateRange as NVARCHAR(50)
		--,@LastYear as NVARCHAR (4)
	    --@MonthValue as CHAR(7),
		--@YearValue as CHAR(7)
		--,@Singlew as NVARCHAR(256)
IF @StartDate IS NULL	
	SELECT @EndDate = NULL

IF @EndDate IS NULL	
	SELECT @StartDate = NULL
	
SELECT @ThisMonth =  rtrim(cast(datepart(yyyy,GETDATE()) as char))+ 'M' + substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2) 	
IF @StartDate IS NULL 
	BEGIN
		SELECT @DateSelected = 0 
		SELECT @DateRange = @ThisMonth
	END
ELSE
	BEGIN
		SELECT @DateSelected = 1 
		SELECT @DateRange = (rtrim(cast(datepart(yyyy,@StartDate) as char))+ 'M' + substring(cast(cast(datepart(mm,@StartDate) as INT)+100 as char),2,2))
		SELECT @DateRange = @DateRange + ' to '
		SELECT @DateRange = @DateRange + (rtrim(cast(datepart(yyyy,@EndDate) as char))+ 'M' + substring(cast(cast(datepart(mm,@EndDate) as INT)+100 as char),2,2)) 	 	
	END
SELECT DISTINCT PC420100.PC42008 AS 'PO Unit Price', PC42008*PC42010 AS 'PO Total', 
(PL03014-PL03016) AS 'Inv Total',PC410100.PC41001 AS 'PO Number', PC410100.PC41015 AS 'PO Date', PL010100.PL01001 As 'Supplier Code',PL010100.PL01002 As 'Supplier Name',
PC420100.PC42005 AS 'Stock Code', PC420100.PC42006 AS 'Description',SYCD0100.SYCD009 AS 'Currency Code', 
PC420100.PC42012 AS 'PO Qty', 
PL03004 AS 'Invoice Date'--, ST080100.ST08021 AS 'Inv Qty'

FROM ScaCompanyDB.dbo.PC410100 PC410100, ScaCompanyDB.dbo.SYCD0100 SYCD0100,ScaCompanyDB.dbo.PC420100 PC420100, ScaCompanyDB.dbo.PL030100  PL030100,  ScaCompanyDB.dbo.PL010100 PL010100 
WHERE PC410100.PC41022 = SYCD0100.SYCD001 and PC410100.PC41001 = PC420100.PC42001  and PC410100.PC41003 = PL010100.PL01001 AND PL030100.PL03033  = PC420100.PC42001 
--AND PC030100.PC03005 = ST080100.ST08011
--AND PC01002 in ('1','2') 
--and ST08004 = '1'
and PC420100.PC42001 = @PONumber


 
order by PC410100.PC41015
END
