USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00328_sel]    Script Date: 10/05/2021 11:47:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00328_sel]
       @Supplier						NVARCHAR(20),
	   @AlternateProductGroup			NVARCHAR(20),
	   @Acct_Code						NVARCHAR(20)
       
	-- Add the parameters for the stored procedure here
	--@stockcode NVARCHAR(35)
AS
BEGIN
	SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF
	
DECLARE @command as NVARCHAR(4000)
		--,@warehouse as NVARCHAR(256)
		--,@Singlew as NVARCHAR(256)
		--,@AltProdGrp as NVARCHAR(256)
		--,@Singlea as bit
		--,@CurrentDay as NVARCHAR(2)
		--,@CurrentMonth as NVARCHAR(2)
		--,@CurrentYear as NVARCHAR (4)
		--,@LastYear as NVARCHAR (4)
		--,@EOL as NVARCHAR (10)
		 
		
--SELECT @CurrentDay =  rtrim(substring(cast(cast(datepart(dd,GETDATE()) as INT)+100 as char),2,2)) 		
--SELECT @CurrentMonth =  rtrim(substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2)) 
--SELECT @LastYear = rtrim(cast(datepart(yyyy,DATEADD(m,-12,GETDATE())) as char))
--SELECT @CurrentYear = rtrim(cast(datepart(yyyy,GETDATE()) as char))
--SELECT @EOL = @CurrentYear + '-' + @CurrentMonth + '-' + @CurrentDay 
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#workdata328]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#workdata328]
	
create table #workdata328
	(
		item				 nvarchar(35),	
		description			 nvarchar(60),
		AltProdGrp			 NVARCHAR(4),
		SupplierCode		 NVARCHAR(10),
		OnHand				 NUMERIC(20,8),
		Qty					 numeric(20,8),
		PriceLCU			 NUMERIC(20,8),
		NetValue			 NUMERIC(20,8),
		CostValue			 NUMERIC(20,8),
		AcctCode 			 NVARCHAR(20)
		)		
		
				
--SELECT @AltProdGrp = (Select AlternateProductGroup From KK_Departments Where Department = @Department)
--SELECT @Singlea = (Select Singlea From KK_Departments Where Department = @Department)
--SELECT @warehouse = (Select Warehouse From KK_Departments Where Department = @Department)
--SELECT @Singlew = (Select Singlew From KK_Departments Where Department = @Department)
IF @supplier='' Or @supplier='NULL'
Select @supplier=NULL
IF @AlternateProductGroup='' Or @AlternateProductGroup='NULL' 
Select @AlternateProductGroup=NULL
IF @Acct_Code='*ALL*' Or @Acct_Code='NULL'
Select @Acct_Code=NULL
    -- Insert statements for procedure here
    
    
--SELECT *
--INTO #workdata3282
--FROM ScaCompanyDB..SC070100
--WHERE rtrim(cast(datepart(yyyy,SC07002) as char)) >=@LastYear
--AND SC07001 ='01'

--SELECT 'Here'

SELECT @Command = 'INSERT INTO #workdata328 '
SELECT @Command = @command + 'SELECT '
SELECT @Command = @command + 'SC01001,  SC01002  + '' '' + SC01003, SC01038, SC01058, SC01042, SUM(ST03020), ST03021, '
SELECT @Command = @command + 'SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)), SUM(ST03020 * ST03023), ST03011 '
SELECT @command = @command + 'FROM ScaCompanyDB..ST030100 '
SELECT @command = @command + 'INNER JOIN ScaCompanyDB..SC010100 '
SELECT @command = @command + 'ON ST03017 = SC01001 ' 
--SELECT @command = @command + 'LEFT OUTER JOIN ScaCompanyDB..QtyYTD ' 
--SELECT @command = @command + 'ON (SC03001=StockCode) AND (SC03002=Wh) '
--select SC01038 from ScaCompanyDB..SC010100 WHERE SC01038 in ('IS','II')
--IF @Singlea = 1 
IF @AlternateProductGroup IS NOT NULL
	SELECT @command = @command +  'WHERE SC01038  =  ''' +  @AlternateProductGroup  +  ''' '
Else
	SELECT @command = @command +  'WHERE ISNUMERIC(SC01038)<>''1''  '
--IF @Singlew = 1 
--	SELECT @command = @command +  'AND SC03002  =  ''' +  @warehouse  +  ''' '
--Else
--	SELECT @command = @command +  'AND SC03002  IN ' +  @warehouse + ' ' 

---- changes	by supplier
--IF rtrim(@supplier) <> 'PGKAE21'
IF @supplier IS NOT NULL
SELECT @command = @command +  'AND SC01058   =  ''' + @supplier  +  ''' '

IF @Acct_Code IS NOT NULL
SELECT @command = @command +  'AND Ltrim(UPPER(SUBSTRING(ST03011,13,6)))   =  ''' + @Acct_Code  +  ''' '
--IF @warehouse_code <>'All'
--SELECT @command = @command +  'AND SC03002   =  ''' + @warehouse_code  +  ''' '

---- changes by supplier	

--SELECT @command = @command + 'AND SC01023 <> ''OBSOLETE'' ' 
--SELECT @command = @command + 'AND SC01023 <> ''DNR'' ' 
--SELECT @command = @command + 'AND SC01123 < ''' + @EOL  +  ''' '
SELECT @command = @command + 'Group BY SC01001,SC01002,SC01003, SC01038, SC01058, SC01042,ST03020, ST03021, ST03022,ST03023, ST03011'
--SELECT @warehouse
--SELECT @command
EXEC (@command)
--select @command
Select * from #workdata328 order by item
ENd
