USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00300_FP]    Script Date: 10/05/2021 11:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00300_FP]
	-- Add the parameters for the stored procedure here
	--	@department			NVARCHAR(256) 
		@StartDate as Datetime=NULL,
	    @EndDate as Datetime=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
		SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF
DECLARE @DateSelected as BIT
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
--select @warehouse
create table #workData15032010
	(
		StockCode			nvarchar(35),
		Description			nvarchar(60),
		ROL					NUMERIC(20,4),
		Production		    NUMERIC(20,4),
		Delivery	        NUMERIC(20,2),
		CurrentStock	    NUMERIC(20,2),
		DateRange			nvarchar(50)
	)
--SELECT CONVERT(VARCHAR(10), GETDATE())
--SELECT REPLACE(CONVERT(VARCHAR(10), GETDATE(), 102),'.','-') AS TDate
--Select @Sdate = (SELECT REPLACE(CONVERT(VARCHAR(10), @StartDate, 102),'.','-'))
--Select @Edate = (SELECT REPLACE(CONVERT(VARCHAR(10), @EndDate, 102),'.','-'))
--SELECT @CurrentMonth =  rtrim(substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2)) 
--SELECT @CurrentYear = rtrim(cast(datepart(yyyy,GETDATE()) as char))
--select @FirstDayoftheMonth = @CurrentYear + '-' + @CurrentMonth + '-' + '01'
--select @LastDayoftheMonth = dateadd(d,-1,dateadd(mm,1, @CurrentYear + @CurrentMonth + '01'))
--select @LastDayoftheMonth=(SELECT REPLACE(CONVERT(VARCHAR(10), cast(@LastDayoftheMonth as Datetime), 102),'.','-'))

--select dateadd(d,-1,dateadd(mm,1, @CurrentYear + @CurrentMonth + '01'))
--select dateadd(d,-1,dateadd(mm,1, CAST(Getdate() as char)))
--select dateadd(mm,1, CAST(Getdate() as char))
--SELECT @LastYear = rtrim(cast(datepart(yyyy,DATEADD(m,-12,GETDATE())) as char))
--SELECT @MonthValue =  datepart(MM,GETDATE()) 
--SELECT @YearValue =  datepart(YY,GETDATE()) 
--SELECT @warehouse = (Select Warehouse From KK_Departments Where Department = @department)
--SELECT @Singlew = (Select Singlew From KK_Departments Where Department = @Department)

SELECT @Command = 'INSERT INTO #workData15032010 '
SELECT @Command = @command + 'SELECT '
SELECT @Command = @command + 'SC03001,  SC01002  + '' '' + SC01003,SC03010,NULL,NULL,SC03003, ''' + @DateRange + ''' '
SELECT @command = @command + 'FROM ScaCompanyDB..SC010100 '
SELECT @command = @command + 'INNER JOIN ScaCompanyDB..SC030100 '
SELECT @command = @command + 'ON SC01001=SC03001 ' 
--IF @Singlew = 1 
--	SELECT @command = @command +  'WHERE WarehouseCode  =  ''' +  @warehouse  +  ''' '
--Else
SELECT @command = @command +  'WHERE SC03002 = ''05'' '
SELECT @command = @command + 'AND (SC03001>=''12-01-0000'' AND SC03001<=''13-01-0000'')'
EXEC (@command)

SELECT @command = 'UPDATE #workData15032010 '

--SELECT @command = @command + 'SET Usage = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''01'' AND SC07002 BETWEEN ''2010-01-31'' AND ''2010-03-01'')'
--if (@Sdate is NULL)
--SELECT @command = @command + 'SET Usage = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''01'' AND SC07002 BETWEEN ''' + @FirstDayoftheMonth  + ''' and ''' + @LastDayoftheMonth + ''')'
--else
--SELECT @command = @command + 'SET Usage = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''01'' AND SC07002 BETWEEN ''' + @Sdate  + ''' and ''' + @Edate + ''')'
IF @DateSelected = 1
	SELECT @command = @command + 'SET Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND SC07002 BETWEEN ''' + convert(nvarchar(20), @StartDate) + ''' AND ''' + convert(nvarchar(20), @EndDate) + ''')'
ELSE
SELECT @command = @command + 'SET Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''' + @ThisMonth  + ''') '
EXEC (@command)

SELECT @command = 'UPDATE #workData15032010 '
IF @DateSelected = 1
	SELECT @command = @command + 'SET Delivery = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''01'' AND SC07002 BETWEEN ''' + convert(nvarchar(20), @StartDate) + ''' AND ''' + convert(nvarchar(20), @EndDate) + ''')'
ELSE
SELECT @command = @command + 'SET Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''' + @ThisMonth  + ''') '
EXEC (@command)

select distinct * from #workData15032010


end
