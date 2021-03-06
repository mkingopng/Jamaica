USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00356_sel]    Script Date: 10/05/2021 13:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Manish Yadav
-- Create date: 18/04/11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00356_sel]
	-- Add the parameters for the stored procedure here
	
/* ************************************************* */
AS	
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[#work356]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#work356]

CREATE TABLE #work356
	(
		Type     					NVARCHAR(10),
		Salesman					NCHAR(3),
		SalesmanName				NVARCHAR(35),
		OrderStatus					NCHAR(2),
		OrderStatusName				NVARCHAR(35),
		ServiceOrderNo				NCHAR(10),		
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
		OrderType                   VARCHAR(3)
	)	


INSERT INTO #work356 
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
 FROM   [ScaCompanyDB]..SM010100    
 INNER JOIN  [ScaCompanyDB]..SL010100
		ON   SL01001 = SM01003
 INNER JOIN  [ScaCompanyDB]..ST010100
		ON   ST01001 = SM01110
 INNER JOIN  [ScaCompanyDB]..SY240100
		ON   SY24001 = 'ED' AND SM01064 = SY24002
WHERE SM01097 = 'M'

 UPdate #work356	
		Set Type = 'Internal'
		WHERE ServiceOrderNo > '200000000' --and OrderType = 'M'
		
UPdate #work356	
		Set Type = 'External'
		WHERE ServiceOrderNo < '200000000' --and OrderType = 'M'
		
UPdate #work356	
		Set DaysOpen = DATEDIFF(d,StartDate, GETDATE())
		
Update #work356
	SET [LabourCost] = (SELECT SUM(SM03012 * SM03008) FROM  [ScaCompanyDB]..SM030100 WHERE ServiceOrderNo = SM03001  COLLATE Database_Default)
Update #work356
	SET [LabourInvoice] = (SELECT SUM(SM03044 * SM03008) FROM  [ScaCompanyDB]..SM030100 WHERE ServiceOrderNo= SM03001  COLLATE Database_Default)
Update #work356
	SET [LabourMargin] = (([LabourInvoice] - [LabourCost]) / [LabourCost]) 
	WHERE OrderStatus >= '30' AND [LabourCost] > 0
	
Update #work356
	SET [OtherCost] = (SELECT SUM(SM05024 * SM05009) FROM  [ScaCompanyDB]..SM050100 WHERE ServiceOrderNo = SM05001  COLLATE Database_Default)
Update #work356
	SET [OtherInvoice] = (SELECT SUM(SM05024 * SM05021) FROM  [ScaCompanyDB]..SM050100 WHERE ServiceOrderNo = SM05001  COLLATE Database_Default)
Update #work356
	SET [OtherMargin] = (([OtherInvoice] - [OtherCost]) / [OtherCost]) 
	WHERE OrderStatus >= '30' AND [OtherCost] > 0
	
Update #work356
	SET [MaterialCost] = (SELECT SUM(SM07017 * SM07010) FROM  [ScaCompanyDB]..SM070100 WHERE ServiceOrderNo  = SM07001  COLLATE Database_Default)
Update #work356
	SET [MaterialInvoice] = (SELECT SUM(SM07017 * SM07025) FROM  [ScaCompanyDB]..SM070100 WHERE ServiceOrderNo = SM07001  COLLATE Database_Default)
Update #work356
	SET [MaterialMargin] = (([MaterialInvoice] - [MaterialCost]) / [MaterialCost]) 
	WHERE OrderStatus >= '30' AND [MaterialCost] > 0


SELECT * FROm #work356
	
