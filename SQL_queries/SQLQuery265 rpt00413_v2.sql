USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00413_sel_v2]    Script Date: 10/05/2021 14:15:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SSRS_RPT00413_sel_v2] 
	@StartDate as Datetime=NULL,
	@EndDate as Datetime=NULL,
	@CostCentre as NVARCHAR(3),
	@Salesman as NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @c as NVARCHAR(4000),
			@currentmonth as CHAR(7)	
 
 SELECT @currentmonth = rtrim(cast(datepart(yyyy,GETDATE()) as char))+ 'M' + substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2) 

 SELECT @c = 'SELECT '
 SELECT @c =  @c + '   ST03017    "StockCode" '
 SELECT @c =  @c + ',  SC01002    "Description1" ' 
 SELECT @c =  @c + ',  SC01003    "Description2"  '
 SELECT @c =  @c + ',  ST03020    "Qty"  '
 SELECT @c =  @c + ',  ST03009    "OrderNumber"  '
 SELECT @c =  @c + ',  ST03014    "InvoicNumber" '
 SELECT @c =  @c + ',  ST03015    "InvOrderDate" '
 SELECT @c =  @c + ',  ST03011    "AccCodeStr" '
 SELECT @c =  @c + ',  ST03001    "CustomerCode" '
 SELECT @c =  @c + ',  SL01002    "CustomerName" '
 SELECT @c =  @c + ',  ST01002    "Salesman" '
 SELECT @c =  @c + ',  ST01021    "CostCentre" '
 SELECT @c =  @c + 'FROM ScaCompanyDB..ST030100 '
 SELECT @c =  @c + 'INNER JOIN ScaCompanyDB..SL010100 ON ST03001=SL01001 '
 SELECT @c =  @c + 'INNER JOIN ScaCompanyDB..ST010100 ON ST03007=ST01001 '
 SELECT @c =  @c + 'LEFT OUTER JOIN ScaCompanyDB..SC010100 ON ST03017=SC01001 '
 SELECT @c =  @c + 'WHERE ST03015 BETWEEN ''' + CAST(@StartDate as CHAR(20)) + ''' and ''' + CAST(@EndDate as CHAR(20)) + ''' ' 
 SELECT @c =  @c + '	    AND ST01021 =11 or ST01021=21 '
 SELECT @c =  @c + 'GROUP BY ST03009, ST03014 , ST03015 , ST03017 , ST03011 , ST03001 , SL01002 , ST01002 , ST01021 , SC01002 , SC01003 , ST03020 '
 SELECT @c =  @c + 'Order By ST03017 '

 EXEC (@c)
 
END

