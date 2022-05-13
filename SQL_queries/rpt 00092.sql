USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00092]    Script Date: 10/04/2021 14:34:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00092]
	-- Add the parameters for the stored procedure here
		@StartDate as Datetime=NULL,
	    @EndDate as Datetime=NULL,
	    @WareHouse	NVARCHAR(256) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
		SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF
--DECLARE @DateSelected as BIT
     --   ,@command as NVARCHAR(4000)
	    --,@ThisMonth as NVARCHAR(7)
	    --,@DateRange as NVARCHAR(50)
		--,@LastYear as NVARCHAR (4)
	    --@MonthValue as CHAR(7),
		--@YearValue as CHAR(7)
		--,@Singlew as NVARCHAR(256)
IF @StartDate IS NULL and @EndDate IS NULL	
Begin
	SELECT @StartDate = GETDATE()
	SELECT @EndDate = GETDATE()
end
--IF @EndDate IS NULL	
	--SELECT @StartDate = NULL
	
--SELECT @ThisMonth =  rtrim(cast(datepart(yyyy,GETDATE()) as char))+ 'M' + substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2) 	



 
 SELECT "ST030100"."ST03017", "ST030100"."ST03020", "ST030100"."ST03021", "ST030100"."ST03022", "ST030100"."ST03010", "SC010100"."SC01002", "SC010100"."SC01003", "SC010100"."SC01052", "SC010100"."SC01004", "SC010100"."SC01038", "ST030100"."ST03011", "ST030100"."ST03016", "SC030100"."SC03057", "SC030100"."SC03002"
 FROM   ("ScaCompanyDB"."dbo"."SC010100" "SC010100" INNER JOIN "ScaCompanyDB"."dbo"."ST030100" "ST030100" ON "SC010100"."SC01001"="ST030100"."ST03017") INNER JOIN "ScaCompanyDB"."dbo"."SC030100" "SC030100" ON "SC010100"."SC01001"="SC030100"."SC03001"
-- WHERE  "SC010100"."SC01038"=N'CS' AND "SC030100"."SC03002"=N'05'        
WHERE  "SC010100"."SC01038" IN (N'CHI','CHR','CHS','COI','COS') AND "SC030100"."SC03002"=N'05'        
        And left(ltrim(ST03011),2) in ('11','21')
        And "ST030100"."ST03016" between REPLACE(CONVERT(VARCHAR(10), @StartDate, 111), '/', '-') and REPLACE(CONVERT(VARCHAR(10), @EndDate, 111), '/', '-')
        And "SC030100"."SC03002" = @WareHouse
 ORDER BY "ST030100"."ST03017"


end
