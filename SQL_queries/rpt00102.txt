USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00102]    Script Date: 10/04/2021 14:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00102]
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

 SELECT "ST030100"."ST03017", "ST030100"."ST03020", "ST030100"."ST03021", "ST030100"."ST03022", "ST030100"."ST03010", "SC010100"."SC01002", "SC010100"."SC01003", "SC010100"."SC01052", "SC010100"."SC01004", "ST030100"."ST03011", "SC030100"."SC03002", "ST030100"."ST03016", "SC010100"."SC01037", "SC010100"."SC01038", "SC030100"."SC03057"
 FROM   "ScaCompanyDB"."dbo"."SC030100" "SC030100" INNER JOIN ("ScaCompanyDB"."dbo"."SC010100" "SC010100" INNER JOIN "ScaCompanyDB"."dbo"."ST030100" "ST030100" ON "SC010100"."SC01001"="ST030100"."ST03017") ON ("SC030100"."SC03001"="ST030100"."ST03017") AND ("SC030100"."SC03002"="ST030100"."ST03029")
 WHERE  "SC010100"."SC01037" LIKE N'1550%' AND ("SC010100"."SC01038"=N'IS' OR "SC010100"."SC01038"=N'ISFG') AND "SC030100"."SC03002"=N'01'
        And "ST030100"."ST03016" between REPLACE(CONVERT(VARCHAR(10), @StartDate, 111), '/', '-') and REPLACE(CONVERT(VARCHAR(10), @EndDate, 111), '/', '-')
        And left(ltrim(ST03011),2)<>'13'
        And "SC030100"."SC03002" = @WareHouse
 ORDER BY "ST030100"."ST03017"


end