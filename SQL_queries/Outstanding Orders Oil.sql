SELECT
    T1.OR01001 AS "Ordernr",
    T1.OR01002 AS "Ordertyp",
    T1.OR01015 AS "OrderDate",
    T2.SL01001 AS "CustomerCode",
    T2.SL01002 AS "CustomerName",
    T3.OR03005 AS "StockNo",
    T3.OR03006 AS "Description",
    SUM(T3.OR03011) AS "Order Qty",
    SUBSTRING(T3.OR03028,7,6) AS "Cost Centre"

FROM OR010100 T1 INNER JOIN OR030100 T3 ON T1.OR01001 = T3.OR03001
INNER JOIN SL010100 T2 ON T1.OR01003 = T2.SL01001
 
WHERE SUBSTRING(T3.OR03028,7,6) IN ('19','40') AND T1.OR01015 >= '2020-04-01'
 
GROUP BY
    T1.OR01001,
    T1.OR01002,
    T1.OR01015,
    T2.SL01001,
    T2.SL01002,
    T3.OR03005,
    T3.OR03006,
    SUBSTRING(T3.OR03028,7,6)