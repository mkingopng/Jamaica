SELECT
    PC01003 AS 'PC01:SupplierCode',
    PL01002 AS 'PL01:SupplierName',
    PC01001 as 'PC01:PurchaseOrderNo',
    CASE PC01002
	WHEN '1' THEN 'Normal Order'
	WHEN '2' THEN 'Back Order'
    END AS 'PC01:PurchaseOrderType',
    PC01005 AS 'PC01:Remark1',
    PC01006 AS 'PC01:Remark2',
    PC01015 AS 'PC01:OrderDate',
    PC03005 AS 'PC03:StockCode',
    PC03006 AS 'PC03:Description1',
    PC03008 AS 'PC03:Unit Price',
    PC03012 AS 'PC03:Qty Invoiced',
    PC01020 AS 'PC01:OrderValue',
    PL03002 AS 'PC03:Invoice Number',
    PL03004 AS 'PL03:Invoice Date',
    PL03013 as 'PL03:Invoice Amount'

FROM PC010100 INNER JOIN PL010100 ON PC01003=PL01001 AND 'PGBAGU' = PC01003
			  INNER JOIN PC030100 ON PC01001=PC03001
			  INNER JOIN PL030100 ON PC01001=PL03033
WHERE PC01015 >= '2020-01-01'
--where PC01015 between '2019-01-01' and '2019-12-31'
--and PC03005 = '85-10-0031'
--challenge: pull in all packaging suppliers and get a true cost of packaging for 2020. sort by supplier code
--look at other fields in the PL01 table for supplier details and try to identify issues.