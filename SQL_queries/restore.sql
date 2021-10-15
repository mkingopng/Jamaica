 RESTORE FILELISTONLY FROM DISK = '/home/michaelkingston/ScaCompanyDB/ScaCompanyDB.bak'
 
RESTORE DATABASE ScaCompanyDB
FROM DISK = '/home/michaelkingston/ScaCompanyDB/ScaCompanyDB.bak'
WITH MOVE 'SCADEV1' TO '/var/opt/mssql/data/dbname.mdf',
MOVE 'SCALOG' TO '/var/opt/mssql/data/dbname.ldf'
