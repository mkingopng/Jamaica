use ScaCompanyDB

SELECT
    ST03014  as  [InvoicNumber],
    rtrim(cast(datepart(yyyy,ST03015) as char))+'M'+substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2) "Date\Month", 
    ST03009 as [OrderNumber], 
    ST03015 as [InvOrderDate], 
    SC01001 as [StockCode], 
    SC01002 as [Description1], 
    SC01003 as [Description2], 
    SUM(ST03020)   "Qty", 
    SY24003 as [ProdGrp Descr], 
    SUBSTRING(SL01017,1,6)    "Account", 
    SL01001 as [CustomerCode], 
    SL01002 as [CustomerName], 
    SUBSTRING(ST03011,7,6)    [Cost Centre], 
    SUBSTRING(ST03011,13,6)    [Product], 
    SUM(ST03020 * ST03021)   [Gross Value], 
    SUM(ST03020 * ST03021 * ST03022 / 100)   "Discount",
    SUM((ST03020 * ST03021) - (ST03020 * ST03021 * ST03022 / 100))   "Net Value", 
    SUM(ST03020 * ST03023)   "Cost Value"


 FROM [ScaCompanyDB]..ST030100 T1    INNER JOIN [ScaCompanyDB]..SC010100
                                  ON ST03017 = SC01001

                                  INNER JOIN    [ScaCompanyDB]..SL010100
                                  ON   ST03008 = SL01001

                                  LEFT OUTER JOIN    [ScaCompanyDB]..SY240100 T4
                                  ON   SC01037 = T4.SY24002  AND 'IB' = SY24001

WHERE SUBSTRING(SL01017,1,6)   =  '001020'
AND   rtrim(cast(datepart(yyyy,ST03015) as char))+'M'+substring(cast(cast(datepart(mm,ST03015) as INT)+100 as char),2,2)   Between '2020M01' AND '2021M04'

GROUP BY
	ST03014, 
	rtrim(cast(datepart(yyyy,T1.ST03015) as char))+'M'+substring(cast(cast(datepart(mm,T1.ST03015) as INT)+100 as char),2,2), 
	ST03009, 
	ST03015, 
	SC01001, 
	SC01002, 
	SC01003, 
	SY24003, 
	SUBSTRING(SL01017,1,6), 
	SL01001, 
	SL01002, 
	SUBSTRING(ST03011,7,6),
	SUBSTRING(ST03011,13,6)
 ;