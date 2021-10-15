--query to see purchasing history on Durga

--iScala Purchase Order/Ledger data store
--Purchase Order Raised-data stored in PC01
--Purchase Order Lines-data stored in PC01
--Supplier Invoice Details-Data Stored in PC01
--Supplier Invoice Lines-Data Stored in PC03

--Check Purchase Order Header PC01 for PGKDUR with 2020 Orders (note one to many relationship)
SELECT * FROM PC010100 WHERE PC01003='PGKDUR' AND PC01015 >='2020-01-01'

--Confirm Order Lines in Purchase Order Lines PC03 (note many to one/many to many relationsip)
SELECT * FROM PC030100 WHERE PC03001 IN ('7100012616', '7100012617', '7100013000',
'7100013002', '7100013355', '7100013545', '7200017073', '7200017076', '7200017860',
'7200017916', '7200017969')

----Extract Supplier Detail PL01
SELECT * FROM PL010100 WHERE PL01001='PGKDUR'

----Check purchase ledger lines PL03
SELECT * FROM PL030100 WHERE PL03001 = 'PGKDUR' AND PL03004 >= '2020-01-01'