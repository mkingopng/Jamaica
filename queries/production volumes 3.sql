use ScaCompanydb

-- create VIEW OR SUBQUERY FOR CATEGORIES -- BLEACH, OIL, ROTOMOULDING, PAPER, LDP
-- CREATE VIEW bleach AS
SELECT
	DISTINCT(DATEPART(MONTH, SC07002) + DATEPART(YEAR, SC07002)) AS 'date',
	SUM(SC07004)AS production
FROM SC070100
WHERE SC07001='00' AND SC07003='10-01-0114';


SELECT
	AS 'month'  -- commence january 2020 to present.
	SUM() AS 'total litres of bleach 10%',  --  WHAT IS THE PRODUCT CODE FOR BULK 3.5% BLEACH?
	SUM() AS 'total litres of bleach 3.5%',  -- WHAT IS THE PRODUCT CODE FO BULK 10% BLEACH?
	SUM() AS 'total kgs of Super Palm Olein packed',  -- WHAT IS THE PRODUCT CODE FOR 1V60?
	SUM() AS 'total kgs of powder converted'  -- rotomoulding
FROM MP640121  -- HOW DO I INCLUDE 2020?
WHERE 
HAVING
GROUP BY -- month
ORDER BY DESC;
