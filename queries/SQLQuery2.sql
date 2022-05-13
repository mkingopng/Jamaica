--Query 2
use ScaCompanyDB

select [SC01001] as [stock code]
, [SC01002] as [Description 1]
, [SC01003] as [Description 2]
, [SC03002] as [Warehouse]
, [SC03003] as [stock balance]
, SC01038 as [Alt Product Group]
, [SC39004] as [Price,2]
, ROUND(SC39002,2) as [Price List Code]
from SC010100
inner join SC030100 on SC01001 = SC03001 and '05' = SC03002
inner join SC390100 on [SC03001] = [SC39001] and '11' = SC39002
where SC01038 = 'OIS'
Order by SC01001