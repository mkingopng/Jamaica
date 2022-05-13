--query to see purchasing history on Durga

use ScaCompanyDB

select [PL01001] as [Supplier Code]
, [PL01002] as [Supplier Name]
, [PL03002] as [invoice number]
, [PL03004] as [invoice date]
, [PL03013] as [invoice amount]
, [PL03033] as [order number]
, [PC03005] as [stock code]
, [PC03006] as [description]
, [PC03008] as [unit price]
, [PC03012] as [qty invoiced]
from PL010100
inner join PL030100 on PL01001 = PL03001 and 'PGKDUR' = PL01001 --supller code to suppler to purchase ledger (1 to many)
inner join PC010100 on PC01003 = PL01001  -- purchase order header to supplier  (many to 1)
inner join PC030100 on PC01001 = PC03001  -- purchase order lines to purchase order header (many to 1
where PL03004 >='2020-01-01'

--iScala Purchase Order/Purchase ledge Process
--Purchase Order Raised-data stored in PC01 
--Purchase Order Lines-data stored in PC01 
--Supplier Invoice Details-Data Stored in PC01
--Supplier Invoice Lines-Data Stored in PC03
