USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00327_sel]    Script Date: 10/05/2021 11:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00327_sel]
	-- Add the parameters for the stored procedure here
	@stockcode NVARCHAR(35)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	
DECLARE @sixmonthsago as datetime,
		@ordercount as integer
		

SELECT @sixmonthsago = DATEADD(m,-6,GETDATE())

SELECT @ordercount = (SELECT COUNT(*) 
						FROM [ScaCompanyDB]..PC030100						
						INNER JOIN    [ScaCompanyDB]..PC010100 
						ON   PC01001 = PC03001
						WHERE PC03005 = @stockcode
						AND PC03010 <> PC03012
						AND PC01015 > @sixmonthsago) 

IF @ordercount > 0 
	BEGIN
			SELECT 
			PC01001    "PurchOrderNo" 
		 ,  PC01002    "OrderType" 
		 ,  PC01003    "SupplierCode" 
		 ,  PL01002    "SupplierName" 
		 ,  PC03005    "StockCode" 
		 ,  SC01002 + ' '  + SC01003    "Description" 
		 ,  PC03010    "QtyOrdered"
		 ,  PC03012    "QtyInv"
		 ,  PC01015	   "Order Date"
		 ,  PC01016	   "Delivery Date"
			 
		 FROM [ScaCompanyDB]..PC010100     
		 INNER JOIN    [ScaCompanyDB]..PC030100 
		 ON   PC01001 = PC03001
		 INNER JOIN    [ScaCompanyDB]..SC010100 
		 ON   PC03005 = SC01001
		 INNER JOIN    [ScaCompanyDB]..PL010100 
		 ON   PL01001 = PC01003
		 WHERE PC03005 = @stockcode
		 AND PC03010 <> PC03012
		 AND PC01015 > @sixmonthsago
		 AND PC03010 > 0
	END
ENd
