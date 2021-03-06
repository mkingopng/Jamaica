USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00358_sel]    Script Date: 10/05/2021 13:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 25/01/10
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00358_sel]
	-- Add the parameters for the stored procedure here
	
/* ************************************************* */
@StartDate as Datetime,
@EndDate As Datetime
AS	
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ElectricalWorkOrderRaised]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[ElectricalWorkOrderRaised]

CREATE TABLE ElectricalWorkOrderRaised
	(
		
		JobType						NVARCHAR(35),
		Plastics					NUMERIC(28, 0),
		Chemical					NUMERIC(28, 0),
		Paper    					NUMERIC(28, 0),
		Rotomoulding				NUMERIC(28, 0),
		PET							NUMERIC(28, 0),
		Oil     					NUMERIC(28, 0),
		
	)	


INSERT INTO ElectricalWorkOrderRaised
select 
'Breakdown',(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '10' and JobTypeID = '12') and (RaisedDateTime BETWEEN @StartDate AND @EndDate )),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '7' and JobTypeID = '12') and (RaisedDateTime BETWEEN @StartDate AND @EndDate )),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '14' and JobTypeID = '12') and (RaisedDateTime BETWEEN @StartDate AND @EndDate )),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '15' and JobTypeID = '12') and (RaisedDateTime BETWEEN @StartDate AND @EndDate )),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '16' and JobTypeID = '12') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '9' and JobTypeID = '12') and (RaisedDateTime BETWEEN @StartDate AND @EndDate))

INSERT INTO ElectricalWorkOrderRaised
select 
'Preventive Maintenance',(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '10' and JobTypeID = '13') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '7' and JobTypeID = '13') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '14' and JobTypeID = '13') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '15' and JobTypeID = '13') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '16' and JobTypeID = '13') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '9' and JobTypeID = '13') and (RaisedDateTime BETWEEN @StartDate AND @EndDate))

INSERT INTO ElectricalWorkOrderRaised
select 
'Repair',(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '10' and JobTypeID = '15') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '7' and JobTypeID = '15') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '14' and JobTypeID = '15') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '15' and JobTypeID = '15') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '16' and JobTypeID = '15') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '9' and JobTypeID = '15') and (RaisedDateTime BETWEEN @StartDate AND @EndDate))

INSERT INTO ElectricalWorkOrderRaised
select 
'Project',(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '10' and JobTypeID = '14') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '7' and JobTypeID = '14') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '14' and JobTypeID = '14') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '15' and JobTypeID = '14') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '16' and JobTypeID = '14') and (RaisedDateTime BETWEEN @StartDate AND @EndDate)),(SELECT COUNT (*) 
FROM [MEXDB].[dbo].[WorkOrder] 
where (DepartmentID = '9' and JobTypeID = '14') and (RaisedDateTime BETWEEN @StartDate AND @EndDate))

/*
INSERT INTO #work358 
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

 UPdate #work358	
		Set Type = 'Internal'
		WHERE ServiceOrderNo > '200000000' --and OrderType = 'M'
		
UPdate #work358	
		Set Type = 'External'
		WHERE ServiceOrderNo < '200000000' --and OrderType = 'M'
		
UPdate #work358	
		Set DaysOpen = DATEDIFF(d,StartDate, GETDATE())
		
Update #work358
	SET [LabourCost] = (SELECT SUM(SM03012 * SM03008) FROM  [ScaCompanyDB]..SM030100 WHERE ServiceOrderNo = SM03001  COLLATE Database_Default)
Update #work358
	SET [LabourInvoice] = (SELECT SUM(SM03044 * SM03008) FROM  [ScaCompanyDB]..SM030100 WHERE ServiceOrderNo= SM03001  COLLATE Database_Default)
Update #work358
	SET [LabourMargin] = (([LabourInvoice] - [LabourCost]) / [LabourCost]) 
	WHERE OrderStatus >= '30' AND [LabourCost] > 0
	
Update #work358
	SET [OtherCost] = (SELECT SUM(SM05024 * SM05009) FROM  [ScaCompanyDB]..SM050100 WHERE ServiceOrderNo = SM05001  COLLATE Database_Default)
Update #work358
	SET [OtherInvoice] = (SELECT SUM(SM05024 * SM05021) FROM  [ScaCompanyDB]..SM050100 WHERE ServiceOrderNo = SM05001  COLLATE Database_Default)
Update #work358
	SET [OtherMargin] = (([OtherInvoice] - [OtherCost]) / [OtherCost]) 
	WHERE OrderStatus >= '30' AND [OtherCost] > 0
	
Update #work358
	SET [MaterialCost] = (SELECT SUM(SM07017 * SM07010) FROM  [ScaCompanyDB]..SM070100 WHERE ServiceOrderNo  = SM07001  COLLATE Database_Default)
Update #work358
	SET [MaterialInvoice] = (SELECT SUM(SM07017 * SM07025) FROM  [ScaCompanyDB]..SM070100 WHERE ServiceOrderNo = SM07001  COLLATE Database_Default)
Update #work358
	SET [MaterialMargin] = (([MaterialInvoice] - [MaterialCost]) / [MaterialCost]) 
	WHERE OrderStatus >= '30' AND [MaterialCost] > 0
--Update #work358 
  --  SET [StockCode] = (SELECT SM07004 FROM  [ScaCompanyDB]..SM070100 WHERE ServiceOrderNo = SM07001)--  COLLATE Database_Default)
    
*/
SELECT * FROM ElectricalWorkOrderRaised
	
