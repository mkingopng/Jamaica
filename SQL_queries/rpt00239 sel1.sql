USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00239_sel_1]    Script Date: 10/04/2021 14:47:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00239_sel_1] 
	@department			NVARCHAR(256),
	@supplier			NVARCHAR(20)= NULL
	--@warehouse_code			NVARCHAR(10)= NULL
	
AS	

SET NOCOUNT ON
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
	
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#workdata2392]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#workdata2392]

create table #workData239
	(
		item				 nvarchar(35),	
		description			 nvarchar(60),
		QtyLCUYTD			 numeric(20,8),
		Warehouse			 NVARCHAR(3),
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
		QtyPrevYr_1			 Numeric(20,8),	
		QtyYtd				 Numeric(20,8),
		SupplierStockCode	 NVARCHAR(35),
		SellingPrice         NUMERIC(20,8),
		ROL_CAL              NUMERIC(20,8),
		Short_CAL            NUMERIC(20,8)
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
SELECT @Command = @command + 'SC01001,  SC01002  + '' '' + SC01003, SC01086, SC03002, SC03003, SC03005, SC03006, '
SELECT @Command = @command + 'SC03010, SC03057, SC01023, SC01123,SC01058, SC01038, 0, ''__________'', NULL, NULL,NULL,NULL,SC01060,SC01004,NULL,NULL '
SELECT @command = @command + 'FROM ScaCompanyDB..SC010100 '
SELECT @command = @command + 'INNER JOIN ScaCompanyDB..SC030100 '
SELECT @command = @command + 'ON SC01001=SC03001 ' 
--SELECT @command = @command + 'LEFT OUTER JOIN ScaCompanyDB..QtyYTD ' 
--SELECT @command = @command + 'ON (SC03001=StockCode) AND (SC03002=Wh) '
--select SC01038 from ScaCompanyDB..SC010100 WHERE SC01038 in ('IS','II')
IF @Singlea = 1 
	SELECT @command = @command +  'WHERE SC01038  =  ''' +  @AltProdGrp  +  ''' '
Else
	SELECT @command = @command +  'WHERE SC01038  IN ' +  @AltProdGrp + ' ' collate database_default
IF @Singlew = 1 
	SELECT @command = @command +  'AND SC03002  =  ''' +  @warehouse  +  ''' '
Else
	SELECT @command = @command +  'AND SC03002  IN ' +  @warehouse + ' ' 

---- changes	by supplier
--IF rtrim(@supplier) <> 'PGKAE21'
IF @supplier IS NOT NULL
SELECT @command = @command +  'AND SC01058   =  ''' + @supplier  +  ''' '


--IF @warehouse_code <>'All'
--SELECT @command = @command +  'AND SC03002   =  ''' + @warehouse_code  +  ''' '

---- changes by supplier	



SELECT @command = @command + 'AND SC01023 <> ''OBSOLETE'' ' 
SELECT @command = @command + 'AND SC01023 <> ''DNR'' ' 
SELECT @command = @command + 'AND SC01123 > ''' + @EOL  +  ''' '
SELECT @command = @command + 'ORDER BY SC01001,SC03002'
--SELECT @warehouse
--SELECT @command
EXEC (@command)
--SELECT * from #workData239 
UPDATE #workData239 
	SET Short = ABS(OnHand - ROL)
    WHERE ROL > ONhand
    


SELECT @command = 'UPDATE #workData239 '
SELECT @command = @command + 'SET QtyPrevYr = (SELECT (ABS(SUM(Qty))) FROM ScaCompanyDB..QtyYTD WHERE cast(datepart(yyyy,TDate) as char) = ''' + @LastYear + ''' AND TType = ''01'' AND StockCode = item Collate Database_Default AND Wh = warehouse Collate database_default)'
EXEC (@command)
SELECT @command = 'UPDATE #workData239 '
SELECT @command = @command + 'SET QtyPrevYr_1 = (SELECT (ABS(SUM(Qty))) FROM ScaCompanyDB..QtyYTD WHERE cast(datepart(yyyy,TDate) as char) = ''' + @LastYear_1 + ''' AND TType = ''01'' AND StockCode = item Collate Database_Default AND Wh = warehouse Collate database_default)'
--SELECT @command
EXEC (@command) 


	
SELECT @command = 'UPDATE #workData239 '
SELECT @command = @command + 'SET QtyYtd = (SELECT ABS(SUM(Qty)) FROM ScaCompanyDB..QtyYTD WHERE cast(datepart(yyyy,TDate) as char) = ''' + @CurrentYear + ''' AND TType = ''01'' AND StockCode = item Collate Database_Default AND Wh = warehouse Collate database_default)'
--SELECT @command
EXEC (@command)

UPDATE #workData239 
	SET QtyPerMonth = (QtyYtd / @CurrentMonth)
	
UPDATE #workData239 
	SET ROL_CAL = QtyPerMonth/5
	
UPDATE #workData239 
	SET Short_CAL = (ROL_CAL - OnHand) + (BackOrder - OnOrder)


   	
SELECT a.*, b.SC23002 as Warehouse_Name FROM #workData239 a
inner join ScaCompanyDB..SC230100 b
on b.SC23001=a.Warehouse collate database_default
--and a.SupplierCode= ltrim(@supplier) collate database_default 
--and a.SupplierCode collate database_default IN (Select Value from dbo.Split(',',@supplier) )
where a.QtyYtd > a.ROL
order by a.item, a.Warehouse
END





