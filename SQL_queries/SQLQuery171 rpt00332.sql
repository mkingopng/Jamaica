USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00332_sel]    Script Date: 10/05/2021 11:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00332_sel]
	@StartDate DateTime, 
	@SupplierCode NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
    T3.SY24003    "Salesm Name" 
 , SUM((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100))   "Net Value"  
 FROM [ScaCompanyDB]..ST030100 T1    
 INNER JOIN    [ScaCompanyDB]..SC010100 T2
 ON   T1.ST03017 = T2.SC01001 
 LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T3
 ON   T1.ST03007 = T3.SY24002  AND 'BK' = T3.SY24001 
WHERE T1.ST03015   >  @StartDate
AND   T2.SC01058   =  @SupplierCode
  
GROUP BY  
   T3.SY24003

END
