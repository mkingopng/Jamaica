USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00359_sel_ST03]    Script Date: 10/05/2021 13:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00359_sel_ST03] 
	--@department			NVARCHAR(256),
	--@supplier			NVARCHAR(20)= NULL
	--@warehouse_code			NVARCHAR(10)= NULL
	
AS	
BEGIN
	
drop table [dbo].[ST03TEMP]
create table [dbo].[ST03TEMP](
	
		SmanCode			varchar(5),	
		OrderDate			datetime,
		OrderNumber			nvarchar(15),
		InvoiceNumber       nvarchar(15),
		CostCentre			nvarchar(50)
		)	
		INSERT INTO dbo.ST03TEMP (SmanCode , OrderDate , OrderNumber , InvoiceNumber , CostCentre ) 	
	SELECT 	 ST03007, ST03015, ST03009, ST03014, ST03011
 FROM ScaCompanyDB..ST030100 WHERE ST03015 > '2011-01-01 00:00:00.000'
UPDATE ST03TEMP 
SET InvoiceNumber  = '11'+ InvoiceNumber 
WHERE OrderDate  > '2011-01-01 00:00:00.000'
END
