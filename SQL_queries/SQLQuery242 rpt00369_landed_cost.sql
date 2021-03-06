USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00369_LandCost]    Script Date: 10/05/2021 14:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00369_LandCost]
		@Stockcode	 as NVARCHAR(50)

AS		
		
SELECT 
	SC07003    "StockCode" 
 ,  SC01002    "Description1" 
 ,  SC01003    "Description2" 
 ,  SC07009    "WH" 
 ,  SC01038    "AltProd"
 ,  SC07006    "SuppCode"
 ,	SC07019    "TranDate"
 ,  SC07005    "Cost"
 ,  COUNT(*) "Count"
  
  FROM [ScaCompanyDB]..SC010100     INNER JOIN    [ScaCompanyDB]..SC070100 
                                  ON   SC01001 = SC07003                                   
  WHERE SC07003   = @Stockcode and SC07019 >= '2010-01-01 00:00:00.000'  and SC07001 = '01'
  GROUP BY  
	   SC07003
	 , SC01002
	 , SC01003
	 , SC07009
	 , SC01038
	 , SC07006 
	 , SC07005 
	 , SC07019 
	 