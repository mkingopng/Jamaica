--query to see purchasing history on Durga
SELECT
    PL01001 AS 'Supplier Code',
    PL01002 AS 'Supplier Name',
    PL03002 AS 'invoice number',
    PL03004 AS 'invoice date',
    PL03013 AS 'invoice amount',
    PL03033 AS 'order number',
    PC03005 AS 'stock code',
    PC03006 AS 'description',
    PC03008 AS 'unit price',
    PC03012 AS 'qty invoiced'
FROM PL010100
INNER JOIN PL030100 ON PL01001 = PL03001 AND 'PGKDUR' = PL01001 --supplier code to suppler to purchase ledger (1 to many)
INNER JOIN PC010100 ON PC01003 = PL01001  -- purchase order header to supplier  (many to 1)
INNER JOIN PC030100 ON PC01001 = PC03001  -- purchase order lines to purchase order header (many to 1
WHERE PL03004 >='2020-01-01'

--iScala Purchase Order/Purchase ledge Process
--Purchase Order Raised-data stored in PC01 
--Purchase Order Lines-data stored in PC01 
--Supplier Invoice Details-Data Stored in PC01
--Supplier Invoice Lines-Data Stored in PC03
