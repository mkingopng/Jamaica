USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00016]    Script Date: 10/04/2021 14:30:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00016]
	-- Add the parameters for the stored procedure here
     AS
BEGIN
SELECT 
   SC01001    "StockCode" 
 ,  SC01002 + ' ' +  SC01003 "Description"
 , SC01061 "ROL"
 , SUM(Case When SC03002 =  '02' Then SC03003 End )   "WH2 CS" 
 , SUM( Case When SC03002 =  '03' Then SC03003 End )   "WH03 POM" 
 , SUM( Case When SC03002 =  '05' Then SC03003 End )   "WH05 Lae" 
 , SUM( Case When SC03002 =  '12' Then SC03003 End)    "WH 12 POM/Lae" 
 , SUM( Case When SC03002 =  '13' Then SC03003 End )   "WH 13 Lae/POM" 
 --, SC01044 "Backorder"
 -- , SC01043 "ReservedQty"
FROM [ScaCompanyDB]..SC010100    
 INNER JOIN    [ScaCompanyDB]..SC030100 
 ON   SC01001 = SC03001
 WHERE SC01001   LIKE '12%'
 GROUP BY SC01001, SC01002, SC01003, SC01061
 --,SC01044,SC01043

end
