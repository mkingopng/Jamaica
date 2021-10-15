BEGIN
/* ************************************************* */
DECLARE @CompanyID as nvarchar(2)
SET @CompanyID = '01'
SELECT
    T1.ST03014    "InvoicNumber"
 ,  rtrim(cast(datepart(yyyy,T1.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)    "Date\Month"
 ,  T1.ST03009    "OrderNumber"
 ,  T1.ST03015    "InvOrderDate"
 ,  T2.SC01001    "StockCode"
 ,  T2.SC01002    "Description1"
 ,  T2.SC01003    "Description2"
 , SUM(T1.ST03020)   "Qty"
 ,  T4.SY24003    "ProdGrp Descr"
 ,  SUBSTRING(T3.SL01017,1,6)    "Account"
 ,  T3.SL01001    "CustomerCode"
 ,  T3.SL01002    "CustomerName"
 ,  SUBSTRING(T1.ST03011,7,6)    "Cost Centre"
 ,  SUBSTRING(T1.ST03011,13,6)    "Product"
 , SUM(T1.ST03020 * T1.ST03021)   "Gross Value"
 , SUM(T1.ST03020 * T1.ST03021 * T1.ST03022 / 100)   "Discount"
 , SUM((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100))   "Net Value"
 , SUM(T1.ST03020 * T1.ST03023)   "Cost Value"

 INTO #QRYTMP_74530580


 FROM [ScaCompanyDB]..ST030100 T1    INNER JOIN    [ScaCompanyDB]..SC010100 T2
                                  ON   T1.ST03017 = T2.SC01001

                                  INNER JOIN    [ScaCompanyDB]..SL010100 T3
                                  ON   T1.ST03008 = T3.SL01001

                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T4
                                  ON   T2.SC01037 = T4.SY24002  AND 'IB' = T4.SY24001

WHERE SUBSTRING(T3.SL01017,1,6)   =  '001020'
AND   rtrim(cast(datepart(yyyy,T1.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)   Between '2016M01' AND '2020M12'

GROUP BY
   T1.ST03014
 , rtrim(cast(datepart(yyyy,T1.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2)
 , T1.ST03009
 , T1.ST03015
 , T2.SC01001
 , T2.SC01002
 , T2.SC01003
 , T4.SY24003
 , SUBSTRING(T3.SL01017,1,6)
 , T3.SL01001
 , T3.SL01002
 , SUBSTRING(T1.ST03011,7,6)
 , SUBSTRING(T1.ST03011,13,6)
END
/* ************************************************ */
/* SELECT THE RESULT FROM QUERY  */
/* ********************************************* */
BEGIN
SELECT
    [InvoicNumber]   "InvoicNumber"
 ,  [Date\Month]   "Date\Month"
 ,  [OrderNumber]   "OrderNumber"
 ,  [InvOrderDate]   "InvOrderDate"
 ,  [StockCode]   "StockCode"
 ,  [Description1]   "Description1"
 ,  [Description2]   "Description2"
 , SUM([Qty])  "Qty"
 ,  [ProdGrp Descr]   "ProdGrp Descr"
 ,  [Account]   "Account"
 ,  [CustomerCode]   "CustomerCode"
 ,  [CustomerName]   "CustomerName"
 ,  [Cost Centre]   "Cost Centre"
 ,  [Product]   "Product"
 , SUM([Gross Value])  "Gross Value"
 , SUM([Discount])  "Discount"
 , SUM([Net Value])  "Net Value"
 , SUM([Cost Value])  "Cost Value"

FROM #QRYTMP_74530580

GROUP BY
   [InvoicNumber]
 , [Date\Month]
 , [OrderNumber]
 , [InvOrderDate]
 , [StockCode]
 , [Description1]
 , [Description2]
 , [ProdGrp Descr]
 , [Account]
 , [CustomerCode]
 , [CustomerName]
 , [Cost Centre]
 , [Product]

ORDER BY 1 ASC,2 ASC,3 ASC,4 ASC,5 ASC,6 ASC
END
/* ************************************************ */
/* Drop Temp File                                  */
/* ********************************************** */
BEGIN
DROP TABLE #QRYTMP_74530580
END
