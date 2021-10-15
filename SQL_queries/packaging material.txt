--query to see purchasing history on Durga
use ScaCompanyDB

select 
  PC01003 as [PC01:SupplierCode]
, PL01002 as [PL01:SupplierName]
, PC01001 as [PC01:PurchaseOrderNo]
, case PC01002 
	when '1' then 'Normal Order' 
	when '2' then 'Back Order' 
  end as [PC01:PurchaseOrderType]
, PC01005 as [PC01:Remark1]
, PC01006 as [PC01:Remark2]
, PC01015 as [PC01:OrderDate]
, PC03005 as [PC03:StockCode]
, PC03006 as [PC03:Description1]
, PC03008 as [PC03:Unit Price]
, PC03012 as [PC03:Qty Invoiced]
, PC01020 as [PC01:OrderValue]
, PL03002 as [PC03:Invoice Number]
, PL03004 as [PL03:Invoice Date]
, PL03013 as [PL03:Invoice Amount]
from PC010100 INNER JOIN PL010100 ON PC01003=PL01001 and 'PGBAGU' = PC01003
			  INNER JOIN PC030100 ON PC01001=PC03001
			  INNER JOIN PL030100 ON PC01001=PL03033
where PC01015 >= '2020-01-01'
--where PC01015 between '2019-01-01' and '2019-12-31'
--and PC03005 = '85-10-0031'
--challenge: pull in all packaging suppliers and get a true cost of packaging for 2020. sort by supplier code
--look at other fields in the PL01 table for supplier details and try to identify issues.