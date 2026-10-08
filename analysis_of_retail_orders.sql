CREATE DATABASE retail; -- create a data base named as retail
USE retail; -- activate it

SHOW TABLES;

DESCRIBE `order`; -- This way we know that what are the constraints and what are the data types, we need to correct
ALTER TABLE `order`
MODIFY `order_id` INT,
MODIFY `order_date` DATE,
MODIFY `ship_mode`VARCHAR(40),
MODIFY `segment` VARCHAR(40),
MODIFY `country` VARCHAR(40),
MODIFY `city` VARCHAR(80),
MODIFY `state` VARCHAR(80),
MODIFY `postal_code` INT,
MODIFY `region` VARCHAR(20),
MODIFY `category`VARCHAR(20),
MODIFY `sub_category` VARCHAR(30),
MODIFY `product_id` VARCHAR(80),
MODIFY `cost_price` FLOAT,
MODIFY `list_price` FLOAT,
MODIFY `quantity` INT,
MODIFY `discount_amount` FLOAT,
MODIFY `net_sale_price` FLOAT,
MODIFY `profit` FLOAT;


DESCRIBE `order`;

-- lets see the table
SELECT * FROM `order`;

-- 1. What are yearly and montly sales and profit
SELECT 
YEAR(`order_date`) AS 'year',
MONTH(`order_date`) AS 'month',
CONCAT('$ ',FORMAT(SUM(`quantity`*`net_sale_price`),2)) AS 'Net_Sales' 
FROM `order`
GROUP BY YEAR(`order_date`), MONTH(`order_date`)
ORDER BY `year` DESC, `month` DESC;

/* o/p
year, month, Net_Sales
'2023','12','$ 491,848.90'
'2023','11','$ 334,940.60'
'2023','10','$ 626,498.30'
'2023','9','$ 420,620.50'
'2023','8','$ 465,010.30'
'2023','7','$ 422,533.70'
'2023','6','$ 328,939.00'
'2023','5','$ 410,707.90'
'2023','4','$ 543,231.50'
'2023','3','$ 393,051.90'
'2023','2','$ 731,638.80'
'2023','1','$ 434,765.50'
'2022','12','$ 447,421.80'
'2022','11','$ 451,809.60'
'2022','10','$ 601,707.80'
'2022','9','$ 433,887.00'
'2022','8','$ 534,562.40'
'2022','7','$ 375,278.40'
'2022','6','$ 465,300.30'
'2022','5','$ 413,625.50'
'2022','4','$ 476,400.90'
'2022','3','$ 394,105.20'
'2022','2','$ 444,011.10'
'2022','1','$ 437,431.30'

*/



-- 2. how many types of SKUs got sold and also per group
WITH categ_prod AS(
SELECT 
`category`, COUNT(DISTINCT `product_id`) AS 'no_of_unique_products_sold'
FROM `order`
GROUP BY `category`),
total_prod AS(
SELECT SUM(`no_of_unique_products_sold`) AS 'total_unique_product_sold' FROM categ_prod)
SELECT *, ROUND((`no_of_unique_products_sold`/`total_unique_product_sold`)*100,2) AS '%age_contribution_in_total' 
FROM categ_prod CROSS JOIN total_prod;


/*
category, no_of_unique_products_sold, total_unique_product_sold, %age_contribution_in_total
'Furniture','375','1862','20.14'
'Office Supplies','1083','1862','58.16'
'Technology','404','1862','21.70'
*/

-- 3. Top 10 product which generate highest revenue
SELECT 
`product_id`,ROUND(SUM(`quantity`*`net_sale_price`),2) AS 'total_sales'
FROM `order`
GROUP BY `product_id`
ORDER BY `total_sales` DESC LIMIT 10;

-- 4. Top categories generate highest revenue
SELECT 
`category`,CONCAT('$ ',FORMAT(SUM(`quantity`*`net_sale_price`),2)) AS 'total_sales'
FROM `order`
GROUP BY `category`
ORDER BY SUM(`quantity`*`net_sale_price`) DESC;

/* output
category, total_sales
'Technology','$ 3,934,910.70'
'Furniture','$ 3,720,742.39'
'Office Supplies','$ 3,423,675.10'

*/

-- 5. which top 5 city generate highest revenue
SELECT 
`city`,CONCAT('$ ',FORMAT(SUM(`quantity`*`net_sale_price`),2)) AS 'total_sales'
FROM `order`
GROUP BY `city`
ORDER BY SUM(`quantity`*`net_sale_price`) DESC
LIMIT 5;
/*
city, total_sales
'New York City','$ 1,218,342.60'
'Los Angeles','$ 842,734.80'
'Seattle','$ 577,155.70'
'Philadelphia','$ 548,049.30'
'San Francisco','$ 522,682.60'
*/

-- 6. Top 5 highest selling product in each region
WITH region_wise_top_prod AS(
SELECT 
`region`,`product_id`,SUM(`quantity`*`net_sale_price`) AS 'total_sales',
DENSE_RANK()OVER(PARTITION BY `region` ORDER BY SUM(`quantity`*`net_sale_price`) DESC) AS 'ranks'
FROM `order`
GROUP BY `region`,`product_id`)
SELECT 
`region`, `product_id`, 
CONCAT('$ ',FORMAT(`total_sales`,2)) AS 'total_sales'
FROM region_wise_top_prod
WHERE `ranks`<=5;

/*
region, product_id, total_sales
'Central','OFF-BI-10000545','$ 125,827.50'
'Central','TEC-CO-10004722','$ 84,875.00'
'Central','TEC-MA-10000822','$ 77,509.80'
'Central','OFF-BI-10001120','$ 55,282.50'
'Central','OFF-BI-10004995','$ 42,210.00'
'East','TEC-CO-10004722','$ 106,421.00'
'East','TEC-MA-10001047','$ 81,549.00'
'East','FUR-BO-10004834','$ 66,364.20'
'East','TEC-CO-10001449','$ 60,948.00'
'East','FUR-CH-10002024','$ 60,189.60'
'South','TEC-MA-10002412','$ 130,406.40'
'South','TEC-PH-10001459','$ 73,932.10'
'South','FUR-TA-10000198','$ 68,789.90'
'South','TEC-MA-10001127','$ 50,499.20'
'South','OFF-BI-10003527','$ 32,029.40'
'West','TEC-AC-10003832','$ 61,170.80'
'West','TEC-CO-10004722','$ 53,760.00'
'West','OFF-SU-10000151','$ 53,337.90'
'West','FUR-TA-10003473','$ 52,669.50'
'West','FUR-CH-10003973','$ 43,596.40'
*/

-- 7. YOY sales 
WITH yoy AS(
SELECT
MONTH(`order_date`) AS 'month_number',DATE_FORMAT(`order_date`,'%M') AS 'month',
CONCAT('$ ',FORMAT(SUM(COALESCE(CASE WHEN YEAR(`order_date`) = 2023 THEN (`quantity`*`net_sale_price`) END,0)),2)) AS '2023_total_sale',
CONCAT('$ ',FORMAT(SUM(COALESCE(CASE WHEN YEAR(`order_date`) = 2022 THEN (`quantity`*`net_sale_price`) END,0)),2)) AS '2022_total_sale'
FROM `order`
GROUP BY MONTH(`order_date`),DATE_FORMAT(`order_date`,'%M')
ORDER BY MONTH(`order_date`))
SELECT `month`, `2023_total_sale`, `2022_total_sale` FROM yoy;


/*output
month, 2023_total_sale, 2022_total_sale
'January','$ 434,765.50','$ 437,431.30'
'February','$ 731,638.80','$ 444,011.10'
'March','$ 393,051.90','$ 394,105.20'
'April','$ 543,231.50','$ 476,400.90'
'May','$ 410,707.90','$ 413,625.50'
'June','$ 328,939.00','$ 465,300.30'
'July','$ 422,533.70','$ 375,278.40'
'August','$ 465,010.30','$ 534,562.40'
'September','$ 420,620.50','$ 433,887.00'
'October','$ 626,498.30','$ 601,707.80'
'November','$ 334,940.60','$ 451,809.60'
'December','$ 491,848.90','$ 447,421.80'

*/

-- 8. For each category which month highest sales
WITH categ_month_sale AS (
SELECT 
`category`,DATE_FORMAT(`order_date`,'%Y-%m') AS 'year-month',ROUND(SUM(`quantity`*`net_sale_price`),2) AS 'total_sale',
DENSE_RANK() OVER(PARTITION BY `category` ORDER BY SUM(`quantity`*`net_sale_price`) DESC) AS 'ranks'
FROM `order`
GROUP BY `category`,DATE_FORMAT(`order_date`,'%Y-%m')
) 
SELECT `category`, `year-month`, `total_sale` 
FROM categ_month_sale WHERE `ranks` = 1
;

/*output
category, year-month, total_sale
'Furniture','2023-08','230523.5'
'Office Supplies','2023-02','287244.6'
'Technology','2023-10','295586.5'

*/

-- 9. which sub category had highest growth by profit in 2023 compare to 2022
WITH sub_cat_profit AS (
SELECT 
`sub_category`,
SUM(COALESCE(CASE WHEN YEAR(`order_date`)=2023 THEN (`quantity`*`profit`) END,0)) AS '2023_year_profit',
SUM(COALESCE(CASE WHEN YEAR(`order_date`)=2022 THEN (`quantity`*`profit`) END,0)) AS '2022_year_profit'
FROM `order`
GROUP BY `sub_category`)
SELECT `sub_category`,
CONCAT('$ ',FORMAT(`2023_year_profit`,2)) AS '2023_year_profit',
CONCAT('$ ',FORMAT(`2022_year_profit`,2)) AS '2022_year_profit',
ROUND((`2023_year_profit`/`2022_year_profit`-1)*100,2) AS '%age growth' FROM sub_cat_profit
ORDER BY `%age growth` DESC
LIMIT 1
;
/*
sub_category, 2023_year_profit, 2022_year_profit, %age growth
'Supplies','$ 9,241.50','$ 5,161.00','79.06'
*/