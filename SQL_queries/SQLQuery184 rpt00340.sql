USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00340_sel]    Script Date: 10/05/2021 12:55:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[SSRS_RPT00340_sel] 
	@Department	 as NVARCHAR(256)
AS
	DECLARE @MonthYear as NVARCHAR(7),
			@Year as NVARCHAR(4),
			@Month as NVARCHAR(2),
			@c as NVARCHAR(4000),			
			@CostCentre as NVARCHAR(64),
			@Single as bit
	 
	SELECT @Year = DATEPART(Year, GETDATE())
	SELECT @Month =  substring(cast(cast(datepart(mm,GETDATE()) as INT)+100 as char),2,2)
	SELECT @MonthYear = @Year + 'M' + @Month

-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
-- The users supplies the Division/Department and we apply the cost centres
SELECT @CostCentre = (Select CostCentre From KK_Departments Where Department = @Department)
SELECT @Single = (Select Single From KK_Departments Where Department = @Department)
SELECT @CostCentre = '10'
SELECT @c = 'SELECT  '  
SELECT @c = @c + 'ST03015    "InvOrderDate", '
SELECT @c = @c + ' SUM(Case When KK_AreaCode = ''100'' Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) "100", '
SELECT @c = @c + ' SUM(Case When KK_AreaCode = ''101''Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) "101", '
SELECT @c = @c + ' SUM(Case When KK_AreaCode = ''102''Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) "102", '
SELECT @c = @c + ' SUM(Case When KK_AreaCode = ''103''Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) "103", '
SELECT @c = @c + ' SUM(Case When KK_AreaCode = ''104''Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) "104", '
SELECT @c = @c + ' SUM(Case When KK_AreaCode = ''105''Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) "105", '
SELECT @c = @c + ' SUM(Case When KK_AreaCode = ''106''Then (ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100) End) "106" '
SELECT @c = @c + ' FROM [ScaCompanyDB]..ST030100 '     
SELECT @c = @c + ' INNER JOIN  ScaCompanyDB..SC010100 '
SELECT @c = @c + ' ON   ST03017 = SC01001 COLLATE DATABASE_DEFAULT '
SELECT @c = @c + 'LEFT OUTER JOIN  CustomerSalesmanBudget '
SELECT @c = @c + ' ON   ST03001 = KK_CustomerCode Collate Database_Default '
SELECT @c = @c + ' WHERE rtrim(cast(datepart(yyyy,ST03015) as char))+''M''+substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)   =''' +  @MonthYear  + ''' '
IF @Single = 1 
	SELECT @c = @c + 'AND SUBSTRING(ST03011,7,2)  =  ' +  @Costcentre  +  ' '
Else
SELECT @c = @c +  'AND SUBSTRING(ST03011,7,2)  IN ' +  @costcentre + ' '
SELECT @c = @c + 'AND SUBSTRING(ST03008,1,4) <>  ''INTR'' '
SELECT @c = @c + 'AND SUBSTRING(ST03008,1,3) <>  ''ZZZ'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXFRU'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''RAWMAT'' '
SELECT @c = @c + 'AND NOT SUBSTRING(SC01039,13,6) = ''AIXPAL'' '
SELECT @c = @c + 'GROUP BY ST03015 '
SELECT @c = @c + 'ORDER BY ST03015 ASC'

EXEC (@c)