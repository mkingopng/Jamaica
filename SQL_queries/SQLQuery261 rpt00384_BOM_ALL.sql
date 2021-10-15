USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00384_BOM_ALL]    Script Date: 10/05/2021 14:13:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author:		<Author,,Name>
 --Create date: <Create Date,,>
 --Description:	<Description,,>
 --=============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00384_BOM_ALL] 
--DECLARE
	@Department NVARCHAR (256)
	-- Add the parameters for the stored procedure here
	--@StartDate as Datetime,
	--@EndDate As Datetime
AS
BEGIN
SET NOCOUNT ON;

CREATE TABLE [dbo].[#KK_BOM_ALL] (
[MStockCode] [NVARCHAR] (35),
[Description] NVARCHAR(50),
[BOMStockCode] [nvarchar] (35),	
[BOMDESC] NVARCHAR(50),
[BOMQty] NUMERIC(10,2),
[BOMUOM] NVARCHAR(4),
[BOMSTDCOST] NUMERIC(10,2),
[BOOMTOTALCOST] NUMERIC (10,2),
[OVERHEADS] NUMERIC(10,2),
[CALCTOTAL] NUMERIC(10,2),
[DEPT] NVARCHAR(50)
) ON [PRIMARY]

--SET @Department = 'PLASTICS'

INSERT INTO #KK_BOM_ALL (MStockCode,Description,BOMStockCode,BOMDESC,BOMQty,BOMUOM,
BOMSTDCOST,BOOMTOTALCOST,OVERHEADS,CALCTOTAL, DEPT) 	
SELECT 	 MP61002,0,MP61005,SC01002+SC01003,MP61008,MP61024,SC01053,(MP61008*SC01053),0,0,NULL
FROM SCACompanyDb.dbo.MP610100 INNER JOIN ScaCompanyDB..SC010100 ON MP61005 = SC01001 
WHERE MP61001 = 'M'
--AND MP61002 BETWEEN '12-01-8005' AND '12-14-0110' OR -- CHEMICAL
--MP61002 BETWEEN '10-01-0043' AND '10-02-0215' OR--BULK
--MP61002 LIKE '11-01%' OR--OIL
--MP61002 LIKE '46-04%' OR--PAPER
--MP61002 LIKE '15-50%' OR--ROTO
--MP61002 LIKE '18-10%' OR--PET
--MP61002 LIKE '16-01%' --PLASTICS
--MP61002 BETWEEN '16-01-0000' AND '16-03-9999'--PLASTICS -- added 19/09/2019 to include 16-02/16-03 range, request by Reuben Satumba

UPDATE #KK_BOM_ALL 
SET Description = SC01002+SC01003 
FROM ScaCompanyDB..SC010100 WHERE MStockCode COLLATE DATABASE_DEFAULT = SC01001 

UPDATE #KK_BOM_ALL 
SET DEPT='CHEMICAL'
FROM #KK_BOM_ALL WHERE MStockCode BETWEEN '12-01-8005' AND '12-14-0110' COLLATE DATABASE_DEFAULT

UPDATE #KK_BOM_ALL 
SET DEPT='BULK'
FROM #KK_BOM_ALL WHERE MStockCode BETWEEN '10-01-0043' AND '10-02-0215' COLLATE DATABASE_DEFAULT

UPDATE #KK_BOM_ALL
SET DEPT='OIL'
FROM #KK_BOM_ALL WHERE MStockCode LIKE '11-01%' COLLATE DATABASE_DEFAULT

UPDATE #KK_BOM_ALL 
SET DEPT='PAPER'
FROM #KK_BOM_ALL WHERE MStockCode LIKE '46-04%' COLLATE DATABASE_DEFAULT

UPDATE #KK_BOM_ALL 
SET DEPT='ROTO'
FROM #KK_BOM_ALL WHERE MStockCode LIKE '15-50%' COLLATE DATABASE_DEFAULT

UPDATE #KK_BOM_ALL 
SET DEPT='PET'
FROM #KK_BOM_ALL WHERE MStockCode LIKE '18-10%' COLLATE DATABASE_DEFAULT

UPDATE #KK_BOM_ALL 
SET DEPT='PLASTICS'
FROM #KK_BOM_ALL WHERE MStockCode LIKE '16-0%' COLLATE DATABASE_DEFAULT
--FROM #KK_BOM_ALL WHERE MStockCode BETWEEN '16-01-0000' AND '16-03-9999' COLLATE DATABASE_DEFAULT  -- added 19/09/2019 to include 16-02/16-03 range, request by Reuben Satumba


DELETE FROM #KK_BOM_ALL WHERE Description = '0'

UPDATE #KK_BOM_ALL 
SET CALCTOTAL = MP57006
FROM ScaCompanyDB..MP570100 
WHERE MStockCode COLLATE DATABASE_DEFAULT = MP57001 

UPDATE #KK_BOM_ALL
SET BOMUOM = 'Each' WHERE  BOMUOM = '0'
UPDATE #KK_BOM_ALL
SET BOMUOM = 'KG' WHERE  BOMUOM = '1'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Ltr' WHERE  BOMUOM = '2'
UPDATE #KK_BOM_ALL
SET BOMUOM = 'Box' WHERE  BOMUOM = '3'
UPDATE #KK_BOM_ALL
SET BOMUOM = 'Roll' WHERE  BOMUOM = '4'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Pair' WHERE  BOMUOM = '5'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'KLtr' WHERE  BOMUOM = '6'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Mtr' WHERE  BOMUOM = '7'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Gram' WHERE  BOMUOM = '8'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Pack' WHERE  BOMUOM = '9'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Bale' WHERE  BOMUOM = '10'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Ctn' WHERE  BOMUOM = '11'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Drum' WHERE  BOMUOM = '12'
UPDATE #KK_BOM_ALL 
SET BOMUOM = 'Kit' WHERE  BOMUOM = '13'

IF @Department='Chemical'
SELECT * from #KK_BOM_ALL WHERE DEPT='CHEMICAL'

IF @Department='Bulk'
SELECT * from #KK_BOM_ALL WHERE DEPT='BULK'

IF @Department='Oil'
SELECT * from #KK_BOM_ALL WHERE DEPT='OIL'

IF @Department='Paper'
SELECT * from #KK_BOM_ALL WHERE DEPT='PAPER'

IF @Department='Roto'
SELECT * from #KK_BOM_ALL WHERE DEPT='ROTO'

IF @Department='Pet'
SELECT * from #KK_BOM_ALL WHERE DEPT='PET'

IF @Department='Plastics'
SELECT * from #KK_BOM_ALL WHERE DEPT='PLASTICS' order by MStockCode

DROP table [#KK_BOM_ALL]
END