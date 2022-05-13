--query 3: i want to see ALL the price lists for commercial stock items. I want to see std cost too

use ScaCompanyDB

select [SC01001] as [stock code]
, [SC01002] as [Description 1]
, [SC01003] as [Description 2]
, [SC03002] as [Warehouse]
, [SC03003] as [Stock Balance]
, [SC01038] as [alt product group]
, [SC39004] as [Price, 2]
, ROUND(SC39002,2) as [Price list code]
from SC010100
inner join SC030100 on SC01001 = SC03001 and '05' = SC03002
inner join SC390100 on SC03001 = SC39001
where SC01038 = 'COS'
order by SC01001