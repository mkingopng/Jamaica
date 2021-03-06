USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00339_SEL]    Script Date: 10/05/2021 12:54:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00339_SEL]
		@Department	 as NVARCHAR(256),
		@AreaCode  as CHAR(3) = NULL 
		
AS
		DECLARE @c as VARCHAR(8000),
			@CostCentre as NVARCHAR(64),
			@Single as bit,
			@year as integer
			
SELECT @year = YEAR(GETDATE())

CREATE TABLE [dbo].[#work_SSRS339](
	[CustomerCode] [nchar](10) NOT NULL,
	[CustomerName] [nvarchar](35) NOT NULL,
	[AddressLine1] [nvarchar](35) NOT NULL,
	[AddressLine2] [nvarchar](35) NOT NULL,
	[AddressLine3] [nvarchar](35) NOT NULL,
	[AddressLine4] [nvarchar](35) NOT NULL,
	TelephoneNo NVARCHAR(20),
	Areacode NCHAR(3),
	YEAR NUMERIC(28,8), 
	YEARMINUS1 NUMERIC(28,8), 
	YEARMINUS2 NUMERIC(28,8), 
	YEARMINUS3 NUMERIC(28,8), 
	YEARMINUS4 NUMERIC(28,8), 
) ON [PRIMARY]

CREATE TABLE [dbo].[#work_SSRS3392](
	[wCustomerCode] [nchar](10) NOT NULL,
	wYEAR NUMERIC(28,8), 
	wYEARMINUS1 NUMERIC(28,8), 
	wYEARMINUS2 NUMERIC(28,8), 
	wYEARMINUS3 NUMERIC(28,8), 
	wYEARMINUS4 NUMERIC(28,8), 
) ON [PRIMARY]


-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT @c = 'INSERT INTO #work_SSRS339 '
	SELECT @c = @c + 'SELECT '
    SELECT @c = @c + 'SL01001   '
	SELECT @c = @c + ',  SL01002 '
	SELECT @c = @c + ',  SL01003 '
	SELECT @c = @c + ',  SL01004 '
	SELECT @c = @c + ',  SL01005 '
	SELECT @c = @c + ',  SL01099 '
	SELECT @c = @c + ',  SL01011 '
	SELECT @c = @c + ',  KK_AreaCode '
	SELECT @c = @c + ',  0 '
	SELECT @c = @c + ' , 0 '
	SELECT @c = @c + ' , 0 '
	SELECT @c = @c + ' , 0 '
	SELECT @c = @c + ' , 0 '
 	SELECT @c = @c + 'FROM [ScaCompanyDB]..SL010100 ' 
 	SELECT @c = @c + 'LEFT OUTER JOIN  CustomerSalesmanBudget '
    --SELECT @c = @c + 'ON ST03008 = KK_CustomerCode Collate Database_Default AND SUBSTRING(KK_AreaCode,1,2) = ' +  @costcentre + ' '
	SELECT @c = @c + ' ON   SL01001 = KK_CustomerCode Collate Database_Default '
	EXEC (@c)
SELECT @c = 'INSERT INTO #work_SSRS3392 '
SELECT @c = @c + 'SELECT ST03008 "wCustomerNumber" '
SELECT @c = @c + ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + CAST(@year as CHAR(4)) + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) ' 
SELECT @c = @c + ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + CAST((@year -1) as CHAR(4)) + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) '
SELECT @c = @c + ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + CAST((@year -2) as CHAR(4)) + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) '
SELECT @c = @c + ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + CAST((@year -3) as CHAR(4)) + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) '
SELECT @c = @c + ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =  ''' + CAST((@year -4) as CHAR(4)) + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) '
SELECT @c = @c + 'FROM ScaCompanyDB..ST030100 '
SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SC010100 '
SELECT @c = @c + 'ON ST03017 = SC01001 '
IF @Single = 1 
		SELECT @c = @c + 'WHERE SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
	Else
		SELECT @c = @c +  'WHERE SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
SELECT @c = @c + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @c = @c + 'AND SUBSTRING(ST03008,1,3) <>  ''ZZZ'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
SELECT @c = @c + 'GROUP BY ST03008'
EXEC (@c)

UPDATE  #work_SSRS339 
SET YEAR = wYEAR,
	YEARMINUS1 = wYEARMINUS1,
	YEARMINUS2 = wYEARMINUS4,
	YEARMINUS3 = wYEARMINUS3,
	YEARMINUS4 = wYEARMINUS4

FROM #work_SSRS3392
WHERE CustomerCode = wCustomerCode

UPDATE  #work_SSRS339 
	SET Areacode = '100'
	WHERE Areacode IS NULL

SELECT @c = 'SELECT * FROM #work_SSRS339 '
SELECT @c = @c + 'WHERE SUBSTRING(CustomerCode,1,2) <>  ''ZZ'' '
SELECT @c = @c + 'AND SUBSTRING(CustomerCode,1,4) <>  ''INTR'' '
SELECT @c = @c + 'AND CustomerCode <>  ''''  '
IF @AreaCode IS NOT NULL
	SELECT @c = @c + 'AND Areacode = ''' +  @AreaCode + ''' '
	
EXEC (@c)

--DROP Table #work_SSRS399
--DROP Table #work_SSRS3992
END