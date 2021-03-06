USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00316_sel]    Script Date: 10/05/2021 11:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_Rpt00316_sel] 
	-- Add the parameters for the stored procedure here
	@YearValue NVARCHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
DECLARE @cmd as NVARCHAR(4000)
	
SELECT @cmd = ' SELECT '
SELECT @cmd = @cmd + 'T1.SC01001    "StockCode" '
SELECT @cmd = @cmd + ',  T1.SC01002 + '' '' + T1.SC01003    "Description"  '
SELECT @cmd = @cmd + ' ,  T1.SC01058    "SupplierCode" '
SELECT @cmd = @cmd + ' ,  T3.PL01002    "SupplierName" '
SELECT @cmd = @cmd + ' ,  T4.SC03010    "ROL" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M01' + ''' Then T2.SC07004 End))   "Jan" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M02' + ''' Then T2.SC07004 End))   "Feb" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M03' + ''' Then T2.SC07004 End))   "Mar" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M04' + ''' Then T2.SC07004 End))   "Apr" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M05' + ''' Then T2.SC07004 End))   "May" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M06' + ''' Then T2.SC07004 End))   "Jun" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M07' + ''' Then T2.SC07004 End))   "Jul" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M08' + ''' Then T2.SC07004 End))   "Aug" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M09' + ''' Then T2.SC07004 End))   "Sep" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M10' + ''' Then T2.SC07004 End))   "Oct" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M11' + ''' Then T2.SC07004 End))   "Nov" '
SELECT @cmd = @cmd + ' , ABS(SUM(Case When rtrim(cast(datepart(yyyy,T2.SC07002) as char))+''M''+substring(cast(cast(datepart(mm,T2.SC07002) as INT)+100 as char),2,2)=  ''' + @yearvalue + 'M12' + ''' Then T2.SC07004 End))   "Dec" '
SELECT @cmd = @cmd + ' FROM [ScaCompanyDB]..SC010100 T1 '   
SELECT @cmd = @cmd + ' INNER JOIN    [ScaCompanyDB]..SC070100 T2    ON   T1.SC01001 = T2.SC07003 '
SELECT @cmd = @cmd + ' INNER JOIN    [ScaCompanyDB]..PL010100 T3    ON   T1.SC01058 = T3.PL01001 '
SELECT @cmd = @cmd + ' INNER JOIN    [ScaCompanyDB]..SC030100 T4    ON   T1.SC01001 = T4.SC03001 AND SC03002 = ''06'' '
SELECT @cmd = @cmd + ' WHERE T2.SC07001   =  ''01'' '
SELECT @cmd = @cmd + ' AND   T2.SC07009   =  ''06'' '
SELECT @cmd = @cmd + ' AND   rtrim(cast(datepart(yyyy,T2.SC07002) as char)) =  ''' + @YearValue + ''' '
SELECT @cmd = @cmd + ' GROUP BY  T1.SC01001 , T1.SC01002, T1.SC01003, T1.SC01058, T3.PL01002, T4.SC03010 ' 
SELECT @cmd = @cmd + ' ORDER BY  T1.SC01001 '
END

EXEC(@cmd)
