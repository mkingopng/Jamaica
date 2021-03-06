USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00304_sel]    Script Date: 10/05/2021 11:07:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00304_sel] 
	@Style NVARCHAR(256)
	AS
BEGIN

	DECLARE @c as NVARCHAR(4000)
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT @c = 'SELECT '
SELECT @c = @c + 'T1.SC01001    "StockCode"'
SELECT @c = @c + ' ,  T1.SC01002    "Description1"' 
SELECT @c = @c + ' ,  T1.SC01003    "Description2"'
SELECT @c = @c + ' ,  NULL "WH5 ReOrderLevel"' 
SELECT @c = @c + ' ,  NULL "WH5 StockBalance"'
SELECT @c = @c + ' ,  NULL "WH6 ReOrderLevel"' 
SELECT @c = @c + ' ,  NULL "WH6 StockBalance"' 
SELECT @c = @c + ' ,  NULL "WH3 ReOrderLevel"' 
SELECT @c = @c + ' ,  NULL "WH3 StockBalance"' 
SELECT @c = @c + 'INTO ##QRYTMP_104228445 '
SELECT @c = @c + 'FROM [ScaCompanyDB]..SC010100 T1 '
--WHERE T1.SC01001   IN('14-01-0100','14-01-0101','14-03-3707','14-07-0838','14-07-1070','14-01-0200','14-01-2500','14-07-1780','14-05-0085','14-05-0040','14-05-0045','14-05-8023','14-05-0070','14-15-0015','14-15-0014','14-14-0004','')
IF @Style = 'Plastics Finished Goods '
	SELECT @c = @c + 'WHERE SUBSTRING(SC01037,1,2) = ''16'' '
ELSE 	
	SELECT @c = @c + 'WHERE SC01038 = ''PLR'' '
EXEC (@c) 


END 

UPDATE ##QRYTMP_104228445
	SET  [WH6 StockBalance] = SC03003
	FROM ScaCompanyDB..SC030100
	WHERE SC03002 = '06'
	AND SC03001 = Stockcode
	
UPDATE ##QRYTMP_104228445
	SET  [WH6 ReOrderLevel] = SC03010
	FROM ScaCompanyDB..SC030100
	WHERE SC03002 = '06'
	AND SC03001 = Stockcode
	
UPDATE ##QRYTMP_104228445
	SET  [WH3 StockBalance] = SC03003
	FROM ScaCompanyDB..SC030100
	WHERE SC03002 = '03'
	AND SC03001 = Stockcode
	
UPDATE ##QRYTMP_104228445
	SET  [WH3 ReOrderLevel] = SC03010
	FROM ScaCompanyDB..SC030100
	WHERE SC03002 = '03'
	AND SC03001 = Stockcode
	
UPDATE ##QRYTMP_104228445
	SET  [WH5 StockBalance] = SC03003
	FROM ScaCompanyDB..SC030100
	WHERE SC03002 = '05'
	AND SC03001 = Stockcode
	
UPDATE ##QRYTMP_104228445
	SET  [WH5 ReOrderLevel] = SC03010
	FROM ScaCompanyDB..SC030100
	WHERE SC03002 = '05'
	AND SC03001 = Stockcode
	
/* ************************************************ */
/* SELECT THE RESULT FROM QUERY  */
/* ********************************************* */
BEGIN 
SELECT 
    [StockCode]   "StockCode" 
 ,  [Description1]   "Description1" 
 ,  [Description2]   "Description2" 
 ,  [WH6 ReOrderLevel]   "WH6 ReOrderLevel" 
 ,  [WH6 StockBalance]   "WH6 StockBalance" 
 ,  [WH3 ReOrderLevel]   "WH3 ReOrderLevel" 
 ,  [WH3 StockBalance]   "WH3 StockBalance" 
 ,  [WH5 ReOrderLevel]   "WH5 ReOrderLevel" 
 ,  [WH5 StockBalance]   "WH5 StockBalance" 
 
FROM ##QRYTMP_104228445
  
ORDER BY 1 ASC,2 ASC,3 ASC,4 ASC,5 ASC,6 ASC 
END 
/* ************************************************ */
/* Drop Temp File                                  */
/* ********************************************** */
BEGIN 
DROP TABLE ##QRYTMP_104228445 
END 

