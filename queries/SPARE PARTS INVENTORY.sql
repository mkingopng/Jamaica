USE ScaCompanyDB

Select SC01001 --STOCK CODE
, SC01002 --DESCRIPTION 1
, SC01003 --DESCRIPTION 2
, SC03002 -- WH
, SC03003 -- STOCK BALANCE

FROM SC010100 INNER JOIN SC030100 ON SC01001=SC03001 

WHERE SC03002='80'AND SC03003 >0

--from ScaCompanyDB..SC010100