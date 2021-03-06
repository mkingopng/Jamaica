USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00302_sel]    Script Date: 10/05/2021 11:07:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00302_sel] 
	-- Add the parameters for the stored procedure here
	@Division NVarchar(354)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Altprodgrp as NVARCHAR(50)
	DECLARE @command as NVARCHAR(4000)
	
IF @Division = 'Industrial'
	SELECT @Altprodgrp = '(''IS'',''II'')'
IF @Division = 'Commercial'
	SELECT @Altprodgrp = '(''COS'',''COI'')'
IF @Division = 'Retail'
	SELECT @Altprodgrp = '(''RES'',''REI'')'


    -- Insert statements for procedure here

create table #workdata302
	(
		StockCode			 nvarchar(35),
		description			 nvarchar(75),			
		ExcessStock 		 Numeric(20,8)NULL,
		SOH					 Numeric(20,8)NULL,
		AltProdGrp			 Nvarchar(4)NULL
	)
create table #workdata302_2
	(
		t_Stockcode			 nvarchar (35),
		Order#				 NVARCHAR(10) NULL,	
		OrderDate    	     DateTime NULL,
		Value				 Numeric(20,8)NULL,
		Qty					 Numeric(20,8) NULL
	)
Create table #workdata302_3
	(
		wStockCode			 nvarchar(35),
		wdescription		 nvarchar(75),			
		wExcessStock 		 Numeric(20,8)NULL,
		wSOH				 Numeric(20,8)NULL,
		wAltProdGrp			 Nvarchar(4) NULL,
		wCuscode			 NVARCHAR(10) NULL,
		wCusName	   		 NVARCHAR(35) NULL,	
		wOrder#				 NVARCHAR(10) NULL,	
		wOrderDate		     DateTime NULL,
		wValue				 Numeric(20,8)NULL,
		wQty				 Numeric(20,8) NULL
	)	
INSERT INTO #workdata302
SELECT  su_item,
		NULL,
		SUM(su_onhandqty - su_stockhistory),
		SUM(su_onhandqty),
		NULL		
FROM KK_Rpt00231Data
GROUP BY su_item

DELETE FROM #workdata302
WHERE ExcessStock < 1

--UPDATE #workdata302 
--	SET SOH = (SELECT SUM(SC03003) FROM ScaCompanyDB..SC030100 Where SC03001 = StockCode COLLATE DATABASE_DEFAULT)

UPDATE #workdata302 
	SET description = SC01002 + SC01003,
		AltProdGrp = SC01038
FROM	ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE DATABASE_DEFAULT


INSERT INTO #workdata302_2
SELECT  SC07003,
		SC07007,
		SC07002,
		SC07005,
		SC07004		
FROM ScaCompanyDB..SC070100
WHERE SC07001 = '01'
AND SC07002 > '2009-01-01'

INSERT INTO #workdata302_3
SELECT  stockcode,
		description,
		ExcessStock,
		SOH,
		AltProdgrp,
		NULL,
		NULL,
		order#,
		orderdate,
		value,
		qty
FROM #workdata302
LEFT OUTER JOIN #workdata302_2
ON stockcode = t_stockcode COLLATE Database_Default

UPDATE #workdata302_3
	SET wCusCode = OR20003
FROM ScaCompanyDB..OR200100
WHERE wOrder# = OR20001 COLLATE DATABASE_DEFAULT

UPDATE #workdata302_3
	SET wCusName = SL01002
FROM ScaCompanyDB..SL010100
WHERE wCusCode = SL01001 COLLATE DATABASE_DEFAULT


SELECT @command = 'SELECT * FROM #workdata302_3 '
SELECT @command = @command + 'WHERE wAltProdGrp IN ' + @Altprodgrp + ' '
SELECT @command = @command + 'ORDER BY wStockcode, wOrderDate Desc'
EXEC (@command)

END
