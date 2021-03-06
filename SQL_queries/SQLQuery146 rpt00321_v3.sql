USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00321_v3_sel]    Script Date: 10/05/2021 11:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00321_v3_sel]
AS
SELECT 
    a.SC01001    "StockCode" 
 ,  a.SC01002 + '' +  a.SC01003    "Description" 
 ,  a.SC01042    "StockBalance" 
 ,  a.SC01043    "ReservedQty" 
 ,  a.SC01058    "SupplierCode" 
 ,  a.SC01060    "SupplStockCo" 
FROM ScaCompanyDB..SC010100 a WHERE a.SC01038 = 'RES'
AND a.SC01001 NOT IN('12-01-8317','12-01-8401','46-04-2096','46-05-1005')