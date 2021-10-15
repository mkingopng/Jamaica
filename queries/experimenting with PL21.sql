select PL21001 --supplier code
, PL01002
, PL21002
, PL21003
, PL21004 --invoice number
, PL21005
, PL21006 --transaction date
, PL21007
, PL21008
, PL21009
, PL21010
, PL21011 --payment sent
, PL21012
, PL21013
, PL21014
, PL21015
, PL21016
--, PL21020 --payment remark


from ScaCompanyDB..PL210100 

inner join ScaCompanyDB..PL010100 on PL21001 = PL01001
where PL21006 >= '2020-10-01' order by PL21006 desc 
 