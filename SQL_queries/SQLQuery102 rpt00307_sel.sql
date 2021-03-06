USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00307_sel]    Script Date: 10/05/2021 11:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00307_sel] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

CREATE TABLE #work
	(
		OrderNo			nvarchar(10),
		OrderDate       dateTime,	
		InvoiceDate		DateTime,		
		OrderValue	    NUMERIC(20,8) null,
		CC				CHAR(2) NULL,
		ProcessDays     Integer NULL,
		MonthName       NVARCHAR(16)
	)
 
INSERT INTO #work
SELECT ST03009 ,
NULL,
MAX(ST03015),
NULL,
NULL ,
NULL ,
NULL
FROM ScaCompanyDB..ST030100
WHERE ST03015 > '2009-01-01'
GROUP BY ST03009 

UPDATE #work
Set OrderValue= OR20024,
	CC = SUBSTRING(OR20025,7,2),
	OrderDate = OR20015
FROm ScaCompanyDB..OR200100 
WHERE OrderNo = OR20001 COLLATE Database_Default
	

UPDATE #work
Set ProcessDays = (DATEDIFF(dd,OrderDate, InvoiceDate) + 1)

UPDATE #work
 SET MonthName = (SELECT CONVERT(varchar(3), InvoiceDate, 100) as Month)

select * from #WORK
WHERE OrderDate > '2010-01-01'
AND CC in ('11','21')
AND ProcessDays > 0
Order By CC, OrderNo
END

Drop table #work
