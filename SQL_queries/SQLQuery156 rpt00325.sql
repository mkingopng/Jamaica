USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00326_sel]    Script Date: 10/05/2021 11:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00326_sel]
	-- Add the parameters for the stored procedure here
	@startDate DateTime = NULL,
	@endDate Datetime = NULL,
	@selection VARCHAR(50)
	
AS

DECLARE @c as NVARCHAR(4000),
		@rundate as NVARCHAR(7),
		@daterange as CHAR(1)
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
If (@startdate is NULL OR @endDate is NULL) 
	BEGIN
		SELECT @endDate = NULL
		Select @startDate = NULL
		SELECT @rundate = cast(datepart(yyyy,GETDATE()) as CHAR(4)) + 'M' + substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2)
		--SELECT @rundate
		SELECT @daterange = 0
	END
ELSE	
	SELECT @daterange =1
	

		
SELECT @c = 'SELECT ' 
SELECT @c = @c + 'SM03006 "Technician", '
SELECT @c = @c + 'HR01002 "Name", '
SELECT @c = @c + 'SM03036 "Date", '
SELECT @c = @c + 'SM01008 "Task", '
SELECT @c = @c + 'SM03001 "ServiceOrder#", '
SELECT @c = @c + 'SM01002 "CusCode", '
SELECT @c = @c + 'SL01002 "Customer", '
If @selection = '0'
	BEGIN
	 SELECT @c = @c + 'SUM(Case When SM03004 = ''01'' Then SM03008 END)"Regular", '  
		 SELECT @c = @c + 'SUM(Case When SM03004 = ''02'' Then SM03008 END)"Overtime", ' 
		 SELECT @c = @c + 'SUM(Case When SM03004 = ''03'' Then SM03008 END)"DoubleTime",'  
		 SELECT @c = @c + 'SUM(Case When SM03004 = ''04'' Then SM03008 END)"Non Billable"' 
	END 
ELSE
BEGIN		 
		SELECT @c = @c + 'SUM(Case When SM03004 = ''01'' Then SM03028 END)"Regular", ' 
	SELECT @c = @c + 'SUM(Case When SM03004 = ''02'' Then SM03028 END)"Overtime", ' 
	SELECT @c = @c + 'SUM(Case When SM03004 = ''03'' Then SM03028 END) "DoubleTime", '  
 SELECT @c = @c + 'SUM(Case When SM03004 = ''04'' Then SM03028 END)"Non Billable" '  
		END
SELECT @c = @c + 'FROM   [ScaCompanyDB]..SM030100 '  
SELECT @c = @c + 'INNER JOIN   [ScaCompanyDB]..SM010100 '
SELECT @c = @c + 'ON SM01001 = SM03001 '  
SELECT @c = @c + 'INNER JOIN   [ScaCompanyDB]..SL010100 '
SELECT @c = @c + 'ON SL01001 = SM01003 '  
SELECT @c = @c + 'INNER JOIN   [ScaCompanyDB]..HR010100 '
SELECT @c = @c + 'ON SM03006 = HR01001 '  
IF @daterange = 1
	   SELECT @c = @c + 'WHERE SM03036 BETWEEN ''' + convert(nvarchar(20), @StartDate) +  ''' And ''' + convert(nvarchar(20), + @endDate) + ''' ' 
ELSE
	   SELECT @c = @c + 'WHERE rtrim(cast(datepart(yyyy,SM03036) as char))  + ''M'' + substring(cast(cast(datepart(mm,SM03036) as INT)+100 as char),2,2) = ''' + @rundate + '''  ' 
SELECT @c = @c + 'GROUP BY SM03006,HR01002,SM03001,SM01008,SM03036,SM01002,SL01002 '
--SELECT @c
EXEC (@c)
END
