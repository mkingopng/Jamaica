USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00324_sel_v2z]    Script Date: 10/05/2021 11:29:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/********************************************************************/
/*Isaac 05-03-2014: Modified to capture data from a given date range*/
/*					--a request from Justin Watson					*/
/*Isaac 10-04-2014: Modified to include product group & cost centre */
/*					--a request by Rodel Galano						*/
/*------------------------------------------------------------------*/
ALTER PROCEDURE [dbo].[SSRS_RPT00324_sel_v2z] 
	@ProdGroup NVARCHAR(256) = NULL,
	@StartDate as Datetime=NULL,	/*Isaac 05-03-2014: Start date parameter added*/
	@EndDate as Datetime=NULL		/*Isaac 05-03-2014: End date parameter add*/
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
 SELECT @c =  @c + ',  SY24003    "SalesmName"  '
 SELECT @c =  @c + ',  SL01001    "CustomerCode" ' 
 SELECT @c =  @c + ',  SL01002    "CustomerName"  '
 SELECT @c =  @c + ',  SC01001    "StockCode"  '
 SELECT @c =  @c + ',  SC01002    "Description1" ' 
 SELECT @c =  @c + ',  SC01003    "Description2"  '
 SELECT @c =  @c + ',  SC01037    "ProductGRP"  '
 SELECT @c =  @c + ',  ST01021    "CostCentre"  '
 SELECT @c =  @c + ',  SUM(ST03020)   "Qty"  '
 SELECT @c =  @c + ',  ST03021    "PriceLCU" ' 
 SELECT @c =  @c + ',  SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100))   "NetValue" ' 
 SELECT @c =  @c + ',  su_onhandqty "SOH" '
 SELECT @c =  @c + ',  su_stockhistory "Sales History" '
 SELECT @c =  @c + ',  su_firstorderdate "First Order Date" ' 
 SELECT @c =  @c + 'FROM [ScaCompanyDB]..ST030100 ' /*Invoice Statistics on ScaCompanyDB*/
 SELECT @c =  @c + 'INNER JOIN KK_Rpt00231Data '    /*a join on Slow Moving Stock Summary on IscalaAnalysis*/
 SELECT @c =  @c + '	ON ST03017 = su_item  Collate Database_Default ' /*Collate by Stock Code*/
 SELECT @c =  @c + 'INNER JOIN    [ScaCompanyDB]..SC010100 ' 
 SELECT @c =  @c + '	 ON   ST03017 = SC01001 '   /*a join on Stock Code in Stock Item on ScaCompanyDB*/  
 SELECT @c =  @c + 'INNER JOIN    [ScaCompanyDB]..SL010100 ' /*a join on Customer File on ScaCompanyDB*/
 SELECT @c =  @c + '	ON   ST03008 = SL01001 '			 /*where CustomerCodeInvNo = Customer Code on Customer File*/
 SELECT @c =  @c + 'INNER JOIN    [ScaCompanyDB]..ST010100 ' /*a join on Salesman File on ScaCompanyDB*/
 SELECT @c =  @c + '	ON   ST03007 = ST01001 '			 
 SELECT @c =  @c + 'LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 '		/*a left outer join on General Code File*/                                  
 SELECT @c =  @c + '	ON   ST03007 = SY24002  AND ''BK'' = SY24001 '	/*where Salesman on Invoice Statistics = Key on General Code File*/
																		
 /*Isaac 05-03-2014: Current month date range commented out*/
 -- SELECT @c =  @c + 'WHERE rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' +  @currentmonth  + ''' '
 
 /*Isaac 05-03-2014: Selected date range added:*/
 SELECT @c = @c + 'WHERE ST03015 BETWEEN ''' + CAST(@StartDate as CHAR(20)) + ''' and ''' + CAST(@EndDate as CHAR(20)) + ''' ' 
 SELECT @c =  @c + 'AND SC01001 =''36-31-0011'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0040'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0120'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0121'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0122'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0124'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0153'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0156'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0215'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0216'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0305'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0359'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0360'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0410'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-0411'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-5016'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-5021'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-5060'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-5063'' '
 SELECT @c =  @c + 'OR SC01001 =''36-31-5103'' '
 
 IF @ProdGroup IS NOT NULL
	SELECT @c =  @c + 'AND ST03019 = ''' + @ProdGroup + ''' ' --ST03017 (36-%)
 SELECT @c =  @c + 'AND su_onhandqty > su_stockhistory '
 SELECT @c =  @c + 'AND su_firstorderdate < su_sixmonthsago ' 
 SELECT @c = @c  + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
 SELECT @c = @c  + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
 SELECT @c = @c  + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
 SELECT @c = @c  + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
 SELECT @c =  @c + 'GROUP BY ST03009 , ST03014 , ST03015 , ST03007 , SY24003 , SL01001 , SL01002 , SC01001 , SC01002 , SC01003 , SC01037, ST01021, ST03021 ,su_onhandqty , su_stockhistory , su_firstorderdate '
 SELECT @c =  @c + 'Order By SC01001 '

 EXEC (@c)
 
END
