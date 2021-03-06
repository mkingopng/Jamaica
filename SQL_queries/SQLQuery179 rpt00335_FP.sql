USE [IscalaAnalysis]
GO
/****** Object:  StoredProcedure [dbo].[SSRS_Rpt00335_FP]    Script Date: 10/05/2021 12:53:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SSRS_Rpt00335_FP]
AS
BEGIN
	SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF
SELECT 
    T4.SC03001    "StockCode" 
 ,  T2.SC01002    "Description1" 
 ,  T2.SC01003    "Description2" 
 ,  T4.SC03010    "ReOrderLevel" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M01' Then T3.SC07004 End))   "Jan_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M01' Then T3.SC07004 End))   "Jan_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M02' Then T3.SC07004 End))   "Feb_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M02' Then T3.SC07004 End))   "Feb_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M03' Then T3.SC07004 End))   "Mar_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M03' Then T3.SC07004 End))   "Mar_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M04' Then T3.SC07004 End))   "Apr_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M04' Then T3.SC07004 End))   "Apr_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M05' Then T3.SC07004 End))   "May_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M05' Then T3.SC07004 End))   "May_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M06' Then T3.SC07004 End))   "Jun_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M06' Then T3.SC07004 End))   "Jun_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M07' Then T3.SC07004 End))   "Jul_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M07' Then T3.SC07004 End))   "Jul_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M08' Then T3.SC07004 End))   "Aug_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M08' Then T3.SC07004 End))   "Aug_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M09' Then T3.SC07004 End))   "Sep_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M09' Then T3.SC07004 End))   "Sep_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M10' Then T3.SC07004 End))   "Oct_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M10' Then T3.SC07004 End))   "Oct_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M11' Then T3.SC07004 End))   "Nov_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M11' Then T3.SC07004 End))   "Nov_Delivery" 
 , ABS(SUM(Case When T3.SC07001 =  '00' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M12' Then T3.SC07004 End))   "Dec_Production" 
 , ABS(SUM(Case When T3.SC07001 =  '01' AND rtrim(cast(datepart(yyyy,T3.SC07002) as char))+'M'+substring(cast(cast(datepart(mm,T3.SC07002) as INT)+100 as char),2,2) =  '2011M12' Then T3.SC07004 End))   "Dec_Delivery" 
 
 INTO #QRYTMP_14336863
 
 
 FROM [ScaCompanyDB]..SC010100 T2    INNER JOIN    [ScaCompanyDB]..SC030100 T1
                                  ON   T2.SC01001 = T1.SC03001
 
                                  INNER JOIN    [ScaCompanyDB]..SC070100 T3
                                  ON   T2.SC01001 = T3.SC07003
                                  AND  T1.SC03001 = T3.SC07003  AND T1.SC03002 = T3.SC07009
 
                                  INNER JOIN    [ScaCompanyDB]..SC030100 T4
                                  ON   T2.SC01001 = T4.SC03001

WHERE  T4.SC03001 BETWEEN '12-01-0000' AND '13-01-0000'
--WHERE T4.SC03001   >= '12-01-0000'
--AND   T4.SC03001   <= '13-01-0000'
AND   T4.SC03002  IN ('05','03')
  
GROUP BY  
   T4.SC03001
 , T2.SC01002
 , T2.SC01003
 , T4.SC03010

	
select * from #QRYTMP_14336863	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
--	DECLARE @command as NVARCHAR(4000)
	
--create table #workData15032010
--	(
--		StockCode			nvarchar(35),
--		Description			nvarchar(60),
--		ROL					NUMERIC(20,4),
--		Jan_Production		    NUMERIC(20,4),
--		Jan_Delivery	        NUMERIC(20,2),
--		Feb_Production		    NUMERIC(20,4),
--		Feb_Delivery	        NUMERIC(20,2),
--		Mar_Production		    NUMERIC(20,4),
--		Mar_Delivery	        NUMERIC(20,2),
--		Apr_Production		    NUMERIC(20,4),
--		Apr_Delivery	        NUMERIC(20,2),
--		May_Production		    NUMERIC(20,4),
--		May_Delivery	        NUMERIC(20,2),
--		Jun_Production		    NUMERIC(20,4),
--		Jun_Delivery	        NUMERIC(20,2),
--		Jul_Production		    NUMERIC(20,4),
--		Jul_Delivery	        NUMERIC(20,2),
--		Aug_Production		    NUMERIC(20,4),
--		Aug_Delivery	        NUMERIC(20,2),
--		Sep_Production		    NUMERIC(20,4),
--		Sep_Delivery	        NUMERIC(20,2),
--		Oct_Production		    NUMERIC(20,4),
--		Oct_Delivery	        NUMERIC(20,2),
--		Nov_Production		    NUMERIC(20,4),
--		Nov_Delivery	        NUMERIC(20,2),
--		Dec_Production		    NUMERIC(20,4),
--		Dec_Delivery	        NUMERIC(20,2),

--		--CurrentStock	    NUMERIC(20,2),SC03003 
--	)
--SELECT @Command = 'INSERT INTO #workData15032010 '
--SELECT @Command = @command + 'SELECT '
--SELECT @Command = @command + 'SC03001,  SC01002  + '' '' + SC01003,SC03010,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL '
--SELECT @command = @command + 'FROM ScaCompanyDB..SC010100 '
--SELECT @command = @command + 'INNER JOIN ScaCompanyDB..SC030100 '
--SELECT @command = @command + 'ON SC01001=SC03001 ' 
--SELECT @command = @command +  'WHERE SC03002 = ''05'' '
--SELECT @command = @command + 'AND (SC03001>=''12-01-0000'' AND SC03001<=''13-01-0000'')'
--EXEC (@command)

--SELECT @command = 'UPDATE #workData15032010 '
--SELECT @command = @command + 'SET Jan_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M01'') '
--EXEC (@command)
--SELECT @command = 'UPDATE #workData15032010 '
--SELECT @command = @command + 'SET Jan_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M01'') '
--EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Feb_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M02'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Feb_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M02'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Mar_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M03'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Mar_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M03'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Apr_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M04'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Apr_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M04'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET May_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M05'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET May_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M05'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Jun_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M06'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Jun_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M06'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Jul_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M07'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Jul_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M07'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Aug_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M08'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Aug_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M08'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Sep_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M09'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Sep_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M09'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Oct_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M10'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Oct_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M10'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Nov_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M11'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Nov_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M11'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Dec_Production = (SELECT ABS(SUM(SC07004)) FROM SCaCompanyDB..SC070100 WHERE SC07003 = StockCode Collate Database_Default AND SC07001 = ''00'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M12'') '
----EXEC (@command)
----SELECT @command = 'UPDATE #workData15032010 '
----SELECT @command = @command + 'SET Dec_Delivery = (SELECT ABS(SUM(SC07004))FROM SCaCompanyDB..SC070100 WHERE SC07003 = Stockcode Collate Database_Default AND SC07001 = ''01'' AND (rtrim(cast(datepart(yyyy,SC07002) as char))+ ''M'' + substring(cast(cast(datepart(mm,SC07002) as INT)+100 as char),2,2)) =  ''2010M12'') '
----EXEC (@command)
--select distinct * from #workData15032010


end
