--query 5: i want to see selected stock master fields for commercial stock items

use ScaCompanyDB

Select [SC01001] as [Stock Code]
, [SC01002] as [Description 1]
, [SC01003] as [Description 2]
, [SC01023] as [extended product group]
, [SC01035] as [account code]
, [SC01037] as [product group]
, [SC01038] as [alt product group]
, [SC01039] as [acc string]
, [SC01053] as [std cost]
, [SC01058] as [Supplier Code]
, [SC01060] as [supplier stock code]
, [SC01132] as [EAN stock code]
from SC010100 where SC01038 = 'COS'
order by SC01001