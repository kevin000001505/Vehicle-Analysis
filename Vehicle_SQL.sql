--data_cleaning--
UPDATE vehicle
SET car_make = LOWER(car_make)

UPDATE vehicle
SET car_body = LOWER(car_body)


--1. Number of cars sold by each car seller--
SELECT car_seller, COUNT(car_seller) as counts FROM vehicle
GROUP BY car_seller
ORDER BY counts DESC
--top 20--
LIMIT 20;


--2. Most sales car make--
SELECT car_make, COUNT(car_make) as counts FROM vehicle
GROUP BY car_make
ORDER BY counts DESC
--top 20--
LIMIT 20;


--3. Which body sells the most?--
SELECT car_body,  COUNT(car_body) as counts FROM vehicle
GROUP BY car_body
ORDER BY counts DESC
--top 20--
LIMIT 20;


--4. Each seller mean selling price
SELECT car_seller as seller, ROUND(AVG(car_sellingprice),2) as mean_selling_price FROM vehicle
GROUP BY seller
HAVING AVG(car_sellingprice) IS NOT NULL
ORDER BY mean_selling_price  DESC


--5. Each manufacturer best selling body--
WITH t1 AS(
SELECT car_make make, car_body body, COUNT(*) counts FROM vehicle
GROUP BY make, body
),
t2 AS(
SELECT ROW_NUMBER() OVER(PARTITION BY make ORDER BY t1.counts DESC) as rowNumber, make, body, t1.counts
FROM t1
)
SELECT INITCAP(make) make ,INITCAP(body) body, counts FROM t2
WHERE t2.rowNumber = 1 AND body IS NOT NULL
ORDER BY counts DESC


--6. WHich color sell the best?
SELECT car_color, COUNT(car_color) counts
FROM vehicle
WHERE car_color IS NOT NULL AND car_color  !~ '[0-9]'
GROUP BY car_color
ORDER BY counts DESC


--7. Did car more lastest get better price?
SELECT car_year as years, ROUND(AVG(car_sellingprice), 2) FROM vehicle
GROUP BY years
ORDER BY years


--8. Each condition mean selling price
SELECT car_condition as conditions, ROUND(AVG(car_sellingprice), 2) FROM vehicle
GROUP BY conditions
HAVING car_condition IS NOT NULL
ORDER BY conditions


--9. Best selling state 
SELECT car_state as states, COUNT(car_state) counts
FROM vehicle
GROUP BY states
HAVING LENGTH(car_state) < 3
ORDER BY counts DESC


--10. Best sales date
SELECT SPLIT_PART(car_saledate, ' ', 2) as months, COUNT(*)
FROM vehicle
WHERE SPLIT_PART(car_saledate, ' ', 2) IS NOT NULL
GROUP BY months
HAVING LENGTH(SPLIT_PART(car_saledate, ' ', 2)) = 3





