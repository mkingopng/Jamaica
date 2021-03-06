USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00343-1]    Script Date: 10/05/2021 12:57:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00343-1] 
	-- Add the parameters for the stored procedure here
	--@year as char(4),
	--@month as char(2)
	--@Location as nvarchar (4)
AS
BEGIN
--drop table [KK_StockSuplier]
drop table [dbo].[ST03TEMP]
create table [dbo].[ST03TEMP](
	
	SmanCode			varchar(5),	
	OrderDate			datetime,
	OrderNumber			varchar(15),
	InvoiceNumber       nvarchar(15),
	CostCentre			nvarchar(50),
	StockCode           nvarchar(35),  
	Amount              numeric(28),
	AccString           nvarchar(50)	
	)	
INSERT INTO dbo.ST03TEMP (SmanCode , OrderDate ,OrderNumber, InvoiceNumber , CostCentre, StockCode, Amount, AccString  ) 	
SELECT DISTINCT	 ST03007, ST03015,ST03009, ST03014, ST03011, ST03017, ST03040 , ST03011
FROM ScaCompanyDB..ST030100 WHERE ST03015 > '2010-01-01 00:00:00.000'  

UPDATE ST03TEMP 
SET InvoiceNumber  = '13'+ InvoiceNumber 
WHERE OrderDate  >= '2012-12-29 00:00:00.000'

UPDATE ST03TEMP 
SET InvoiceNumber  = '12'+ InvoiceNumber 
WHERE OrderDate  between '2012-01-01 00:00:00.000' and '2012-12-28 00:00:00.000'
    
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	Declare @YearMonth as CHAR(7), 
	@c as NVARCHAR(4000)
	--SELECT @YearMonth = @year + 'M' + @month

    -- Insert statements for procedure here
drop table [dbo].[RPT343_1]    
CREATE TABLE RPT343_1
(
  Cuscode NVARCHAR(10),
  Name NVARCHAR (50),
  CC NVARCHAR(10),
  GST NVARCHAR (2),
  TranNum NVARCHAR(10),
  InvoiceNo NVARCHAR(10),
  OrderDate DATETIME,
  PayDate DATETIME,
  Amount NUMERIC(10,3),
  SmanCode NVARCHAR(10),
  Final_Amount NUMERIC(10,3)
 ) 
      
INSERT INTO RPT343_1      
SELECT	DISTINCT 
SL21001,SL01002,SUBSTRING(CostCentre,7,6) 
,SL01107 
,SL21004 
,SL21002 
,OrderDate 
,SL21005 
,SL21007
,SmanCode
,SL21007
FROM ScaCompanyDB..SL210100 
INNER JOIN ScaCompanyDB..SL010100 
ON SL21001 = SL01001 
INNER JOIN [dbo].[ST03TEMP] 
ON SL21002 = InvoiceNumber COLLATE DATABASE_DEFAULT 
--INNER JOIN ScaCompanyDB..OR200100 
--ON  OR20001 = OrderNumber COLLATE DATABASE_DEFAULT 
INNER JOIN ScaCompanyDB..SY240100 
ON SY24002 = SmanCode COLLATE DATABASE_DEFAULT 

WHERE SL21005 >= '2012-10-01 00:00:00.000'
--WHERE rtrim(cast(datepart(yyyy,SL21005) as char))+'M'+substring(cast(cast(datepart(mm,SL21005) as INT)+100 as char),2,2)   ='' +  @YearMonth  + ''
AND SUBSTRING(SL21001,1,2) <> 'ZZ' 
--AND SUBSTRING(CostCentre,7,6) IN ('10','20')  
--AND StockCode NOT LIKE '15-03%' 
--AND StockCode NOT LIKE '15-50%' 
--AND StockCode NOT LIKE 'FREIGHT' 

--UPDATE RPT343_1 
--SET Final_Amount = Sell_Price
--FROM IscalaAnalysis.dbo.SSRS311_3 WHERE InvoiceNo = Invoice

--SELECT * from

END
