USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00357_sel]    Script Date: 10/05/2021 13:34:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00357_sel] 
	-- Add the parameters for the stored procedure here
	@StartDate as Datetime,
	@EndDate As Datetime
AS
BEGIN
drop table [KK_StockSuplier]
CREATE TABLE [dbo].[KK_StockSuplier] (
[StockCode] [VARCHAR] (20) NOT NULL ,
[SupplierCode] [nvarchar] (10) NOT NULL --,	[Variance] [nvarchar] (10),
	
) ON [PRIMARY]
--INSERT [ScaCompanyDB].[dbo].[KK_Stock_Suplier]
--Set StockCode = SC010100 


INSERT INTO [ScaCompanyDB].[dbo].[KK_StockSuplier] (StockCode,SupplierCode) 	
	SELECT 	 SC01001,SC01058
     FROM 		SCACompanyDb.dbo.SC010100
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
    PC01001    "PurchOrderNo" 
 ,  PC01002    "OrderType" 
 ,  PC01015    "OrderDate" 
 ,  PL01002    "SupplierName" 
 ,  PC01003    "SuppCodBuyer" 
 ,  PC03005    "StockCode" 
 ,  PC03006    "DescriptLine1" 
 ,  PC03010    "PCQtyOrdered" 
 ,  PC03011    "PCQtyReceive" 
 ,  PC03012    "PCQtyInvoice" 
 ,  PC03015    "Discount" 
 ,  PC03008    "UnitPrice"
 ,  PC03025    "ExchRate"
   --((PC03008 * PC03010*2)) "EvALUE" --- ((PC03008 * PC03010 * PC03015 * 2)  / 100)) "OrderValue" 
 ,  (((PC03008 * PC03010) - ((PC03008 * PC03010 * PC03015 * 2)  / 100))*PC03025) "OrderValue" 
 ,  ((PC03008 * PC03011) - ((PC03008 * PC03011 * PC03015)  / 100)*PC03025) "OrderReceived"
 ,	((PC03008 * PC03012) - ((PC03008 * PC03012 * PC03015)  / 100)*PC03025) "OrderInvoiced"
 ,  (((PC03008 * (PC03010 - PC03011)) - ((PC03008 * (PC03010 - PC03011) * PC03015)*PC03025)  / 100)*PC03025) "OrderOutstanding"
 
 FROM [ScaCompanyDB]..PC010100    INNER JOIN    [ScaCompanyDB]..PC030100 
                                  ON   PC01001 = PC03001
 
                                  INNER JOIN    [ScaCompanyDB]..PL010100 
                                  ON   PC01003 = PL01001
                                  INNER JOIN [ScaCompanyDB]..[KK_StockSuplier]
                                  ON StockCode = PC03005
                                  
  WHERE PC01015 BETWEEN @StartDate AND @EndDate and (PC03008 * (PC03010 - PC03011)) - ((PC03008 * (PC03010 - PC03011) * PC03015)  / 100) <> 0
   AND PC01002 in ('1','2')
   
END
