USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00368_sel_POD]    Script Date: 10/05/2021 14:03:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00368_sel_POD] 
@Status AS NVARCHAR(20)
WITH RECOMPILE 
AS 
BEGIN 
/* ************************************************* */ 

SELECT 
    OrderNo    "OrderNumber" 
 ,  InvoiceNo   "Invoice Number" 
 ,  Sent    "Sent Status" 
 ,  Received    "Received Status" 
 ,  Date    "Date Sent" 
 
-- , 'Warehousename          '       "WHName"
  
  FROM [ScaCompanyDB]..ProofOfDelivery0100   where Received = @Status 

 			    				
 --select * from #WORK322 WHERE TotalQty <> 0 Order By WH,Stockcode,DATE DESC


 

END 