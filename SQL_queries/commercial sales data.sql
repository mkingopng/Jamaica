SELECT
    ST03014 AS 'InvoiceNumber',
    rtrim(cast(datepart(yyyy,ST03015) AS char))+'M'+substring(cast(cast(datepart(mm,ST03015) AS INT)+100 AS char),2,2) "Date\Month",
    ST03015 AS 'InvOrderDate',
    SC01001 AS 'ProductID',
    SC01002 AS 'Description1',
    SUM(ST03020) AS 'Quantity',
    SY24003 AS 'ProdGrpDesc',
    SUBSTRING(SL01017,1,6) AS 'Account',
    SL01001 AS 'CustomerID',
    SL01002 AS 'CustomerName',
    SUBSTRING(ST03011,7,6) AS 'CostCentre',
    SUBSTRING(ST03011,13,6) AS 'ProductGroup',
    ST03021 AS 'UnitPrice'

 FROM [ScaCompanyDB]..ST030100 T1    INNER JOIN [ScaCompanyDB]..SC010100
                                  ON ST03017 = SC01001

                                  INNER JOIN    [ScaCompanyDB]..SL010100
                                  ON   ST03008 = SL01001

                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T4
                                  ON   SC01037 = T4.SY24002  AND 'IB' = SY24001

WHERE SUBSTRING(SL01017,1,6)   =  '001020'
	AND rtrim(cast(datepart(yyyy,ST03015) as char))+'M'+substring(cast(cast(datepart(mm,ST03015) AS INT)+100 AS char),2,2) Between '2020M10' AND '2021M4'
	AND	SUBSTRING(ST03011,7,6) = '11' OR SUBSTRING(ST03011,7,6) = '21'	  
	

GROUP BY
	ST03014, 
	rtrim(cast(datepart(yyyy,T1.ST03015) AS char))+'M'+substring(cast(cast(datepart(mm,T1.ST03015) AS INT)+100 AS char),2,2),
	ST03015, 
	ST03021,
	SC01001, 
	SC01002,  
	SUBSTRING(SL01017,1,6), 
	SY24003,
	SL01001, 
	SL01002, 
	SUBSTRING(ST03011,7,6),
	SUBSTRING(ST03011,13,6)
