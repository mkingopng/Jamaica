USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00239_sel_2]    Script Date: 10/04/2021 14:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================================
-- Author:		<Isaac Kababa>
-- Create date: <18/03/2015>
-- Description:	<Extract Raw Materials Stock Balances By Factory>
-- ============================================================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00239_sel_2] 
--DECLARE
	@department			NVARCHAR(256),
	@supplier			NVARCHAR(20)= NULL
	--@warehouse_code			NVARCHAR(10)= NULL
	
AS	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF
	SET ARITHABORT OFF 
--SET ANSI_WARNINGS OFF
	
DECLARE @command as NVARCHAR(4000)
		,@warehouse as NVARCHAR(256)
		,@Singlew as NVARCHAR(256)
		,@AltProdGrp as NVARCHAR(256)
		,@Singlea as bit
		,@CurrentDay as NVARCHAR(2)
		,@CurrentMonth as NVARCHAR(2)
		,@CurrentYear as NVARCHAR (4)
		,@LastYear as NVARCHAR (4)
		,@LastYear_1 as NVARCHAR (4)
		,@EOL as NVARCHAR (10)
		SELECT @CurrentDay =  rtrim(substring(cast(cast(datepart(dd,GETDATE()) as INT)+100 as char),2,2)) 		
		SELECT @CurrentMonth =  rtrim(substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2)) 
		SELECT @CurrentYear = rtrim(cast(datepart(yyyy,GETDATE()) as char))
		SELECT @EOL = @CurrentYear + '-' + @CurrentMonth + '-' + @CurrentDay 

		DECLARE @rundate as datetime
		DECLARE @sixmonthsago as datetime
		
		SELECT @rundate = (SELECT DATEADD(d, 0, DATEDIFF(d, 0, GETDATE())) )
		SELECT @sixmonthsago = (SELECT DATEADD(m,-6,@Rundate))


IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#workdata239]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#workdata239]
	
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#workdata239_2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#workdata239_2]

create table #workData239
	(
		item				 nvarchar(35),	
		description			 nvarchar(60),
		QtyLCUYTD			 numeric(20,8),
		OnHand				 NUMERIC(20,8),
		BackOrder			 NUMERIC(20,8),
		OnOrder			     NUMERIC(20,8),
		ROL					 NUMERIC(20,8),
		AverageCost			 Numeric(20,8),
		ExtProdGrp 			 NVARCHAR(20),
		EndofLifeDate		 DATETIME,
		SupplierCode		 NVARCHAR(10),
		AltProdGrp			 NVARCHAR(4),
		Short				 Numeric(20,8),
		Need			     Nvarchar(20),
		QtyPerMonth			 Numeric(20,8),
		QtyPrevYr			 Numeric(20,8),	
		QtyYtd				 Numeric(20,8),
		SupplierStockCode	 NVARCHAR(35),
		WH48                 NVARCHAR(2),
		ROL48                NUMERIC(20,8),
		AvgCost48	         Numeric(20,8),
		Short48				 Numeric(20,8),
		Need48				 Nvarchar(20),
		OnHand48			 NUMERIC(20,8),
		OnOrder48            NUMERIC(20,8),
		BackOrder48          NUMERIC(20,8),
		WH06				 NUMERIC(20,8),
		ROL06				 NUMERIC(20,8),
		Short06			     NUMERIC(20,8),
		AvgCost06			 NUMERIC(20,8),
		OnHand06			 NUMERIC(20,8),
		OnOrder06			 NUMERIC(20,8),
		OnOder120            NUMERIC(20,8),
		OnHand120            NUMERIC(20,8),
		OnHand45             NUMERIC(20,8),
		OnHand40             NUMERIC(20,8),
		OnHand41             NUMERIC(20,8),
		OnHand51             NUMERIC(20,8),
		OnHand60             NUMERIC(20,8),
		OnHand61             NUMERIC(20,8),
		OnHand88             NUMERIC(20,8),
		OnOrder05            NUMERIC(20,8)
		)		
		
Create table #workData239_2
	(
		item_2				 nvarchar(35),	
		WH_2			     NVARCHAR(3),
		OnHand_2			 NUMERIC(20,8),
		BackOrder_2			 NUMERIC(20,8),
		OnOrder_2		     NUMERIC(20,8),
		ROL_2				 NUMERIC(20,8),
		AverageCost_2		 Numeric(20,8),
		Short_2				 Numeric(20,8),
		Need_2			     Nvarchar(20),
		QtyPerMonth			 Numeric(20,8),
		QtyPrevYr			 Numeric(20,8),	
		QtyYtd				 Numeric(20,8),
	)		

--SET @department='Chemical Factory Lae'

			
SELECT @AltProdGrp = (Select AlternateProductGroup From KK_Departments Where Department = @Department)
SELECT @Singlea = (Select Singlea From KK_Departments Where Department = @Department)
SELECT @warehouse = (Select Warehouse From KK_Departments Where Department = @Department)
SELECT @Singlew = (Select Singlew From KK_Departments Where Department = @Department)
IF @supplier=''
Select @supplier=NULL

SELECT @Command = 'INSERT INTO #workData239 '
SELECT @Command = @command + 'SELECT '
SELECT @Command = @command + 'SC01001, SC01002  + '' '' + SC01003, SC01086, SC01042, SC01044, SC01045, '
SELECT @Command = @command + 'SC01061, SC01052, SC01023, SC01123,SC01058, SC01038, 0, ''__________'', NULL,NULL,NULL,SC01060,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL '
SELECT @command = @command + 'FROM ScaCompanyDB..SC010100 '

IF @supplier IS NOT NULL
SELECT @command = @command +  'WHERE SC01058   =  ''' + @supplier  +  ''' '
ELSE
SELECT @command = @command + 'WHERE SC01023 <> ''OBSOLETE'' '
IF @department = 'Chemical Factory Lae'
SELECT @command = @command + 'AND SC01001 BETWEEN ''10-01-0001'' AND ''10-05-0125'' 
							  OR SC01001 LIKE ''10-05%'' 
							  OR SC01001 = ''12-12-0001'' 
							  OR SC01001 = ''10-05-0509'' 
							  OR SC01001 IN (''16-03-8042'',''16-03-8108'',''16-03-8195'')  
							  OR SC01001 IN (''10-06-0204'',''10-06-0205'',''10-06-0206'',''10-06-0207'') ' 
IF @department = 'Rotomoulding'
SELECT @command = @command + 'AND SC01001 BETWEEN ''15-01-0001'' AND ''15-03-9999'' '
IF @department = 'Plastics Factory Lae'
SELECT @command = @command + 'AND SC01001 BETWEEN ''14-01-0001'' AND ''14-15-9999'' OR SC01001 LIKE ''18-10%'' '

IF @department = 'PET Factory'
SELECT @command = @command + 'AND SC01001 LIKE ''18-10%'' '

IF @department = 'Lae Oil Factory'
SELECT @command = @command + 'AND SC01001 BETWEEN ''10-05-1049'' AND ''10-05-1054'' 
                                        OR SC01001 BETWEEN ''10-06-0001'' AND ''10-06-9999''
                                        OR SC01001 BETWEEN ''12-01-9110'' AND ''12-01-9113'' '
IF @department = 'Paper'
SELECT @command = @command + 'AND SC01001 BETWEEN  ''10-11-0001'' AND ''10-15-9999''
                                        OR SC01001 BETWEEN ''64-01-0001'' AND ''64-01-9999'' '
SELECT @command = @command + 'AND SC01023 <> ''OBSOLETE'' ' 
SELECT @command = @command + 'AND SC01023 <> ''DNR'' ' 
SELECT @command = @command + 'AND SC01123 > ''' + @EOL  +  ''' '
SELECT @command = @command + 'ORDER BY SC01001 '
EXEC (@command)


--- added 08/06/2016 to address inaccuracy on average costs --- isaac
update #workData239
	set AverageCost=(SELECT SUM(SC03003 * SC03057)/(SUM(SC03003)) FROM ScaCompanyDB..SC030100 
	where SC03001=item collate database_default)

UPDATE #workData239 
	SET Short = ABS(OnHand - ROL)
    WHERE ROL > ONhand

--SELECT @command = 'UPDATE #workData239 '
--SELECT @command = @command + 'SET QtyPrevYr = (SELECT (ABS(SUM(Qty))) FROM ScaCompanyDB..QtyYTD WHERE cast(datepart(yyyy,TDate) as char) = ''' + @LastYear + ''' AND TType = ''01'' AND StockCode = item Collate Database_Default AND Wh IN (''48'',''06'',''07'',''40'',''41'',''51'',''61'',''88''))'
--EXEC (@command) 

--- added 30/08/2018 to address qty used within 6 months of current/run date --- isaac
update #workData239
	set QtyYtd = (SELECT ABS(SUM(Qty)) FROM ScaCompanyDB..QtyYTD 
	WHERE TDate BETWEEN @sixmonthsago AND @rundate 
	AND TType='01' 
	AND StockCode = item Collate Database_Default 
	AND Wh IN ('48','06','07','40','41','45','51','60','61','88'))

UPDATE #workData239 
	SET QtyPerMonth = (QtyYtd / @CurrentMonth)


SELECT @Command = 'INSERT INTO #workData239_2 '
SELECT @Command = @command + 'SELECT '
SELECT @Command = @command + 'SC01001, SC03002, SC03003, SC03005, SC03006, '
SELECT @Command = @command + 'SC03010, SC03057,0, ''__________'', NULL,NULL,NULL '
SELECT @command = @command + 'FROM ScaCompanyDB..SC010100 '
SELECT @command = @command + 'INNER JOIN ScaCompanyDB..SC030100 '
SELECT @command = @command + 'ON SC01001=SC03001 ' 
IF @Singlea = 1 
	SELECT @command = @command +  'WHERE SC01038  =  ''' +  @AltProdGrp  +  ''' '
Else
	SELECT @command = @command +  'WHERE SC01038  IN ' +  @AltProdGrp + ' ' collate database_default
IF @Singlew = 1 
	SELECT @command = @command +  'AND SC03002  = ''' + @warehouse +  ''' ' 
Else
	SELECT @command = @command +  'AND SC03002  IN ' + @warehouse + ' ' collate database_default

SELECT @command = @command + 'AND SC01023 <> ''OBSOLETE'' ' 
SELECT @command = @command + 'AND SC01023 <> ''DNR'' ' 
SELECT @command = @command + 'AND SC01123 > ''' + @EOL  +  ''' '
SELECT @command = @command + 'ORDER BY SC01001, SC03002'
EXEC (@command) 

UPDATE #workData239 
SET WH48 = WH_2, ROL48 = ROL_2, AvgCost48 = AverageCost_2, Short48 = Short_2 , Need48 = Need_2, OnHand48 = OnHand_2
,OnOrder48 = OnOrder_2, BackOrder48 = BackOrder_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '48'

UPDATE #workData239 
SET OnHand48 = 0
from #workData239_2 
WHERE OnHand48 IS NULL

UPDATE #workData239 
SET WH06 = WH_2, ROL06 = ROL_2, AvgCost06 = AverageCost_2 ,Short06 = Short_2 , OnHand06 = OnHand_2,
OnOrder06 = OnOrder_2 
from #workData239_2 
WHERE item = item_2 and WH_2 = '06'  

UPDATE #workData239 
SET OnHand06 = 0
from #workData239_2 
WHERE OnHand06 IS NULL

UPDATE #workData239     
SET OnOder120 = OnOrder_2,OnHand120 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '120'     

UPDATE #workData239     
SET OnOrder05 = OnOrder_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '05'     


UPDATE #workData239 
SET OnHand120 = 0
from #workData239_2 
WHERE OnHand120 IS NULL
    
UPDATE #workData239     
	SET Short48 = ABS(OnHand48 - ROL48)
    WHERE ROL48 > ONhand48
    
 UPDATE #workData239     
	SET Short06 = ABS(OnHand06 - ROL06)
    WHERE ROL06 > ONhand06
	 
UPDATE #workData239 
SET OnHand45 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '45'  

UPDATE #workData239 
SET OnHand45 = 0
from #workData239_2 
WHERE OnHand45 IS NULL

UPDATE #workData239 
SET OnHand88 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '88'  

UPDATE #workData239 
SET OnHand88 = 0
from #workData239_2 
WHERE OnHand88 IS NULL

UPDATE #workData239 
SET OnHand51 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '51'  

UPDATE #workData239 
SET OnHand51 = 0
from #workData239_2 
WHERE OnHand51 IS NULL

UPDATE #workData239 
SET OnHand40 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '40'  

UPDATE #workData239 
SET OnHand40 = 0
from #workData239_2 
WHERE OnHand40 IS NULL

UPDATE #workData239 
SET OnHand41 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '41'  

UPDATE #workData239 
SET OnHand41 = 0
from #workData239_2 
WHERE OnHand41 IS NULL

UPDATE #workData239 
SET OnHand61 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '61'  

UPDATE #workData239 
SET OnHand61 = 0
from #workData239_2 
WHERE OnHand61 IS NULL

UPDATE #workData239 
SET OnHand60 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '60'  

UPDATE #workData239 
SET OnHand60 = 0
from #workData239_2 
WHERE OnHand60 IS NULL

IF @supplier IS NOT NULL
 Select * from  #workData239 where SupplierCode collate database_default IN (Select Value from dbo.Split(',',@supplier) ) order by item  	
ELSE
Select * from  #workData239 
END