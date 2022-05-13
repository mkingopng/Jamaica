SELECT
    PL21001, --supplier code
    PL01002,
    PL21002,
    PL21003,
    PL21004, --invoice number
    PL21005,
    PL21006, --transaction date
    PL21007,
    PL21008,
    PL21009,
    PL21010,
    PL21011, --payment sent
    PL21012,
    PL21013,
    PL21014,
    PL21015,
    PL21016
--, PL21020 --payment remark

FROM ScaCompanyDB..PL210100

INNER JOIN ScaCompanyDB..PL010100 ON PL21001 = PL01001
WHERE PL21006 >= '2020-10-01' ORDER BY PL21006 DESC