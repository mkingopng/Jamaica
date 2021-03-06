USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00283_sel]    Script Date: 10/05/2021 10:57:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00283_sel] 
	@CostCentre as CHAR(20)
AS
	DECLARE @MonthYear as NVARCHAR(7)
	DECLARE @Year as NVARCHAR(4)
	DECLARE @Month as NVARCHAR(2) 
	SELECT @Year = DATEPART(Year, GETDATE())
	SELECT @Month =  DATEPART(month, GETDATE())
	SELECT @MonthYear = @Year + 'M' + @Month

SELECT
    T1.ST03009    "OrderNumber"
 ,  T1.ST03014    "InvoicNumber"
 ,  T1.ST03015    "InvOrderDate"
 ,  T2.SY24003    "Salesm Name"
 ,  T3.SY24003    "ProdGrp Descr"
 , SUM((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100))   "Net Value"

 FROM [ScaCompanyDB]..ST030100 T1    INNER JOIN    [ScaCompanyDB]..SC010100 T4
                                  ON   T1.ST03017 = T4.SC01001

                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T2
                                  ON   T1.ST03007 = T2.SY24002  AND 'BK' = T2.SY24001

                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T3
                                  ON   T4.SC01037 = T3.SY24002  AND 'IB' = T3.SY24001

WHERE SUBSTRING(T1.ST03011,7,6)   =  @CostCentre
AND   rtrim(cast(datepart(yyyy,T1.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)   =  @MonthYear

GROUP BY
   T1.ST03009
 , T1.ST03014
 , T1.ST03015
 , T2.SY24003
 , T3.SY24003