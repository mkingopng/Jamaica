USE ScaCompanyDB

select SC03001 --stock code
, SC01002 --DESCRIPTION
, SC03002 --warehouse
, SC03003 --stock balance

FROM SC030100 INNER JOIN SC010100 ON SC01001=SC03001
WHERE SC03001 IN ('15-50-0350',
'15-50-0500',
'15-50-2000L', 
'15-50-3001',
'15-50-4000', 
'15-50-50002', 
'15-50-9001')
--'15-50-0019', 
--'11-01-0021', 
--'11-01-0022', 
--'11-01-0024', 
--'11-01-0025',
--'11-01-0026', 
--'11-01-0030', 
--'11-01-0060') 