USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00315_sel]    Script Date: 10/05/2021 11:21:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wayne Dunn
-- Create date: 25/01/10
-- Description:	ustomer Sales By Month By Cost Center
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00315_sel]
	-- Add the parameters for the stored procedure here
	@Department as nvarchar(256),
	@YearValue NVARCHAR(4)
AS
/* ************************************************* */

DECLARE @command as NVARCHAR(4000),
	@CostCentre as NVARCHAR(256),
	@Single as bit

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)

SET ANSI_NULLS ON
SET NOCOUNT ON
SELECT @Command = 'SELECT '
SELECT @command = @command +  ' SC01001 As StockCode '
SELECT @command = @command +  ',  SC01002 + '' '' + SC01003  as Description '
SELECT @command = @command +  ',  SC01038  as AltPrdGrp '
SELECT @command = @command +  ',  SY24003  as AltDescription '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M01' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Jan '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M02' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as  Feb '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M03' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Mar '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M04' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Apr ' 
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M05' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as May '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M06' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Jun '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M07' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Jul '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M08' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Aug '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M09' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Sep '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M10' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Oct '
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M11' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Nov'
SELECT @command = @command +  ', SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M'' + substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) =  ''' + @yearvalue + 'M12' + ''' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) as Dec '
SELECT @command = @command +  ', SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) as Total '
SELECT @command = @command +  'FROM [ScaCompanyDB]..ST030100 '
SELECT @command = @command +  'INNER JOIN    [ScaCompanyDB]..SC010100 ON   ST03017 = SC01001  '
SELECT @command = @command +  'LEFT OUTER JOIN  [ScaCompanyDB]..SY240100 T3   ON   SC01038 = SY24002  AND ''IB'' = SY24001   '
IF @Single = 1 
	SELECT @command= @command +  'WHERE SUBSTRING(ST03011,7,2)  =  ''' +  @costcentre  +  ''' '
Else
	SELECT @command= @command +  'WHERE SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
SELECT @command = @command +  'AND rtrim(cast(datepart(yyyy,ST03015) as char)) = ''' + @YearValue + ''' '
SELECT @command = @command +  'AND NOT SUBSTRING(ST03008,1,4) = ''INTR'''
SELECT @command = @command +  'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
SELECT @command = @command +  'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
SELECT @command = @command +  'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
SELECT @command = @command +  'GROUP BY  SC01038, SY24003,SC01001, SC01002, SC01003 '
SELECT @command = @command +  'ORDER BY SC01038, SC01001, SC01002' 
--SELECT @command
EXEC (@command)