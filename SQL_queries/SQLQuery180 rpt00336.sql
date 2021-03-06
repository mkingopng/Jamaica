USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00336_sel]    Script Date: 10/05/2021 12:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Wayne Dunn
-- Date:	26/11/2010		
-- Description: Retail stock reports asp er Connie's requirements	
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00336_sel] 
		@Department	 as NVARCHAR(256),
		@OwnGroup as Bit
		
	AS
	
	DECLARE @c as NVARCHAR(4000),
			@AltProdGrp as NVARCHAR(64),
			@SingleA as bit
	
	-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
	-- The users supplies the Division/Department and we apply the cost centres
	SELECT @AltProdGrp = (Select AlternateProductGroup From KK_Departments Where Department = @Department)
	SELECT @SingleA = (Select SingleA From KK_Departments Where Department = @Department)

	
   -- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT @c ='SELECT ' 
	SELECT @c = @c + 'SC01001    "StockCode"  '
	SELECT @c = @c + '	,  SC01002    "Description1" ' 
	SELECT @c = @c + '	,  SC01003    "Description2" '
	SELECT @c = @c + '	,  SUM(Case When SC03002 =  ''03'' Then SC03003 End)    "WH03" '
	SELECT @c = @c + '	,  SUM(Case When SC03002 =  ''05''Then SC03003 End )   "WH05" '
	SELECT @c = @c + '	,  SUM(Case When SC03002 =  ''12'' Then SC03003 End)    "WH21" '
	SELECT @c = @c + '	,  SUM(Case When SC03002 NOT IN(''03'',''05'',''21'') Then SC03003 End )   "OtherWH" ' 
	SELECT @c = @c + '	,  SUM(SC03003)    "Total" ' 
	SELECT @c = @c + '	FROM [ScaCompanyDB]..SC010100 '
	SELECT @c = @c + '	INNER JOIN    [ScaCompanyDB]..SC030100 '
	SELECT @c = @c + '	ON   SC01001 = SC03001 '
	IF @SingleA = 1 
		SELECT @c = @c + 'AND SC01038  =  ''' +  @AltProdGrp  +  ''' '
		Else
		SELECT @c = @c +  'AND SC01038  IN ' +  @AltProdGrp + ' '
	IF (@Department = 'Retail' AND @OwnGroup = 1)
		SELECT @c = @c + ' AND SC01066 = ''0'' '
	SELECT @c = @c + ' AND   SC03003   >  0 '
	--SELECT @c = @c + ' AND   SC01001   =  ''12-01-9010'' '
	SELECT @c = @c + ' GROUP BY SC01001, SC01002, SC01003 '

EXEC (@c)
