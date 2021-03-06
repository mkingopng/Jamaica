USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00308_sel]    Script Date: 10/05/2021 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Wayne Dunn 16/6/2010
--Written as exec commands so values can be calculated
-- Contract customer reporting

ALTER PROCEDURE [dbo].[SSRS_RPT00308_sel] 
	@yearvalue CHAR(4)= null
AS

DECLARE @cmd as VARCHAR(8000)

SET NOCOUNT ON

SELECT @cmd = 'SELECT '
SELECT @cmd = @cmd + 'SL01001    "CustomerCode", '
SELECT @cmd = @cmd + 'SL01002    "CustomerName",' 
SELECT @cmd = @cmd + 'SUBSTRING(ST03011,13,6)    "Product",' 
SELECT @cmd = @cmd + 'GL03003    "Description", '
SELECT @cmd = @cmd + ' ''' + @yearvalue + ''' as SelectedYear, '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "Jan", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "Feb", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "Mar", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "Apr", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "May",'
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "Jun", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "Jul", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "Aug", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)   "Sep", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)  "Oct", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)  "Nov", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)  "Dec", '   
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M01'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Jan Margin", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M02'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Feb Margin", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M03'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)   "Mar Margin", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M04'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)   "Apr Margin", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M05'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "May Margin", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M06'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Jun Margin", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M07'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Jul Margin", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M08'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Aug Margin", ' 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M09'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Sep Margin", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M10'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Oct Margin", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M11'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Nov Margin", '
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + @yearvalue + 'M12'' Then ((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100)) - (ST03020 * ST03023) End)  "Dec Margin" '
SELECT @cmd = @cmd + 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @cmd = @cmd + 'INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @cmd = @cmd + ' ON   ST03008 = SL01001 '
 --INNER JOIN    [ScaCompanyDB]..ST010100 T4
 --ON   T3.ST03007 = T4.ST01001
SELECT @cmd = @cmd + 'INNER JOIN    [ScaCompanyDB]..GL030110 '
SELECT @cmd = @cmd + 'ON  SUBSTRING(ST03011,13,6) = GL03002 '
SELECT @cmd = @cmd + 'WHERE rtrim(cast(datepart(yyyy,ST03015) as char)) = ''' + @yearvalue + ''' '
SELECT @cmd = @cmd + 'AND   SL01001   IN  (''KAVLIH'',''LAEMOEX'',''LAEOIL'',''LAEHIDD'',''LAEWAFI'',''NADHIG1'',''POMFRI'',''POMPARS'',''POMCHIY'',''LAECLOU'', ''LAEMCJV'',''POMSPIE2'',''KAVSIMB'',''ALOWOO'',''KIMNEW'',''TABOKT'',''POMKIK'',''POMPNG6'',''LAEPNG9'',''POMCAR1'',''HAGPOR'',''MADHIG1'',''POMDOM'',''CSLRAM'') '
SELECT @cmd = @cmd + 'AND SUBSTRING(ST03011,7,2) IN (''10'',''20'') '
SELECT @cmd = @cmd + 'GROUP BY SL01001, SL01002, SUBSTRING(ST03011,13,6), GL03003'
 
--SELECT @cmd

Execute (@cmd)