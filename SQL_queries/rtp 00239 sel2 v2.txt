USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00239_sel_2_v2]    Script Date: 10/04/2021 14:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================================
-- Author:		<Isaac Kababa>
-- Create date: <18/03/2015>
-- Description:	<Extract Raw Materials Stock Balances By Factory>
-- ============================================================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00239_sel_2_v2] 
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
		OnHand61             NUMERIC(20,8),
		OnHand88             NUMERIC(20,8),
		OnOrder05            NUMERIC(20,8),
		QtyMnth				 NUMERIC(20,8)
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
		QtyMnth				 Numeric(20,8)
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
							  OR SC01001 LIKE ''10-05%'' OR SC01001 = ''12-12-0001'' 
							  OR SC01001 IN (''16-03-8042'',''16-03-8108'',''16-03-8195'')  
							  OR SC01001 IN (''10-05-0509'',''10-06-0204'',''10-06-0205'',''10-06-0206'',''10-06-0207'') ' 
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
	AND Wh IN ('48','06','07','40','41','45','51','61','88'))

UPDATE #workData239 
	SET QtyPerMonth = (QtyYtd / @CurrentMonth)
	
create table #monthlytarget
(
  m_stockcode nvarch(35),
  m_qty numeric (28,2)
)	

insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0001','3000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0002','300')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0003','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0006','15')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0007','250')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0008','900')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0010','25')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0011','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0012','74')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0013','10')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0015','900')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0017','500')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0018','600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0019','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0020','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0022','1000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0023','14')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0025','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0026','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0027','2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0028','9')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0031','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0039','50')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0052','300')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0054','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0057','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0058','21')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0059','300')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0063','30')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0064','4')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0065','24')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0066','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0067','12')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0068','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0069','10')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0070','0.0064')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0071','0.08415')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0073','50')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0074','35')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0078','4000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0079','25')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0081','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0082','450')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0086','0.095')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0088','32')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0089','53')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0090','220')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0093','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0094','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0098','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0100','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0103','50')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0104','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0106','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0107','250')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0108','300')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0110','70')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0113','66000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0115','30')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0116','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0117','24')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0118','120')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0120','280')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0121','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0133','3')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0136','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0157','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-01-0900','25000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0001','15000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0002','450')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0003','4500')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0004','600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0005','45')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0006','410')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0007','620')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0008','300')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0011','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0012','0.325')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0013','35')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0014','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0017','10')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0018','900')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0019','90')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0020','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0021','4000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0022','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0023','12')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0025','125')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0026','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0035','2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0036','16')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0037','2200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0050','50')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0054','6')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0055','25')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0057','2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0058','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0059','70')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0063','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0064','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0066','2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0068','450')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0069','70')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0076','5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0077','45')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0080','5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0081','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0085','60')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0091','25000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0097','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0098','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0101','120')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-02-0103','10')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0001','0.1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0002','0.15')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0003','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0004','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0005','0.06')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0008','10')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0013','2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0021','2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0030','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0034','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0035','0.1373')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0039','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0040','0.203')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0042','3')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0044','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0050','0.06')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0055','70')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0057','5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0058','25')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0061','3')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0062','3')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0064','2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-03-0065','2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0001','0.2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0003','0.5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0006','0.5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0007','0.5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0008','0.5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0009','0.2')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0010','0.5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0013','0.5')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0015','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0019','0.1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0021','0.1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0022','0.1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0026','70')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-04-0028','0.1')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0001','500')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0016','576')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0017','1024')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0018','768')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0020','576')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0021','768')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0022','432')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0023','768')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0024','576')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0028','600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0029','600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0034','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0039','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0040','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0041','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0042','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0046','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0047','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0048','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0049','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0050','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0052','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0053','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0054','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0055','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0056','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0059','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0060','3600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0061','3600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0070','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0071','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0078','600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0079','600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0080','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0081','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0085','800')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0086','800')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0095','1200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0096','1200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0098','20')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0100','50')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0101','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0102','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0108','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0168','20000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0170','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0171','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0172','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0173','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0174','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0175','700')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0178','0')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0180','1000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0188','800')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0189','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0190','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0191','600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0192','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0193','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0194','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0196','400')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0221','345600')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0226','254016')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0228','92160')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0229','17280')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0268','25920')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0269','18144')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0270','25920')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0271','18144')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0283','51840')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0286','36288')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0291','51840')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0293','36288')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0295','23040')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0296','23040')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0392','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0395','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0396','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0423','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0425','250')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0428','250')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0433','150')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0435','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0438','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0442','250')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0444','120')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0445','50')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0446','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0447','1000')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0448','50')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0449','300')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0509','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0510','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-0602','40')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1006','138240')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1007','30720')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1008','12096')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1009','82944')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1011','34560')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1012','30720')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1013','18432')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1014','9216')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-05-1025','10')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-06-0204','2500')
insert into #monthlytarget(m_stockcode,m_qty) values ('10-06-0205','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('12-12-0001','12000')
insert into #monthlytarget(m_stockcode,m_qty) values ('16-03-8042','500')
insert into #monthlytarget(m_stockcode,m_qty) values ('16-03-8108','1000')
insert into #monthlytarget(m_stockcode,m_qty) values ('16-03-8195','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-01-0102','60000')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-01-0200','5000')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-01-2500','20000')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-03-3707','200')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0010','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0011','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0012','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0020','30')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0030','10')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0040','10')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0063','30')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0070','1000')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0085','500')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-0095','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-8020','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-8021','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-05-8024','1')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-07-0839','600')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-07-1780','30')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-14-0002','2000')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-14-0004','1500')
insert into #monthlytarget(m_stockcode,m_qty) values ('14-15-0014','100')
insert into #monthlytarget(m_stockcode,m_qty) values ('18-10-0013','15000')
insert into #monthlytarget(m_stockcode,m_qty) values ('18-10-0015','1600000')
insert into #monthlytarget(m_stockcode,m_qty) values ('18-10-0020','750000')
insert into #monthlytarget(m_stockcode,m_qty) values ('18-10-0025','600000')
insert into #monthlytarget(m_stockcode,m_qty) values ('18-10-0093','135000')
insert into #monthlytarget(m_stockcode,m_qty) values ('18-10-0607','18900')
insert into #monthlytarget(m_stockcode,m_qty) values ('18-10-2005','135000')
insert into #monthlytarget(m_stockcode,m_qty) values ('18-10-2208','135000')

SELECT @Command = 'INSERT INTO #workData239_2 '
SELECT @Command = @command + 'SELECT '
SELECT @Command = @command + 'SC01001, SC03002, SC03003, SC03005, SC03006, '
SELECT @Command = @command + 'SC03010, SC03057,0, ''__________'', NULL,NULL,NULL,NULL '
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
set QtyMnth=m_qty from #monthlytarget where m_stockcode = item collate database_default

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

IF @supplier IS NOT NULL
 Select * from  #workData239 where SupplierCode collate database_default IN (Select Value from dbo.Split(',',@supplier) ) order by item  	
ELSE
Select * from  #workData239 
END