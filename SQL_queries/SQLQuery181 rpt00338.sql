USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00338_sel]    Script Date: 10/05/2021 12:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00338_sel]
	-- Add the parameters for the stored procedure here
	@Department	 as NVARCHAR(256),
	@BaseYear as CHAR(4), 
	@CompareYear CHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @c AS NVARCHAR(4000),
			@CostCentre as NVARCHAR(64),
			@Single as bit
		
	
	-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
	-- The users supplies the Division/Department and we apply the cost centres
	SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
	SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
	
	CREATE TABLE [dbo].[#work338](
	[CustomerCode] [nchar](10) NOT NULL,
	[CustomerName] [nvarchar](35) NOT NULL,
	[AreaCode] NVARCHAR(3),
	[BaseYear] [numeric](38, 8) NULL,
	[CompareYear] [numeric](38, 8) NULL
) ON [PRIMARY]

	
    -- Insert statements for procedure here
    SELECT @c = 'INSERT INTO #work338 '
	SELECT @c =  @c + 'SELECT  '
    SELECT @c =  @c + 'SL01001 '
    SELECT @c =  @c + ',  SL01002  '
    SELECT @c =  @c + ', KK_AreaCode  '
    SELECT @c =  @c + ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =' + @BaseYear + ' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)     ' 
     SELECT @c = @c + ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char)) =' + @CompareYear + ' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   ' 
    SELECT @c =  @c + 'FROM [ScaCompanyDB]..ST030100 '     
    SELECT @c =  @c + 'INNER JOIN    [ScaCompanyDB]..SL010100 ' 
    SELECT @c =  @c + 'ON   ST03008 = SL01001 '
    SELECT @c =  @c + 'INNER JOIN    [ScaCompanyDB]..SC010100 ' 
    SELECT @c =  @c + 'ON   ST03017 = SC01001 '
    SELECT @c = @c +  'INNER JOIN  KK_Departments '
	SELECT @c = @c +  ' ON   Department = ''' + @Department + ''' '
	SELECT @c = @c + 'LEFT OUTER JOIN  CustomerSalesmanBudget '
	--SELECT @c2 = @c2 + ' ON   SL01001 = KK_CustomerCode Collate Database_Default AND SUBSTRING(KK_AreaCode,1,2) = ' +  @costcentre + ' '
	SELECT @c = @c + ' ON   SL01001 = KK_CustomerCode Collate Database_Default '
    SELECT @c = @c + 'WHERE SUBSTRING(ST03008,1,4) <>  ''INTR'' '
    SELECT @c = @c + 'AND SUBSTRING(ST03008,1,3) <>  ''ZZZ'' '
	SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
	SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
	SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
	IF @Single = 1 
		SELECT @c = @c + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
	Else
		SELECT @c = @c +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
	SELECT @c =  @c + 'GROUP BY SL01001, SL01002, KK_AreaCode '
	
    EXEC (@c)
    
    UPDATE #work338
	SET Areacode = '100'
	WHERE Areacode IS NULL
	
	SELECT * FROM #work338

END
