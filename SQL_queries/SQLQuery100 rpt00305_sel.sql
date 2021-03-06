USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00305_sel]    Script Date: 10/05/2021 11:08:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 11/05/2010
-- Description:	YTD/MTD Welding Equipment report
--				Uses Department as a Parameter tp select CC etc
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00305_sel] 
	-- Add the parameters for the stored procedure here
	@department	 as NVARCHAR(256)
	
AS
BEGIN 
/* ************************************************* */ 
DECLARE @Year as NVARCHAR(4),
		@Search as NVARCHAR(2048),
		@ThisMonth as NVARCHAR(7),
		@CostCentre as NVARCHAR(256),
		@Period as CHAR(2),
		@Single as bit
		
-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

SELECT @Year = Year(Getdate())
--SELECT @Year = YEAR(DATEADD(yy, -1,(Getdate())))
SELECT @ThisMonth =  rtrim(cast(datepart(yyyy,GETDATE()) as char))+ 'M' + substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2) 	
	
SELECT @search =  'SELECT '
SELECT @Search = @Search + 'substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)    "Period" ' 
SELECT @Search = @Search + ', rtrim(cast(datepart(yyyy,T1.ST03015) as char))+ ''M''+substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)    "Date\Month" ' 
SELECT @Search = @Search + ',  T2.SL01001    "CustomerCode" ' 
SELECT @Search = @Search + ',  T2.SL01002    "CustomerName" ' 
SELECT @Search = @Search + ',  T3.SC01001    "StockCode" ' 
SELECT @Search = @Search + ',  T3.SC01002    "Description1" ' 
SELECT @Search = @Search + ',  T3.SC01003    "Description2" ' 
SELECT @Search = @Search + ',  T1.ST03007    "Salesman" ' 
SELECT @Search = @Search + ',  T4.SY24003    "Salesm Name" ' 
SELECT @Search = @Search + ',  SUBSTRING(T1.ST03011,7,6)    "Cost Centre" ' 
SELECT @Search = @Search + ', SUM(T1.ST03020)   "Qty" ' 
SELECT @Search = @Search + ', SUM((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100))   "Net Value" ' 
SELECT @Search = @Search + ', SUM(((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100)) - (T1.ST03020 * T1.ST03023))   "Net Profit" ' 
SELECT @Search = @Search + ', ''' +  @department +  ''' "Division" ' 
SELECT @Search = @Search + ' FROM [ScaCompanyDB]..ST030100 T1 '    
SELECT @Search = @Search + ' INNER JOIN    [ScaCompanyDB]..SC010100 T3 '
SELECT @Search = @Search + ' ON   T1.ST03017 = T3.SC01001 '
SELECT @Search = @Search + ' INNER JOIN    [ScaCompanyDB]..SL010100 T2 '
SELECT @Search = @Search + ' ON   T1.ST03008 = T2.SL01001 '
SELECT @Search = @Search + ' LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T4 '
SELECT @Search = @Search + ' ON   T1.ST03007 = T4.SY24002  AND ''BK'' = T4.SY24001 '
IF @Single = 1 
	SELECT @search = @search +  'WHERE SUBSTRING(ST03011,7,2)  =  ' +  @costcentre  +  ' '
Else
	SELECT @search = @search +  'WHERE SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
--SELECT @Search = @Search + ' WHERE SUBSTRING(T1.ST03011,7,6)   IN(''10'',''20'') '
SELECT @Search = @Search + ' AND   rtrim(cast(datepart(yyyy,T1.ST03015) as char))   =''' +   @Year + ''''
SELECT @Search = @Search + ' AND   T3.SC01039   LIKE ''%AIKWEL%'''
SELECT @Search = @Search + ' GROUP BY ' 
SELECT @Search = @Search + ' substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2) ' 
SELECT @Search = @Search + ', rtrim(cast(datepart(yyyy,T1.ST03015) as char))+ ''M'' +substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)'
SELECT @Search = @Search + ', T2.SL01001 '
SELECT @Search = @Search + ', T2.SL01002 '
SELECT @Search = @Search + ', T3.SC01001 '
SELECT @Search = @Search + ', T3.SC01002 '
SELECT @Search = @Search + ', T3.SC01003 '
SELECT @Search = @Search + ', T1.ST03007 '
SELECT @Search = @Search + ', T4.SY24003 '
SELECT @Search = @Search + ', SUBSTRING(T1.ST03011,7,6)'
--SELECT @Search = @Search + ', ' +  @department + ' '
--SELECT @search
EXEC (@search)
END 


