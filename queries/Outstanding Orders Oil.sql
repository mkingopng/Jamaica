SELECT
    T1.OR01001    "Ordernr"
,  T1.OR01002    "Ordertyp"
,  T1.OR01015    "OrderDate"
,  T2.SL01001    "CustomerCode"
,  T2.SL01002    "CustomerName"
,  T3.OR03005    "StockNo"
,  T3.OR03006    "Description"
, SUM(T3.OR03011)   "Order Qty"
,  SUBSTRING(T3.OR03028,7,6)    "Cost Centre"
 
 
FROM [ScaCompanyDB]..OR010100 T1    INNER JOIN    [ScaCompanyDB]..OR030100 T3
                                  ON   T1.OR01001 = T3.OR03001
 
                                  INNER JOIN    [ScaCompanyDB]..SL010100 T2
                                  ON   T1.OR01003 = T2.SL01001
 
WHERE SUBSTRING(T3.OR03028,7,6)   IN('19','40')
AND   T1.OR01015   >= '2020-04-01'
 
GROUP BY
   T1.OR01001
, T1.OR01002
, T1.OR01015
, T2.SL01001
, T2.SL01002
, T3.OR03005
, T3.OR03006
, SUBSTRING(T3.OR03028,7,6)