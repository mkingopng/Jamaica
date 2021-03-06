USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_RPT00342_sel_Service]    Script Date: 10/05/2021 12:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SSRS_RPT00342_sel_Service]
	-- Add the parameters for the stored procedure here
	@AccountGrp NVARCHAR(256) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @c as NVARCHAR(4000),
		@year as CHAR(4)
		
 SELECT @year = SUBSTRING(CAST(Year(GETDATE()) as CHAR(4)),3,2)
    -- Insert statements for procedure here
  SELECT @c = 'SELECT [su_item] '
  SELECT @c = @c + ',[su_description] + '' ''  + [su_description2] "Description"  '
  SELECT @c = @c + ',[su_onhandqty] '
  SELECT @c = @c + ' ,[su_Laeonhandqty] '
  SELECT @c = @c + ',[su_POMonhandqty] '
  SELECT @c = @c + ',[su_onhandqty] - [su_stockhistory] "Excess" '
  SELECT @c = @c + '  ,MAX (SC07002) "Last Sale Date" '
  SELECT @c = @c + '  ,[su_currentaveragecost] '
  SELECT @c = @c + '  ,SC01004 "Retail" '
  SELECT @c = @c + '  ,SUBSTRING(SC01039,13,6) "AccountGrp" '
   SELECT @c = @c + ' ,GL03003 "Name" '
  SELECT @c = @c + 'FROM [IscalaAnalysis].[dbo].[KK_Rpt00231Data] '
  SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SC070100 '
  SELECT @c = @c + 'ON su_item = SC07003 COLLATE DATABASE_DEFAULT '
  SELECT @c = @c + 'INNER JOIN ScaCompanyDB..SC010100 '
  SELECT @c = @c + 'ON su_item = SC01001 COLLATE DATABASE_DEFAULT '
  SELECT @c = @c + 'INNER JOIN ScaCompanyDB..GL0301' + @year + ' '
  SELECT @c = @c + 'ON GL03002= SUBSTRING(SC01039,13,6) COLLATE DATABASE_DEFAULT '
  SELECT @c = @c + 'WHERE [su_onhandqty] - [su_stockhistory] > 0 '
  --SELECT @c = @c + 'AND SC07001 = ''01'' '
  SELECT @c = @c + 'AND su_division = ''Service'' '
  IF NOT @AccountGrp = 'ALL'
		SELECT @c = @c + 'AND SUBSTRING(SC01039,13,6) =  ''' + @AccountGrp + ''' '
  SELECT @c = @c + 'GRoup by Su_item,[su_description],[su_description2],[su_currentaveragecost],[su_onhandqty], [su_Laeonhandqty], [su_POMonhandqty],su_stockhistory,SC01004,SUBSTRING(SC01039,13,6), GL03003 '
  SELECT @c = @c + 'ORDER BY su_item  '
  
  EXEC (@c)
END
