USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00323_sel]    Script Date: 10/05/2021 11:28:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 25/01/10
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00323_sel]
	-- Add the parameters for the stored procedure here
	
/* ************************************************* */
AS	
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#work323]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#work323]

CREATE TABLE #work323
	(
		Type     					NVARCHAR(10),
		Salesman					NCHAR(3),
		SalesmanName				NVARCHAR(35),
		OrderStatus					NCHAR(2),
		OrderStatusName				NVARCHAR(35),
		ServiceOrderNo				VARCHAR(20),		
		--StockCode                   VARCHAR(20),
		CustomerCode				NCHAR(10),
		CustomerName				NVARCHAR(35),	
		StartDate					DATETIME,	
		DaysOpen					INTEGER,
		LabourCost					NUMERIC(28, 8),
		LabourInvoice				NUMERIC(28, 8),
		LabourMargin     			NUMERIC(28, 8),
		OtherCost					NUMERIC(28, 8),
		OtherInvoice				NUMERIC(28, 8),
		OtherMargin     			NUMERIC(28, 8),
		MaterialCost				NUMERIC(28, 8),
		MaterialInvoice				NUMERIC(28, 8),
		MaterialMargin     			NUMERIC(28, 8),
		EquipmentSerialNo           NVARCHAR(35),
		EquipmentMake	            NVARCHAR(35),
		EquipmentModel              NVARCHAR(35),
		AnalysisCode				NCHAR(10),
		OrderType                   VARCHAR(3),
		StockCode                   Varchar(20)
	)	


INSERT INTO #work323 
	SELECT
	''
 ,	SM01110 
 ,  ST01002 
 ,  SM01064 
 ,  SY24003
 ,  SM01001 
 ,  SL01001
 ,  SL01002 
 ,  SM01017
 ,  0       
 ,  null	  
 ,  null	
 ,  nuLL	 
 ,  NULL 
 ,  NULL   
 ,  NULL                       
 ,  NULL    
 ,  NULL   
 ,  NULL 
 ,SM01007
 ,SM01008 
 ,SM01009 
 ,SM01077
 ,SM01097  
 ,Null 
 FROM   [ScaCompanyDB]..SM010100    
 INNER JOIN  [ScaCompanyDB]..SL010100
		ON   SL01001 = SM01003
 INNER JOIN  [ScaCompanyDB]..ST010100
		ON   ST01001 = SM01110
 INNER JOIN  [ScaCompanyDB]..SY240100
		ON   SY24001 = 'ED' AND SM01064 = SY24002
		Where SM01097 <> 'M'

 UPdate #work323	
		Set Type = 'Internal'
		WHERE ServiceOrderNo > '200000000' --and OrderType = 'M'
		
UPdate #work323	
		Set Type = 'External'
		WHERE ServiceOrderNo < '200000000' --and OrderType = 'M'
		
UPdate #work323	
		Set DaysOpen = DATEDIFF(d,StartDate, GETDATE())
		
Update #work323
	SET [LabourCost] = (SELECT SUM(SM03012 * SM03008) FROM  [ScaCompanyDB]..SM030100 WHERE ServiceOrderNo = SM03001  COLLATE Database_Default)
Update #work323
	SET [LabourInvoice] = (SELECT SUM(SM03044 * SM03008) FROM  [ScaCompanyDB]..SM030100 WHERE ServiceOrderNo= SM03001  COLLATE Database_Default)
Update #work323
	SET [LabourMargin] = (([LabourInvoice] - [LabourCost]) / [LabourCost]) 
	WHERE OrderStatus >= '30' AND [LabourCost] > 0
	
Update #work323
	SET [OtherCost] = (SELECT SUM(SM05024 * SM05009) FROM  [ScaCompanyDB]..SM050100 WHERE ServiceOrderNo = SM05001  COLLATE Database_Default)
Update #work323
	SET [OtherInvoice] = (SELECT SUM(SM05024 * SM05021) FROM  [ScaCompanyDB]..SM050100 WHERE ServiceOrderNo = SM05001  COLLATE Database_Default)
Update #work323
	SET [OtherMargin] = (([OtherInvoice] - [OtherCost]) / [OtherCost]) 
	WHERE OrderStatus >= '30' AND [OtherCost] > 0
	
Update #work323
	SET [MaterialCost] = (SELECT SUM(SM07017 * SM07010) FROM  [ScaCompanyDB]..SM070100 WHERE ServiceOrderNo  = SM07001  COLLATE Database_Default)
Update #work323
	SET [MaterialInvoice] = (SELECT SUM(SM07017 * SM07025) FROM  [ScaCompanyDB]..SM070100 WHERE ServiceOrderNo = SM07001  COLLATE Database_Default)
Update #work323
	SET [MaterialMargin] = (([MaterialInvoice] - [MaterialCost]) / [MaterialCost]) 
	WHERE OrderStatus >= '30' AND [MaterialCost] > 0
--Update #work323 
  --  SET [StockCode] = (SELECT SM07004 FROM  [ScaCompanyDB]..SM070100 WHERE ServiceOrderNo = SM07001)--  COLLATE Database_Default)
    

SELECT * FROm #work323
	
