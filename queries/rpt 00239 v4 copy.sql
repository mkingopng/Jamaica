USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00239_sel_chem_v4_copy]    Script Date: 10/04/2021 14:57:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00239_sel_chem_v4_copy] 
	@department			NVARCHAR(256),
	@supplier			NVARCHAR(20)= NULL
	--@warehouse_code			NVARCHAR(10)= NULL
	
AS	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF
	
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
SELECT @LastYear = rtrim(cast(datepart(yyyy,DATEADD(m,-12,GETDATE())) as char))
SELECT @LastYear_1 = rtrim(cast(datepart(yyyy,DATEADD(m,-24,GETDATE())) as char))
SELECT @CurrentYear = rtrim(cast(datepart(yyyy,GETDATE()) as char))
SELECT @EOL = @CurrentYear + '-' + @CurrentMonth + '-' + @CurrentDay 
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#workdata239]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#workdata239]
	
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#workdata239_2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#workdata239_2]

create table #workData239
	(
		item				 nvarchar(35),	
		description			 nvarchar(60),
		QtyLCUYTD			 numeric(20,8),
		--Warehouse			 NVARCHAR(3),
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
		OnHand120            NUMERIC(20,8)
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
		
				
SELECT @AltProdGrp = (Select AlternateProductGroup From KK_Departments Where Department = @Department)
SELECT @Singlea = (Select Singlea From KK_Departments Where Department = @Department)
SELECT @warehouse = (Select Warehouse From KK_Departments Where Department = @Department)
SELECT @Singlew = (Select Singlew From KK_Departments Where Department = @Department)
IF @supplier=''
Select @supplier=NULL
    -- Insert statements for procedure here
    
    
--SELECT *
--INTO #workData2392
--FROM ScaCompanyDB..SC070100
--WHERE rtrim(cast(datepart(yyyy,SC07002) as char)) >=@LastYear
--AND SC07001 ='01'

--SELECT 'Here'

SELECT @Command = 'INSERT INTO #workData239 '
SELECT @Command = @command + 'SELECT '
SELECT @Command = @command + 'SC01001, SC01002  + '' '' + SC01003, SC01086, SC01042, SC01044, SC01045, '
SELECT @Command = @command + 'SC01061, SC01052, SC01023, SC01123,SC01058, SC01038, 0, ''__________'', NULL,NULL,NULL,SC01060,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL '
SELECT @command = @command + 'FROM ScaCompanyDB..SC010100 '
---- changes	by supplier
--IF rtrim(@supplier) <> 'PGKAE21'
IF @supplier IS NOT NULL
SELECT @command = @command +  'WHERE SC01058   =  ''' + @supplier  +  ''' '
ELSE
SELECT @command = @command + 'WHERE SC01023 <> ''OBSOLETE'' '
--IF @warehouse_code <>'All'
--SELECT @command = @command +  'AND SC03002   =  ''' + @warehouse_code  +  ''' '

---- changes by supplier	

SELECT @command = @command + 'AND SC01023 <> ''OBSOLETE'' ' 
SELECT @command = @command + 'AND SC01023 <> ''DNR'' ' 
SELECT @command = @command + 'AND SC01123 > ''' + @EOL  +  ''' '
SELECT @command = @command + 'ORDER BY SC01001 '
--SELECT @warehouse
--SELECT @command
EXEC (@command)

UPDATE #workData239 
	SET Short = ABS(OnHand - ROL)
    WHERE ROL > ONhand

    
SELECT @command = 'UPDATE #workData239 '
SELECT @command = @command + 'SET QtyPrevYr = (SELECT (ABS(SUM(Qty))) FROM ScaCompanyDB..QtyYTD WHERE cast(datepart(yyyy,TDate) as char) = ''' + @LastYear + ''' AND TType = ''01'' AND StockCode = item Collate Database_Default AND Wh IN (''48'',''06''))'
--SELECT @command
EXEC (@command) 

SELECT @command = 'UPDATE #workData239 '
SELECT @command = @command + 'SET QtyYTD = (SELECT (ABS(SUM(Qty))) FROM ScaCompanyDB..QtyYTD WHERE cast(datepart(yyyy,TDate) as char) = ''' + @CurrentYear + ''' AND TType = ''01'' AND StockCode = item Collate Database_Default AND Wh IN (''48'',''06''))'
--SELECT @command
EXEC (@command) 

 

--SELECT @command = 'UPDATE #workData239 '
--SELECT @command = @command + 'SET QtyPrevYr_1 = (SELECT (ABS(SUM(Qty))) FROM ScaCompanyDB..QtyYTD WHERE cast(datepart(yyyy,TDate) as char) = ''' + @LastYear_1 + ''' AND TType = ''01'' AND StockCode = item Collate Database_Default)'
--SELECT @command
--EXEC (@command) 
--EXEC (@command)

UPDATE #workData239 
	SET QtyPerMonth = (QtyYtd / @CurrentMonth)
	

SELECT @Command = 'INSERT INTO #workData239_2 '
SELECT @Command = @command + 'SELECT '
SELECT @Command = @command + 'SC01001, SC03002, SC03003, SC03005, SC03006, '
SELECT @Command = @command + 'SC03010, SC03057,0, ''__________'', NULL,NULL,NULL '
SELECT @command = @command + 'FROM ScaCompanyDB..SC010100 '
SELECT @command = @command + 'INNER JOIN ScaCompanyDB..SC030100 '
SELECT @command = @command + 'ON SC01001=SC03001 ' 
--SELECT @command = @command + 'LEFT OUTER JOIN ScaCompanyDB..QtyYTD ' 
--SELECT @command = @command + 'ON (SC03001=StockCode) AND (SC03002=Wh) '
--select SC01038 from ScaCompanyDB..SC010100 WHERE SC01038 in ('IS','II')
--SELECT @command = @command +  'WHERE SC01038 IN (''RM'',''CS'') '
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
--SELECT * from #workData239_2 where item_2 = '10-01-0008'
UPDATE #workData239 
	SET WH48 = WH_2, ROL48 = ROL_2, AvgCost48 = AverageCost_2, Short48 = Short_2 , Need48 = Need_2, OnHand48 = OnHand_2
	,OnOrder48 = OnOrder_2, BackOrder48 = BackOrder_2
	from #workData239_2 
    WHERE item = item_2 and WH_2 = '48'

UPDATE #workData239 
SET WH06 = WH_2, ROL06 = ROL_2, AvgCost06 = AverageCost_2 ,Short06 = Short_2 , OnHand06 = OnHand_2,
OnOrder06 = OnOrder_2 
from #workData239_2 
WHERE item = item_2 and WH_2 = '06'  

UPDATE #workData239     
SET OnOder120 = OnOrder_2,OnHand120 = OnHand_2
from #workData239_2 
WHERE item = item_2 and WH_2 = '120'     
    
UPDATE #workData239     
	SET Short48 = ABS(OnHand48 - ROL48)
    WHERE ROL48 > ONhand48
    
 UPDATE #workData239     
	SET Short06 = ABS(OnHand06 - ROL06)
    WHERE ROL06 > ONhand06
	 





--Select * from #workData239
   	
IF @supplier IS NOT NULL
 Select * from  #workData239 where SupplierCode collate database_default IN (Select Value from dbo.Split(',',@supplier) ) order by item  	
ELSE
Select * from  #workData239 
END

