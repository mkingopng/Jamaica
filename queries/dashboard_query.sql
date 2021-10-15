
DECLARE @InvoiceDate DATETIME2= GETDATE();

SELECT
    ST03014 AS 'INVOICE_NUMBER',
    ST03020 AS 'QTY_INVOICED',
    ST03021 AS 'UNIT_NET_PRICE',
    ST03062 AS 'SALES_ORDER_LINE_NUMBER',
    (ST03020 * ST03021) AS 'SALES_VALUE',
    CAST(ST03015 AS DATE)AS 'INVOICE_DATE',
    ST03030 AS 'FULLY_SHIPPED?',
    DATEPART(WK, ST03015) AS 'WEEK_ID',
    SUBSTRING(CONVERT(VARCHAR,ST03015,112),0,5) AS 'YEAR_ID',
    SUBSTRING(ST03011,13,6) AS 'ALT_PRODUCT_GROUP',
    ST03017 AS 'STOCK_CODE',
    SC01002 AS 'PRODUCT_DESCRIPTION',
    ST03007 AS 'SALES_PERSON',
    SUBSTRING(ST03011,7,6) AS 'CC',
    GL03003 AS 'TEAM',
    SL01001 AS 'CUSTOMER_CODE',
    SL01002 AS 'CUSTOMER_NAME',
    SL01011 AS 'CUSTOMER_PHONE',
    SL01003 AS 'CUSTOMER_ADDRESS_1',
    SL01004 AS 'CUSTOMER_ADDRESS_2',
    ST03005 AS 'CITY',
    SUBSTRING(ST03001, 0, 4) AS 'PROVINCE'
    
FROM [ScaCompanyDB]..ST030100	
INNER JOIN [ScaCompanyDB]..SC010100 ON SC01001=ST03017
INNER JOIN [ScaCompanyDB]..SL010100 ON SL01001=ST03001
INNER JOIN [ScaCompanyDB]..GL030100 ON SUBSTRING(ST03011,7,2)=GL03002
WHERE ST03015 > '2020-01-01'
ORDER BY ST03015 DESC;
