USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00293_sel]    Script Date: 10/05/2021 10:58:48 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00293_sel] 
@YearValue  as nvarchar(4),
@Department as  NVARCHAR(256),
@AreaCode NVARCHAR(3) = NULL

AS 

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

BEGIN 

DECLARE @c as VARCHAR(8000),
			@CostCentre as NVARCHAR(64),
			@Single as bit

IF exists (SELECT * FROM dbo.Sysobjects WHERE id = object_id(N'[dbo].[#work_SSRS293]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[#work_SSRS293]
	
	CREATE TABLE dbo.#work_SSRS293
	(
	CustomerCode nvarchar(10) NULL,
	CustomerName nvarchar(35) NULL,
	AreaCode char(3) NULL,
	Abrasive   numeric(38, 6) NULL,	
	Air        numeric(38, 6) NULL,
	Generators numeric(38, 6) NULL,
	[Hand Tools] numeric(38, 6) NULL,
	[Metal Works] numeric(38, 6) NULL,
	[Nail Guns] numeric(38, 6) NULL,
	[Power Tools] numeric(38, 6) NULL,
	Rotomoulding numeric(38, 6) NULL,
	[Safety] numeric(38, 6) NULL,
	Welding numeric(38, 6) NULL,
	Woodworking numeric(38, 6) NULL,
	Workshop numeric(38, 6) NULL,
	Other numeric(38, 6) NULL,
	Total numeric(38, 6) NULL
) ON [PRIMARY]

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

SELECT @c = 'INSERT INTO #Work_SSRS293 '
SELECT @c = @c + 'SELECT  '
SELECT @c = @c + 'SL01001, '
SELECT @c = @c + 'SL01002, '    
SELECT @c = @c + 'KK_AreaCode, '
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIAABR'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), '
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIBAIR'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), '
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIDGDI'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AICHAN'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIEMET'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIGNAI'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIIPOW'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIPROT'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIJSAF'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AIKWEL'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AILWOO'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) =  ''AINWOR'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), ' 
SELECT @c = @c + 'SUM(Case When SUBSTRING(ST03011,13,6) NOT IN(''AIAABR'',''AIBAIR'',''AIDGDI'',''AICHAN'',''AIEMET'',''AIGNAI'',''AIIPOW'',''AIPROT'',''AIJSAF'',''AIKWEL'',''AILWOO'',''AINWOR'') Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End), '
SELECT @c = @c + 'SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) ' 
SELECT @c = @c + 'FROM [ScaCompanyDB]..ST030100  '    
SELECT @c = @c + 'INNER JOIN    [ScaCompanyDB]..SL010100 ' 
SELECT @c = @c + 'ON   ST03008 = SL01001 '
SELECT @c = @c + 'INNER JOIN    [ScaCompanyDB]..SC010100 ' 
SELECT @c = @c + 'ON   ST03017 =  SC01001 '
SELECT @c = @c + 'INNER JOIN    [ScaCompanyDB]..GL0301'  + RIGHT(@YearValue,2) + ' '
SELECT @c = @c + 'ON   Substring(ST03011,13,6) = GL03002 '
SELECT @c = @c + 'LEFT OUTER JOIN  CustomerSalesmanBudget  '
SELECT @c = @c + 'ON  SL01001 = KK_CustomerCode Collate Database_Default ' 
SELECT @c = @c + 'WHERE rtrim(cast(datepart(yyyy,ST03015) as char))   = ' +  @YearValue + ' '
IF @Single = 1 
	SELECT @c = @c + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @CostCentre  +  ' '
Else
	SELECT @c = @c +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @CostCentre + ' '
SELECT @c = @c + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @c = @c + 'AND SUBSTRING(ST03008,1,2) <>  ''ZZ'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
SELECT @c = @c + 'GROUP BY    SL01001, SL01002, KK_AreaCode '
SELECT @c = @c + 'ORDER BY KK_AreaCode, SL01001, SL01002'
--SELECT @c
EXEC (@c)

UPDATE #work_SSRS293
SET AreaCode = '100'
WHERE AreaCode IS NULL

SELECT @c = 'SELECT * FROM #work_SSRS293 '
IF NOT @AreaCode IS NULL
select @c = @c + 'WHERE AreaCode = ' + @AreaCode + ' '
EXEC (@c)
END