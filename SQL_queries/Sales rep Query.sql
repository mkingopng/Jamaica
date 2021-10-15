SELECT
    T1.ST03015    "InvOrderDate"
 ,  T3.SY24003    "Salesm Name"
 ,  T2.SL01002    "CustomerName"
 ,  T2.SL01001    "CustomerCode"
 , SUM((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100))   "Net Value"
 , SUM(T1.ST03020 * T1.ST03023)   "Cost Value"
 , SUM(((T1.ST03020 * T1.ST03021) - (T1.ST03020 * T1.ST03021 * T1.ST03022 / 100)) - (T1.ST03020 * T1.ST03023))   "Net Profit"




 FROM [ScaCompanyDB]..ST030100 T1    INNER JOIN    [ScaCompanyDB]..SL010100 T2
                                  ON   T1.ST03008 = T2.SL01001

                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T3
                                  ON   T1.ST03007 = T3.SY24002  AND 'BK' = T3.SY24001

WHERE T1.ST03015   Between '2020-01-01' AND '2020-10-31'

GROUP BY
   T1.ST03015
 , T3.SY24003
 , T2.SL01002
 , T2.SL01001