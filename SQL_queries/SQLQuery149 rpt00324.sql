USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00324_sel]    Script Date: 10/05/2021 11:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00324_sel] 
	@ProdGroup NVARCHAR(256) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @c as NVARCHAR(4000),
	@currentmonth as CHAR(7)	

 
 SELECT @currentmonth = rtrim(cast(datepart(yyyy,GETDATE()) as char))+ 'M' + substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2) 

 SELECT @c = 'SELECT '
 SELECT @c =  @c + '   ST03009    "OrderNumber" '
 SELECT @c =  @c + ',  ST03014    "InvoicNumber" '
 SELECT @c =  @c + ',  ST03015    "InvOrderDate" '
 SELECT @c =  @c + ',  ST03007    "Salesman" '
 SELECT @c =  @c + ',  SY24003    "Salesm Name"  '
 SELECT @c =  @c + ',  SL01001    "CustomerCode" ' 
 SELECT @c =  @c + ',  SL01002    "CustomerName"  '
 SELECT @c =  @c + ',  SC01001    "StockCode"  '
 SELECT @c =  @c + ',  SC01002    "Description1" ' 
 SELECT @c =  @c + ',  SC01003    "Description2"  '
 SELECT @c =  @c + ',  SUM(ST03020)   "Qty"  '
 SELECT @c =  @c + ',  ST03021    "PriceLCU" ' 
 SELECT @c =  @c + ',  SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100))   "Net Value" ' 
 SELECT @c =  @c + ',  su_onhandqty "SOH" '
 SELECT @c =  @c + ',  su_stockhistory "Sales History" '
 SELECT @c =  @c + ',  su_firstorderdate "First Order Date" ' 
 SELECT @c =  @c + 'FROM [ScaCompanyDB]..ST030100 ' 
 SELECT @c =  @c + 'INNER JOIN KK_Rpt00231Data '   
 SELECT @c =  @c + '	ON ST03017 = su_item  Collate Database_Default ' 
 SELECT @c =  @c + 'INNER JOIN    [ScaCompanyDB]..SC010100 ' 
 SELECT @c =  @c + '	 ON   ST03017 = SC01001 ' 
 SELECT @c =  @c + 'INNER JOIN    [ScaCompanyDB]..SL010100 ' 
 SELECT @c =  @c + '	ON   ST03008 = SL01001 '
 SELECT @c =  @c + 'LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 '                                   
 SELECT @c =  @c + '	ON   ST03007 = SY24002  AND ''BK'' = SY24001 '
 SELECT @c =  @c + 'WHERE rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' +  @currentmonth  + ''' '
 IF @ProdGroup IS NOT NULL
	SELECT @c =  @c + 'AND ST03019 = ''' + @ProdGroup + ''' ' --ST03017 (36-%)
 SELECT @c =  @c + 'AND su_onhandqty > su_stockhistory '
 SELECT @c =  @c + 'AND su_firstorderdate < su_sixmonthsago ' 
 SELECT @c = @c  + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
 SELECT @c = @c  + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
 SELECT @c = @c  + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
 SELECT @c = @c  + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
 SELECT @c =  @c + 'GROUP BY ST03009 , ST03014 , ST03015 , ST03007 , SY24003 , SL01001 , SL01002 , SC01001 , SC01002 , SC01003 , ST03021 ,su_onhandqty , su_stockhistory , su_firstorderdate '
 SELECT @c =  @c + 'Order By SC01001 '
 
 EXEC (@c)
 
END
