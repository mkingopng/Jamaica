select PL03001 --supplier code
, PL01002 --supplier name
, PL03002 --invoice number
, PL03004 --invoice date
, PL03013 --invoice amount in local currency
, PL03014 --invoice amount in foreign currency
, PL03017 --accoutn string
, PL03021 --payment method
, PL03025 --last payment date
, PL03026 --paid amount in local currency
, PL03027 --paid amount in foreign currency
, PL03043 --payment text comment

 from ScaCompanyDB..PL030100 
 
 inner join ScaCompanyDB..PL010100 on PL03001 = PL01001
 where PL03025 >= '2020-10-01' order by PL03025 desc 