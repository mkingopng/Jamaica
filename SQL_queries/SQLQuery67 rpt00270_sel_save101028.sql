USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00270_sel_save101028]    Script Date: 10/05/2021 10:55:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 		5/6/2009
-- Description:		Salesman Commmision Report - To be run each month and distributed to payroll
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00270_sel_save101028]
	@Year as NVARCHAR(4),
	@Month as NVARCHAR(2)
AS
BEGIN
	DECLARE @YearMonth as nvarchar(7)
	SELECT @YearMonth = @Year + 'M' + @Month
	SET NOCOUNT ON;	

	SELECT
    		T1.ST03007    "Salesman"
 , 		 T2.SY24003    "Salesm Name"
 , 		 SUM((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100))   "Net Value"
 ,		 SUM(T1.ST03020 * T1.ST03023)   "Cost Value"
 , 		 SUM(((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100)) - (T1.ST03020 * T1.ST03023))   "Net Profit",
		@YearMonth  "Year Month"
	 FROM [ScaCompanyDB]..SY240100 T2    RIGHT OUTER JOIN    [ScaCompanyDB]..ST030100 T1
                 ON   T2.SY24002 = T1.ST03007  AND T2.SY24001 = 'BK'
	WHERE rtrim(cast(datepart(yyyy,T1.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)   =  @YearMonth
   --WHERE T1.ST03015 BETWEEN '2009-09-01' and '2010-04-30' 
	GROUP BY
  	 T1.ST03007
 ,	 T2.SY24003
	ORDER BY SY24003
END