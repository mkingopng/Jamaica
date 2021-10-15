SELECT
    PL03001,  --supplier code
    PL01002,  --supplier name
    PL03002,  --invoice number
    PL03004,  --invoice date
    PL03013,  --invoice amount in local currency
    PL03014,  --invoice amount in foreign currency
    PL03017,  --accoutn string
    PL03021,  --payment method
    PL03025,  --last payment date
    PL03026,  --paid amount in local currency
    PL03027,  --paid amount in foreign currency
    PL03043  --payment text comment

 FROM PL030100
 
 INNER JOIN PL010100 ON PL03001 = PL01001
 WHERE PL03025 >= '2020-10-01' ORDER BY PL03025 DESC