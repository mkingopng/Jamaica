USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00281_Sel]    Script Date: 10/05/2021 10:56:46 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00281_Sel]
	@Warehouse as CHAR(4),
	@Margin as numeric,
	@Symbol as Char(4)
AS

	CREATE TABLE #work
	(
		Stockcode		nvarchar(35),	
		Description		nvarchar(70) ,
		RetailPrice		numeric(20,8),
		AverageCost		numeric(20,8),
		LastSaleCost		numeric(20,8),
		MARGIN			numeric(20,8),
		MARGIN2		numeric(20,8),
		TransactionNumber	NCHAR(8),
		suppcode nvarchar(10),
		suppname nvarchar(50)
	)
	
	CREATE TABLE #work2
	(
		wStockcode		nvarchar(35),	
		wTransactionNumber	NCHAR(8)
	)

	INSERT INTO #work
	SELECT SC01001,
		SC01002 + ' ' + SC01003, 
		SC01004, 
		SC03057, 
		NULL ,
		NULL,
		NULL,
		NULL,
		SC01058,
		0
	FROM ScaCompanyDB..SC010100
	INNER JOIN ScaCompanyDB..SC030100
	ON SC03001 = SC01001	
	WHERE SC03002 = @warehouse
	AND SC03003 > 0
	AND( SC01038 = 'II' OR SC01038 = 'IS')
	AND SC03057 <> 0 AND SC01001 <> '52-06-3400'

	UPDATE #work
	SET MARGIN = ((RetailPrice - AverageCost)/RetailPrice*100 )
	WHERE AverageCost <> 0 and RetailPrice <> 0
	UPDATE #work
	SET MARGIN = 0
	WHERE  RetailPrice = 0

	INSERT into #Work2
	SELECT SC07003,
		MAX(SC07022)
	FROM ScaCompanyDB..SC070100 
	WHERE SC07001 ='01' 
	GROUP BY SC07003

	UPDATE #work
	SET TransactionNumber = wTransactionNumber
	FROM #work2
	WHERE StockCode = wStockCode

	UPDATE #work
	SET LastSaleCost = SC07005
	FROM ScaCompanyDB..SC070100
	WHERE TransactionNumber =  SC07022 Collate Database_Default

	UPDATE #work
	SET MARGIN2 = (( LastSaleCost-RetailPrice)/LastSaleCost * 100 )
	WHERE LastSaleCost <> 0
	
	UPDATE #work
	SET suppname = PL01002
	FROM ScaCompanyDB..PL010100 
	WHERE suppcode = PL01001 COLLATE Database_Default

	IF @Symbol = '<'
	Select * from #work 
	WHERE Margin < @margin 
	--OR Margin2 < @margin
	ELSE
	Select * from #work 
	WHERE Margin > @margin 
	--OR Margin2 > @margin