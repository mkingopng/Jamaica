USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00311_Allv2]    Script Date: 10/05/2021 11:12:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================================
-- Author:		Isaac Kababa
-- Create date: 23/8/2017
-- Description:	extract all sales data ranging 3 years for sales comparision
-- ============================================================================
ALTER PROCEDURE [dbo].[SSRS_RPT00311_Allv2] 
		@Department	 as NVARCHAR(256),
		@year integer
		
AS
	DECLARE @cmd as VARCHAR(8000),
			@cmd2 as VARCHAR(8000),
			@CostCentre as NVARCHAR(64),
			@Single as bit

   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311v2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[work_SSRS311v2]
	
	CREATE TABLE [dbo].[work_SSRS311v2](
	[CustomerCode] [nchar](10) NOT NULL,		--Customer Code
	[CustomerName] [nvarchar](35) NOT NULL,		--Customer Name
	[StockCode] [nvarchar](35) NULL,			--Stockcode
	[Description1] [nvarchar](25) NULL,			--Description1
	[Description2] [nvarchar](25) NULL,			--Description2
	[Department] [nvarchar](50) NOT NULL,		--Department/CostCentre Name
	[Year] [varchar](4) NOT NULL,				--Year
	[AccountCode] [nvarchar](6) NULL,			--AccountCode
	[CostCentre] [nvarchar] (4) NULL,			--CostCentre Code
	[JanTA] [numeric](38, 6) NULL, --Total Sales Jan Year
	--[FebTA] [numeric](38, 6) NULL, --Total Sales Feb Year
	--[MarTA] [numeric](38, 6) NULL, --Total Sales Mar Year
	--[AprTA] [numeric](38, 6) NULL, --Total Sales Apr Year
	--[MayTA] [numeric](38, 6) NULL, --Total Sales May Year
	--[JunTA] [numeric](38, 6) NULL, --Total Sales Jun Year
	--[JulTA] [numeric](38, 6) NULL, --Total Sales Jul Year
	--[AugTA] [numeric](38, 6) NULL, --Total Sales Aug Year
	--[SepTA] [numeric](38, 6) NULL, --Total Sales Sep Year
	--[OctTA] [numeric](38, 6) NULL, --Total Sales Oct Year
	--[NovTA] [numeric](38, 6) NULL, --Total Sales Nov Year
	--[DecTA] [numeric](38, 6) NULL, --Total Sales Dec Year
	[JanTB] [numeric](38, 8) NULL, --Total Salse Jan Year-1
	--[FebTB] [numeric](38, 8) NULL, --Total Salse Feb Year-1
	--[MarTB] [numeric](38, 8) NULL, --Total Salse Mar Year-1
	--[AprTB] [numeric](38, 8) NULL, --Total Salse Apr Year-1
	--[MayTB] [numeric](38, 8) NULL, --Total Salse May Year-1
	--[JunTB] [numeric](38, 8) NULL, --Total Salse Jun Year-1
	--[JulTB] [numeric](38, 8) NULL, --Total Salse Jul Year-1
	--[AugTB] [numeric](38, 8) NULL, --Total Salse Aug Year-1
	--[SepTB] [numeric](38, 8) NULL, --Total Salse Sep Year-1
	--[OctTB] [numeric](38, 8) NULL, --Total Salse Oct Year-1
	--[NovTB] [numeric](38, 8) NULL, --Total Salse Nov Year-1
	--[DecTB] [numeric](38, 8) NULL, --Total Salse Dec Year-1
	[JanTC] [numeric](38, 8) NULL, --Total Sales Jan Year-2
	--[FebTC] [numeric](38, 8) NULL, --Total Sales Feb Year-2
	--[MarTC] [numeric](38, 8) NULL, --Total Sales Mar Year-2
	--[AprTC] [numeric](38, 8) NULL, --Total Sales Apr Year-2
	--[MayTC] [numeric](38, 8) NULL, --Total Sales May Year-2
	--[JunTC] [numeric](38, 8) NULL, --Total Sales Jun Year-2
	--[JulTC] [numeric](38, 8) NULL, --Total Sales Jul Year-2
	--[AugTC] [numeric](38, 8) NULL, --Total Sales Aug Year-2
	--[SepTC] [numeric](38, 8) NULL, --Total Sales Sep Year-2
	--[OctTC] [numeric](38, 8) NULL, --Total Sales Oct Year-2
	--[NovTC] [numeric](38, 8) NULL, --Total Sales Nov Year-2
	--[DecTC] [numeric](38, 8) NULL, --Total Sales Dec Year-2
	[JanNA] [numeric](38, 8) NULL, --Net Sales Jan Year
	--[FebNA] [numeric](38, 8) NULL, --Net Sales Feb Year
	--[MarNA] [numeric](38, 8) NULL, --Net Sales Mar Year
	--[AprNA] [numeric](38, 8) NULL, --Net Sales Apr Year
	--[MayNA] [numeric](38, 8) NULL, --Net Sales May Year
	--[JunNA] [numeric](38, 8) NULL, --Net Sales Jun Year
	--[JulNA] [numeric](38, 8) NULL, --Net Sales Jul Year
	--[AugNA] [numeric](38, 8) NULL, --Net Sales Aug Year
	--[SepNA] [numeric](38, 8) NULL, --Net Sales Sep Year
	--[OctNA] [numeric](38, 8) NULL, --Net Sales Oct Year
	--[NovNA] [numeric](38, 8) NULL, --Net Sales Nov Year
	--[DecNA] [numeric](38, 8) NULL, --Net Sales Dec Year
	[JanNB] [numeric](38, 8) NULL, --Net Sales Jan Year-1
	--[FebNB] [numeric](38, 8) NULL, --Net Sales Feb Year-1
	--[MarNB] [numeric](38, 8) NULL, --Net Sales Mar Year-1
	--[AprNB] [numeric](38, 8) NULL, --Net Sales Apr Year-1
	--[MayNB] [numeric](38, 8) NULL, --Net Sales May Year-1
	--[JunNB] [numeric](38, 8) NULL, --Net Sales Jun Year-1
	--[JulNB] [numeric](38, 8) NULL, --Net Sales Jul Year-1
	--[AugNB] [numeric](38, 8) NULL, --Net Sales Aug Year-1
	--[SepNB] [numeric](38, 8) NULL, --Net Sales Sep Year-1
	--[OctNB] [numeric](38, 8) NULL, --Net Sales Oct Year-1
	--[NovNB] [numeric](38, 8) NULL, --Net Sales Nov Year-1
	--[DecNB] [numeric](38, 8) NULL, --Net Sales Dec Year-1
	[JanNC] [numeric](38, 8) NULL --Net Sales Jan Year-2
	--[FebNC] [numeric](38, 8) NULL, --Net Sales Feb Year-2
	--[MarNC] [numeric](38, 8) NULL, --Net Sales Mar Year-2
	--[AprNC] [numeric](38, 8) NULL, --Net Sales Apr Year-2
	--[MayNC] [numeric](38, 8) NULL, --Net Sales May Year-2
	--[JunNC] [numeric](38, 8) NULL, --Net Sales Jun Year-2
	--[JulNC] [numeric](38, 8) NULL, --Net Sales Jul Year-2
	--[AugNC] [numeric](38, 8) NULL, --Net Sales Aug Year-2
	--[SepNC] [numeric](38, 8) NULL, --Net Sales Sep Year-2
	--[OctNC] [numeric](38, 8) NULL, --Net Sales Oct Year-2
	--[NovNC] [numeric](38, 8) NULL, --Net Sales Nov Year-2
	--[DecNC] [numeric](38, 8) NULL  --Net Sales Dec Year-2
) ON [PRIMARY]

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
--SELECT @Lastyearvalue = '2012'
SELECT @cmd = 'INSERT INTO work_SSRS311v2 '
SELECT @cmd = @cmd + 'SELECT '
SELECT @cmd = @cmd + 'SL01001, '								--customercode
SELECT @cmd = @cmd + 'SL01002,'									--customername
SELECT @cmd = @cmd + 'ST03017, '								--stockcode
SELECT @cmd = @cmd + 'NULL,'									--description1
SELECT @cmd = @cmd + 'NULL,'									--description2
SELECT @cmd = @cmd + 'Department  "Department",'				--department/costcentrename
SELECT @cmd = @cmd + ' ''' + CAST( @year as CHAR(4)) + ''', '	--year
SELECT @cmd = @cmd + 'NULL ,'									--accountcode
SELECT @cmd = @cmd  + 'SUBSTRING(ST03011,7,2), '				--costcentrecode
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) End), '  --total sales jan year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) End), '	 --total sales feb year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) End), '  --total sales mar year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) End), '  --total sales apr year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) End), '  --total sales may year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) End), '  --total sales jun year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) End), '  --total sales jul year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) End), '  --total sales aug year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) End), '  --total sales sep year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) End), '  --total sales oct year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) End), '  --total sales nov year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) End), '  --total sales dec year
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) End), '  --total sales jan year-1  
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) End), '  --total sales feb year-1  
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) End), '  --total sales mar year-1  
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) End), '  --total sales apr year-1  
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) End), '  --total sales may year-1  
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) End), '  --total sales jun year-1  
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) End), '  --total sales jul year-1  
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) End), '  --total sales aug year-1    
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) End), '  --total sales sep year-1    
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) End), '  --total sales oct year-1    
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) End), '  --total sales nov year-1    
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) End), '  --total sales dec year-1    
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) End), '  --total sales jan year-2    
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) End), '  --total sales feb year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) End), '  --total sales mar year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) End), '  --total sales apr year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) End), '  --total sales may year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) End), '  --total sales jun year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) End), '  --total sales jul year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) End), '  --total sales aug year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) End), '  --total sales sep year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) End), '  --total sales oct year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) End), '  --total sales nov year-2      
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) End), '  --total sales dec year-2      
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales jan year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales feb year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales mar year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales apr year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) ,' --total net sales may year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales jun year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales jul year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales aug year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales sep year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales oct year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales nov year
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales dec year
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales jan year-1
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales feb year-1
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales mar year-1
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales apr year-1
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) ,' --total net sales may year-1
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales jun year-1 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales jul year-1 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales aug year-1 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales sep year-1 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales oct year-1 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales nov year-1 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-1 as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales dec year-1 
SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M01'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End)'--total net sales jan year-2
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M02'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales feb year-2
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M03'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales mar year-2
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M04'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales apr year-2 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M05'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) ,' --total net sales may year-2
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M06'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales jun year-2 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M07'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales jul year-2 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M08'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales aug year-2 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M09'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales sep year-2 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M10'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales oct year-2 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M11'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) , '--total net sales nov year-2 
--SELECT @cmd = @cmd + 'SUM(Case When rtrim(cast(datepart(yyyy,ST03015) as char))+ ''M''+ substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)= ''' + CAST( @Year-2 as CHAR(4)) + 'M12'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) '
SELECT @cmd2 = 'FROM [ScaCompanyDB]..ST030100 '     
SELECT @cmd2 = @cmd2 + 'INNER JOIN    [ScaCompanyDB]..SL010100 '
SELECT @cmd2 = @cmd2 + ' ON   ST03008 = SL01001 '
SELECT @cmd2 = @cmd2 + 'INNER JOIN  KK_Departments '
SELECT @cmd2 = @cmd2 + ' ON   Department = ''' + @Department + ''' '
IF @Single = 1 
 SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
Else
 SELECT @cmd2 = @cmd2 +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
SELECT @cmd2 = @cmd2 + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @cmd2 = @cmd2 + 'AND ST03017 <>  ''FREIGHT'' '
SELECT @cmd2 = @cmd2 + 'GROUP BY Department,SL01001, SL01002, SUBSTRING(ST03011,13,6), ST03017,ST03011 '
Execute (@cmd + ' ' + @cmd2)
UPDATE work_SSRS311v2
	SET Description1 = SC01002,
		Description2 = SC01003,
		AccountCode = SUBSTRING(SC01039,13,6)
FROM ScaCompanyDB..SC010100
WHERE StockCode = SC01001 COLLATE Database_Default
UPDATE work_SSRS311v2
	SET	AccountCode = 'X'
WHERE AccountCode IS NULL
SELECT * FROM work_SSRS311v2 
WHERE  NOT AccountCode = 'AIXFRU'
AND NOT AccountCode = 'AWMAT'
AND NOT AccountCode = 'AIXPAL'
AND JanTA IS NOT NULL OR JanTB IS NOT NULL OR JanTC IS NOT NULL OR JanNA IS NOT NULL OR JanNB IS NOT NULL OR JanNC IS NOT NULL

--AND JanTA IS NOT NULL OR FebTA IS NOT NULL AND MarTA IS NOT NULL OR AprTA IS NOT NULL OR MayTA IS NOT NULL OR JunTA IS NOT NULL
--OR JulTA IS NOT NULL OR AugTA IS NOT NULL OR SepTA IS NOT NULL OR OctTA IS NOT NULL OR NovTA IS NOT NULL OR DecTA IS NOT NULL 
--OR JanNA IS NOT NULL OR FebNA IS NOT NULL AND MarNA IS NOT NULL OR AprNA IS NOT NULL OR MayNA IS NOT NULL OR JunNA IS NOT NULL
--OR JulNA IS NOT NULL OR AugNA IS NOT NULL OR SepNA IS NOT NULL OR OctNA IS NOT NULL OR NovNA IS NOT NULL OR DecNA IS NOT NULL 

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[work_SSRS311v2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
	DROP TABLE [dbo].[work_SSRS311v2]