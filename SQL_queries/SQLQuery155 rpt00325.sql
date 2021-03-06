USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00325_sel]    Script Date: 10/05/2021 11:46:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00325_sel] 
	-- Add the parameters for the stored procedure here
	@Selection NVARCHAR(64) 
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @C as NVARCHAR(4000),
	@12monthsago as datetime,
	@Now as datetime
	
	
	SET NOCOUNT ON;
	
	SELECT @Now = GETDATE()
	SELECT @12monthsago =  DATEADD(y,-1,GETDATE())

	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[##work325]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[##work325]
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[##work3252]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[##work3252]
		IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[##work3253]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[##work3253]
	
	
	CREATE TABLE ##work325
	(
		StockCode NVARCHAR(35),
		Description1 NVARCHAR(25),
		Description2 NVARCHAR(25),
		AltProdGroup NVARCHAR(4),
		AltProdGrpDescr NVARCHAR(35),
		SupplierCode NVARCHAR(10),
		SupplierNAe NVARCHAR(35),
		ReplacemItem NVARCHAR(35),
		StockBalance NUMERIC(20,8),
		AccountCode NVARCHAR(6),
		AccountName NVARCHAR(35),
		AvgAvgStockCost NumERIC(20,8),
		AverSalesPrice Numeric(20,8)
	)
	
	SELECT @C = 'INSERT INTO ##work325 SELECT  '
	SELECT @C = @C + 'SC01001 '
	SELECT @C = @C + ',  SC01002 '
	SELECT @C = @C + ',  SC01003 ' 
	SELECT @C = @C + ',  SC01038 ' 
	SELECT @C = @C + ',  SY24003 '
	SELECT @C = @C + ',  SC01058 '
	SELECT @C = @C + ',  PL01002 '
	SELECT @C = @C + ',  SC01030 ' 
	SELECT @C = @C + ',  SC01042 ' 
	SELECT @C = @C + ',  SUBSTRING(SC01039,13,6) ' 
	SELECT @C = @C + ',  GL03003 '	
	SELECT @C = @C + ',  0 '
	SELECT @C = @C + ',  0 '  
	SELECT @C = @C + 'FROM [ScaCompanyDB]..SC010100    INNER JOIN    [ScaCompanyDB]..SY240100 '
	SELECT @C = @C + 'ON   SY24002 = SC01038  AND SY24001 = ''IB'' '
	SELECT @C = @C + 'INNER JOIN    [ScaCompanyDB]..PL010100 ' 
	SELECT @C = @C + 'ON   SC01058 = PL01001 '					  
	SELECT @C = @C + 'INNER JOIN    [ScaCompanyDB]..GL030110 ' 
	SELECT @C = @C + 'ON   SUBSTRING(SC01039,13,6) = GL03002 '
	IF @Selection = 'Wood_Metal Working'
		SELECT @C = @C + 'WHERE (SC01001 LIKE ''20%'' OR SC01001 LIKE ''22%'' OR  SC01001 LIKE ''24%'' OR SC01001 LIKE ''26%'' OR  SC01001 LIKE ''27%'' )'       
	IF @Selection = 'Air'
		SELECT @C = @C + 'WHERE (SC01001 LIKE ''28%'' OR SC01001 LIKE ''30%'' OR  SC01001 LIKE ''32%'' )'    
	IF @Selection = 'Automotive_Packaging_and_Materials'
		SELECT @C = @C + 'WHERE (SC01001 LIKE ''38%'' OR SC01001 LIKE ''58%'' OR SC01001 LIKE ''66%'' )'  
	IF @Selection = 'PPE'
		SELECT @C = @C + 'WHERE (SC01001 LIKE ''52%'' )'     
	IF @Selection = 'Abrasives'
		SELECT @C = @C + 'WHERE (SC01001 LIKE ''62%'' )'
	IF @Selection = 'Hydraulic_Tools'
		SELECT @C = @C + 'WHERE (SC01001 LIKE ''40%'' OR SC01001 LIKE ''44%'' )'     
	IF @Selection = 'HandTools'
		SELECT @C = @C + 'WHERE (SC01001 LIKE ''68%'' )'   
	IF @Selection = 'Lubrication'
		SELECT @C = @C + 'WHERE (SC01001 LIKE ''34%'' OR SC01001 LIKE ''35%'' )'     
	SELECT @C = @C + 'ORDER BY SC01001 '       
	--SELECT @c
	EXEC (@c)
	
	SELECT SC03001 "mystock",SUM(SC03057 * SC03003) "TotalCost",SUM(SC03003) "TotalStock"
	INTO ##work3252 
	FROM ScaCompanyDB..SC030100 
	WHERE SC03003 > 0
	GROUP BY SC03001
	
	UPDATE ##work325	
	SET AvgAvgStockCost = (SELECT (TotalCost / TotalStock) FROM ##work3252 WHERE mystock =  Stockcode  COLLATE DATABASE_Default)
	
	UPDATE ##work325
	SET AvgAvgStockCost =  0 WHERE AvgAvgStockCost IS NULL
	

	SELECT @c = 'SELECT ST03017 "mystock",AVG(ST03021) "AvgPrice" '
	SELECT @c = @c + ' INTO ##work3253 ' 
	SELECT @c = @C + ' FROM ScaCompanyDB..ST030100  '
	SELECT @c = @c + 'WHERE ST03015 BETWEEN ''' + CAST(@12monthsago as CHAR(20)) + ''' and ''' + CAST(@Now as CHAR(20)) + ''' ' 
	SELECT @c = @c + ' GROUP BY ST03017 '
	EXEC  (@c)
	 
	UPDATE ##work325
	SET AverSalesPrice =  (SELECT AvgPrice FROM ##work3253 WHERE mystock =  Stockcode  COLLATE DATABASE_Default) 
	
	UPDATE ##work325
	SET AverSalesPrice=  0 WHERE AverSalesPrice IS NULL
	
	SELECT * FROM ##work325
	
	DROP TABLE [dbo].[##work325]
	DROP TABLE [dbo].[##work3252]
	DROP TABLE [dbo].[##work3253]
END
