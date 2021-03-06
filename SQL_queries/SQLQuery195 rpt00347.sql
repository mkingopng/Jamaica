USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00347]    Script Date: 10/05/2021 12:58:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00347] 
--	 ST080100.ST08022, ST080100.ST08024 AS 'Inv No (Batch)'
AS
BEGIN
SELECT  D1_OrderNo,  D2_TransactionDate,  D3_StockCode,  D4_Desc1,  D5_Desc2,  D6_Qty,  D7_PurchasePrice,  D8_AvgCostPrice,  D9_PriceVariation,  D10_Warehouse,  D12_SupplierName,  D13_BatchNumber
 FROM   "IscalaAnalysis"."dbo"."KK_DailyPurchases"
 WHERE -- ( D1_OrderNo>=N'0000030000' AND  D1_OrderNo<=N'0000059999') 
 NOT ( D9_PriceVariation>=-20 AND  D9_PriceVariation<=20)
and 
D10_Warehouse = '05'
END