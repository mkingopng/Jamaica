USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00330v1.0_sel]    Script Date: 10/05/2021 11:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00330v1.0_sel] 
	-- Add the parameters for the stored procedure here
	@StartDate as Datetime,
	@EndDate As Datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
    PC01001    "PurchOrderNo" 
 ,  PC01046    "Purchaser"
 ,  SUBSTRING(PC03036,7,2) "CostCentre"
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
 ,  (PC03008 * PC03010) - ((PC03008 * PC03010 * PC03015)  / 100) "OrderValue" 
 ,  (PC03008 * PC03011) - ((PC03008 * PC03011 * PC03015)  / 100) "OrderReceived"
 ,	(PC03008 * PC03012) - ((PC03008 * PC03012 * PC03015)  / 100) "OrderInvoiced"
 ,  (PC03008 * (PC03010 - PC03011)) - ((PC03008 * (PC03010 - PC03011) * PC03015)  / 100) "OrderOutstanding"
 
 FROM [ScaCompanyDB]..PC010100    INNER JOIN    [ScaCompanyDB]..PC030100 
                                  ON   PC01001 = PC03001
 
                                  INNER JOIN    [ScaCompanyDB]..PL010100 
                                  ON   PC01003 = PL01001
                                  
  WHERE PC01015 BETWEEN @StartDate AND @EndDate and (PC03008 * (PC03010 - PC03011)) - ((PC03008 * (PC03010 - PC03011) * PC03015)  / 100) <> 0
  And PC01002 in ('1','2') 
END
