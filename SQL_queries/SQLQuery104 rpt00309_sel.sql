USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00309_sel]    Script Date: 10/05/2021 11:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 7/7/2010
-- Description:	Sales statistics by day for a given and previous month -  RPT00309
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00309_sel]
	-- Add the parameters for the stored procedure here
	@Department	 as NVARCHAR(256) = NULL,
	@SelectedMonth AS DATETIME = NULL
AS
DECLARE @command as NVARCHAR(2048),
	@CostCentre as NVARCHAR(256),
	@Single as bit,
	@CurrentDate as Datetime,
	@LastMonth as Datetime,
	@ThisMonth as NVARCHAR(7),
	@PreviousMonth as NVARCHAR(7),
	@loopcount as integer,
	@recordcount as integer,
	@Filename as Datetime,
	@output1  as NVARCHAR(256),	
	@output2 as NVARCHAR(256),
	@w1 as NUMERIC(20,8),
	@w2 as NUMERIC(20,8),
	@Cmtd as NUMERIC(20,8),
	@Pmtd as NUMERIC(20,8)
	
	
	
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[##work309]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[##work309]	
	
SELECT @FileName = GETDATE()
SELECT @output1 = '##KK' + Replace(REPLACE(REPLACE(REPLACE(@Filename,'-',''),' ',''),':',''),'.','') + 'a'
SELECT @output2 = '##KK' + Replace(REPLACE(REPLACE(REPLACE(@Filename,'-',''),' ',''),':',''),'.','') + 'b'


IF @Department IS NOT NULL
	BEGIN
		SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
		SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
	END

IF @Department = 'ALL Departments'
	SELECT @Department = NULL
	

IF @SelectedMonth IS NULL
		BEGIN	
			SELECT @currentdate = GetDate()
			SELECT @lastmonth = DATEADD(M,-1,GETDATE())
		END
	ELSE
		BEGIN
			SELECT @currentdate = @selectedmonth
			SELECT @lastmonth = DATEADD(M,-1,@selectedmonth)	
		End

	
 SELECT @ThisMonth =  rtrim(cast(datepart(yyyy,@currentDate) as char))+ 'M' + substring(cast(cast(datepart(mm,@currentdate) as INT)+100 as char),2,2) 	
 SELECT @PreviousMonth = rtrim(cast(datepart(yyyy,@lastmonth) as char))+ 'M' + substring(cast(cast(datepart(mm,@lastmonth) as INT)+100 as char),2,2) 	

 SELECT @command = 'Create Table ' +  @output1 + ' '
 SELECT @command = @command + '( '
 SELECT @command = @command + 'Id1 INTEGER IDENTITY(1,1) NOT NULL, '
 SELECT @command = @command + 'Date1 DateTime, '
 SELECT @command = @command + 'DayName1 NVARCHAR(16), '
 SELECT @command = @command + 'NetValue1  NUMERIC(20,8), '
 SELECT @command = @command + 'InvoiceCount1  INTEGER, '
 SELECT @command = @command + 'Department1  NVARCHAR(256), '
 SELECT @command = @command + 'CostCentre1  CHAR(2) '
 SELECT @command = @command + ' CONSTRAINT [PK_aaaaa] PRIMARY KEY CLUSTERED ( Id1 ASC )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] '
 SELECT @command = @command + ') ON [PRIMARY]'
 --SELECT @command
 EXEC (@command)
 
 SELECT @command = 'Create Table ' +  @output2 + ' '
 SELECT @command = @command + '( '
 SELECT @command = @command + 'Id2 INTEGER IDENTITY(1,1) NOT NULL, '
 SELECT @command = @command + 'Date2 DateTime, '
 SELECT @command = @command + 'DayName2 NVARCHAR(16), '
 SELECT @command = @command + 'NetValue2  NUMERIC(20,8), '
 SELECT @command = @command + 'InvoiceCount2  INTEGER '
 SELECT @command = @command + ' CONSTRAINT [PK_bbbb] PRIMARY KEY CLUSTERED ( Id2 ASC )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] '
 SELECT @command = @command + ') ON [PRIMARY]'
 --SELECT @command
 EXEC (@command)
 
 SELECT @command = 'Create Table ##work309 ' 
 SELECT @command = @command + '( '
 SELECT @command = @command + 'Id4 INTEGER IDENTITY(1,1) NOT NULL, '
	SELECT @command = @command + 'CDate DATETIME, '
	SELECT @command = @command + 'CDayName NVARCHAR(16), '
	SELECT @command = @command + 'CNetValue NUMERIC(20,8), '
	SELECT @command = @command + 'CMTD  NUMERIC(20,8), '
	SELECT @command = @command + 'CInvoiceCount  Integer, '
	SELECT @command = @command + 'Department  NVARCHAR(256), '
	SELECT @command = @command + 'CostCentre CHAR(2), '
	SELECT @command = @command + 'PDate DATETIME, '
	SELECT @command = @command + 'PDayName NVARCHAR(16), '
	SELECT @command = @command + 'PNetValue NUMERIC(20,8), '
	SELECT @command = @command + 'PMTD NUMERIC(20,8), '
	SELECT @command = @command + 'PInvoiceCount  INTEGER, '
	SELECT @command = @command + 'BudgetValue  NUMERIC(20,8) '	
	SELECT @command = @command + ' CONSTRAINT [PK_ccc] PRIMARY KEY CLUSTERED ( Id4 ASC )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] '
	SELECT @command = @command + ') ON [PRIMARY]'
EXEC (@command)
 		
SELECT @command = 'INSERT  INTO ' + @output1 + ' '
SELECT @command = @command + 'SELECT ST03015, '
SELECT @command = @command + '(SELECT dbo.udf_DayOfWeek(ST03015)), '
SELECT @command = @command + 'SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)),'
SELECT @command = @command + 'COUNT(DISTINCT(ST03009)), '
IF  @Department IS NOT NULL
	BEGIN
		SELECT @command = @command + ' ''' + @Department + ''', '
		SELECT @command = @command + 'SUBSTRING(ST03011,7,2) '
	END
ELSE
	SELECT @command = @command + 'NULL, NULL '
SELECT @command = @command + 'FROM [ScaCompanyDB]..ST030100 '   
--SELECT @command = @command +  'WHERE ((rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @ThisMonth  + ''') OR (rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @PreviousMonth  + '''))'
SELECT @command = @command +  'WHERE  ST03009 <> ''0001032605'' AND ST03009 <> ''0001032607'' AND ST03009 <> ''0000767617'' AND rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @ThisMonth  + ''' '
IF  @Department IS NOT NULL
	BEGIN
		IF @Single = 1 
			SELECT @command = @command +  'AND SUBSTRING(ST03011,7,2)  =  ' +  @costcentre  +  ' '
		Else
			SELECT @command = @command +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
	END
SELECT @command = @command + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @command = @command + 'AND NOT SUBSTRING(ST03011,13,6) = ''AIXFRU'' '
SELECT @command = @command + 'AND NOT SUBSTRING(ST03011,13,6) = ''RAWMAT'' '
SELECT @command = @command + 'AND NOT SUBSTRING(ST03011,13,6) = ''AIXPAL'' '
IF  @Department IS NULL
	SELECT @command = @command + ' GROUP BY    ST03015'
ELSE
	SELECT @command = @command + ' GROUP BY ST03015, SUBSTRING(ST03011,7,2)'
SELECT @command = @command + ' ORDER BY ST03015 ASC'
--SELECT @command
EXEC (@command)

SELECT @command = 'INSERT  INTO ' + @output2 + ' '
SELECT @command = @command + 'SELECT ST03015, '
SELECT @command = @command + '(SELECT dbo.udf_DayOfWeek(ST03015)), '
SELECT @command = @command + 'SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)),'
SELECT @command = @command + 'COUNT(DISTINCT(ST03009)) '
SELECT @command = @command + 'FROM [ScaCompanyDB]..ST030100 '   
SELECT @command = @command +  'WHERE ST03009 <> ''0001032605'' AND ST03009 <> ''0001032607'' AND rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @PreviousMonth  + ''' '
IF  @Department IS NOT NULL
	BEGIN
		IF @Single = 1 
			SELECT @command = @command +  'AND SUBSTRING(ST03011,7,2)  =  ' +  @costcentre  +  ' '
		Else
			SELECT @command = @command +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
END
SELECT @command = @command + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @command = @command + 'AND NOT SUBSTRING(ST03011,13,6) = ''AIXFRU'' '
SELECT @command = @command + 'AND NOT SUBSTRING(ST03011,13,6) = ''RAWMAT'' '
SELECT @command = @command + 'AND NOT SUBSTRING(ST03011,13,6) = ''AIXPAL'' '
SELECT @command = @command + ' GROUP BY    ST03015'
SELECT @command = @command + ' ORDER BY ST03015 ASC'
--SELECT @command
EXEC (@command)

--SELECT @command = 'Select * from ' + @output1 + ' '
--SELECT @command
--EXEC (@command)

--SELECT @command = 'Select * from ' + @output2 + ' '
--SELECT @command
--EXEC (@command)

SELECT @command = 'INSERT INTO ##work309 '
SELECT @command = @command + 'SELECT '
SELECT @command = @command + 'Date1 , '
SELECT @command = @command + 'DayName1 , '
SELECT @command = @command + 'NetValue1 , '
SELECT @command = @command + '0.00 , '
SELECT @command = @command + 'InvoiceCount1 , '
SELECT @command = @command + 'Department1 , '
SELECT @command = @command + 'CostCentre1 , '
SELECT @command = @command + 'Date2 , '
SELECT @command = @command + 'DayName2 , '
SELECT @command = @command + 'NetValue2 , '
SELECT @command = @command + '0.00 , '
SELECT @command = @command + 'InvoiceCount2 ,  '
SELECT @command = @command + 'NULL   '
SELECT @command = @command + 'FROM ' + @output1 + ' '
SELECT @command = @command + 'FULL JOIN   ' + @output2 + ' '
SELECT @command = @command + 'ON id1 = id2 '
--SELECT @command
EXEC (@command)

SET @recordcount = (SELECT COUNT(*) From ##work309) 
set @loopcount= 1
SELECT @Cmtd = 0
SELECT @Pmtd = 0

-- calculate cumulative percentage by processing in descending sequence adding up percentage below the current line
while @loopcount <= @recordcount
BEGIN
		SELECT @w1 = (SELECT CNetvalue FROM ##work309  WHERE Id4 = @loopcount)
		SELECT @w2 = (SELECT PNetvalue FROM ##work309  WHERE Id4 = @loopcount)
		SELECT @Cmtd = @cmtd + @w1
		SELECT @Pmtd = @pmtd + + @w2
		UPDATE ##work309
			SET CMTD = @Cmtd, PMTD=  @Pmtd
					WHERE Id4 = @loopcount				
		SELECT @loopcount = @loopcount + 1
END		

SELECT @command = 'Update ##work309 '
SELECT @command = @command + 'SET BudgetValue = (SELECT SUM(BudgetSalesValue) '
SELECT @command = @command + 'From  [t_kpi_sales_' + LTRIM(STR(YEAR(@currentdate))) + '] '
SELECT @command = @command + 'WHERE Period = ' + LTRIM(STR(Month(@CurrentDate))) + ' '
IF  @Department IS NOT NULL
	BEGIN
		IF @Single = 1 
			SELECT @command = @command +  'AND CostCentre  =  ' +  @costcentre  +  ') '
		Else
			SELECT @command = @command +  'AND CostCentre  IN '' +  @costcentre + '') '			
	END
ELSE
	SELECT @command = @command + 'AND CostCentre < ''89'') '
--SELECT @command 
EXEC (@command)

SELECT * FROM ##work309 

SELECT @command = 'drop table ' + @output1 + ' '
EXEC (@command)

SELECT @command = 'drop table ' + @output2 + ' '
EXEC (@command)

drop table  ##work309



