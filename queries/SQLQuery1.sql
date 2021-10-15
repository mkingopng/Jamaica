use ScaCompanyDB

select [SC01001] as [stock code]
, [SC01002] as [Description 1]
, [SC01003] as [Description 2]
, [SC03002] as [warehouse]
, ROUND(SC03003,2) as [stock balance]
, [SC01038] as [Alt Product Group]
from SC010100
inner join SC030100
on [SC01001] = [SC03001]
where SC01038 = 'OIS' and SC03003 > 0
and SC03002 = '05'
order by SC01001
