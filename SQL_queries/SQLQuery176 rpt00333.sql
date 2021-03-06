USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00333_sel]    Script Date: 10/05/2021 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00333_sel]
	-- Add the parameters for the stored procedure here
	@Department	 as NVARCHAR(256),
	@SupplierCode Nvarchar(256) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @c as NVARCHAR(4000),
			@warehouse as NVARCHAR(64),
			@altprodgrp as NVARCHAR(64),
			@Singlew as bit,
			@Singlea as bit

	-- This is to address SSRS's inability to support multiple variable paramaters when using stored procedures
	-- The users supplies the Division/Department and we apply the cost centres
	SELECT @warehouse = (Select Warehouse From KK_Departments Where Department = @Department)
	SELECT @Singlew = (Select Singlew From KK_Departments Where Department = @Department)
	SELECT @altprodgrp = (Select AlternateProductGroup From KK_Departments Where Department = @Department)
	SELECT @Singlea = (Select Singlea From KK_Departments Where Department = @Department)


    -- Insert statements for procedure here
	SELECT @c = 'SELECT SC01001, ' 
	SELECT @c = @c + 'SC01002, ' 
	SELECT @c = @c + 'SC01003, '
	SELECT @c = @c + 'SC01004, '
	SELECT @c = @c + 'SC03003, '
	SELECT @c = @c + 'SC01055, ' 
	SELECT @c = @c + 'SC03057, '
	SELECT @c = @c + 'SC01106, '
	SELECT @c = @c + 'SC01100, ' 
	SELECT @c = @c + 'SC01058, ' 
	SELECT @c = @c + 'SC03002, '
	SELECT @c = @c + 'PL01002 '
	SELECT @c = @c + 'FROM   ScaCompanyDB..SC010100 '
	SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SC030100 '
	SELECT @c = @c + 'ON SC01001=SC03001 '
	SELECT @c = @c + 'LEFT OUTER JOIN ScaCompanyDB..PL010100 '
	SELECT @c = @c + 'ON SC01058=PL01001 '
	SELECT @c = @c + 'WHERE  SC03003<>0 '
	IF @Singlew = 1 
		SELECT @c = @c + 'AND SC03002  =  ' +  @warehouse  +  ' '
	Else
		SELECT @c = @c +  'AND SC03002 IN ' +  @warehouse + ' '
	IF @Singlea = 1 
		SELECT @c = @c + 'AND SC01038  =  ' +  @altprodgrp  +  ' '
	Else
		SELECT @c = @c +  'AND SC01038 IN ' +  @altprodgrp+ ' '
	IF @SupplierCode IS NOT NULL
		SELECT @c = @c +  'AND SC01058 = ''' +  @SupplierCode+ ''' '
	SELECT @c = @c + 'ORDER BY SC01001, SC03002 '
	--SELECT @c
	EXEC (@c)
END
