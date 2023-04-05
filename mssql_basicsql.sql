select * from production.brands;
select * from production.categories;
select * from production.products;
select * from production.stocks;
select * from sales.customers;
select * from sales.order_items;
select * from sales.orders;
select * from sales.staffs;
select * from sales.stores;


select first_name,last_name from 
sales.customers;

select first_name,last_name,email
from sales.customers;

select *
from sales.customers;

select * 
from sales.customers
where state ='CA';

SELECT *
FROM sales.customers
WHERE STATE ='CA'
ORDER BY first_name;

SELECT city,COUNT(*) as count
FROM sales.customers
where state = 'CA'
GROUP BY city
ORDER BY city;

SELECT city,COUNT(*)
FROM sales.customers
WHERE state = 'CA'
GROUP BY city
HAVING COUNT(*)>10
ORDER BY city;

SELECT first_name,last_name
FROM sales.customers
ORDER BY first_name ;

SELECT first_name,last_name
FROM sales.customers
ORDER BY first_name desc;

SELECT city,first_name,last_name
FROM sales.customers
ORDER BY city,first_name;

SELECT city,first_name,last_name
FROM sales.customers
ORDER BY city DESC,first_name ASC;

SELECT city,first_name,last_name
FROM sales.customers
ORDER BY state;

SELECT first_name,last_name
FROM sales.customers
ORDER BY LEN(first_name) DESC;

SELECT first_name,last_name
FROM sales.customers
ORDER BY 1,2;

SELECT product_name,list_price
FROM production.products
ORDER BY list_price,product_name;

SELECT product_name,list_price
FROM production.products
ORDER BY list_price,product_name
OFFSET 10 ROWS;

SELECT product_name,list_price
FROM production.products
ORDER BY list_price,product_name
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

SELECT product_name,list_price
FROM production.products
ORDER BY list_price DESC,product_name
OFFSET 0 ROWS
FETCH FIRST 10 ROWS ONLY;


-- top 10 most expensive products

SELECT TOP 10
	product_name,
	list_price
FROM
	production.products
ORDER BY 
	list_price DESC;

SELECT TOP 1 PERCENT
product_name,list_price
FROM production.products
ORDER BY list_price DESC;

--TOP 3 PRODUCTS WITH MORE PRODUCTS WITH MORE PRODUCTS WHOSE LIST_PRICE IS SAME AS THIRD ONE.

SELECT TOP 3 WITH TIES
product_name,
list_price
FROM production.products
ORDER BY list_price DESC;

---DISTINCT
SELECT DISTINCT
	city 
FROM sales.customers
ORDER BY city;

SELECT DISTINCT
	city,state
FROM 
sales.customers;

SELECT DISTINCT
	phone
FROM sales.customers
ORDER BY phone;

SELECT 
	city,
	state,
	zip_code
FROM sales.customers
GROUP BY city,state,zip_code
ORDER BY city,state,zip_code;

SELECT
	product_id,
	product_name,
	category_id,
	model_year,
	list_price
FROM 
	production.products
WHERE
	category_id =1
ORDER BY
	list_price DESC;

SELECT
	product_id,
	product_name,
	category_id,
	model_year,
	list_price
FROM
	production.products
WHERE
	category_id =1 AND model_year =2018
ORDER BY
	list_price DESC;

	--all products with the category id 1:

SELECT product_id,product_name,category_id,model_year,list_price
FROM production.products
WHERE category_id =1
ORDER BY list_price DESC;

--all products with the category id 1 AND model_year =2018:
SELECT product_id,product_name,category_id,model_year,list_price
FROM production.products
WHERE category_id = 1 AND model_year =2018
ORDER BY list_price DESC;

SELECT product_id,product_name,category_id,model_year,list_price
FROM production.products
WHERE list_price > 300 AND model_year =2018
ORDER BY
	list_price DESC;

SELECT product_id,product_name,category_id,model_year,list_price
FROM production.products
WHERE list_price > 3000 OR model_year =2018
ORDER BY list_price DESC;

SELECT product_id,product_name,category_id,model_year,list_price
FROM production.products
WHERE list_price BETWEEN 1899.00 and 1999.99
ORDER BY list_price DESC;

SELECT product_id,product_name,category_id,model_year,list_price
FROM production.products
WHERE list_price IN (299.99,369.99,489.99)
ORDER BY list_price DESC;

 --find products whose name contains the string Cruiser:
 SELECT product_id,product_name,category_id,model_year,list_price
 FROM production.products
 WHERE product_name LIKE '%Cruiser%'
 ORDER BY list_price;

SELECT customer_id,first_name,last_name,phone
FROM sales.customers
WHERE phone = NULL
ORDER BY first_name,last_name;--this doesnot work

SELECT customer_id,first_name,last_name,phone
FROM sales.customers
WHERE phone IS NULL
ORDER BY first_name,last_name;

SELECT customer_id,first_name,last_name,phone
FROM sales.customers
WHERE phone IS NOT NULL
ORDER BY first_name,last_name;

--using AND operator
SELECT * 
FROM production.products
WHERE category_id =1
AND list_price>400
ORDER BY list_price DESC;

SELECT *
FROM production.products
WHERE category_id=1
AND list_price >400
AND brand_id =1
ORDER BY list_price DESC;

SELECT *
FROM production.products
WHERE brand_id =1
OR brand_id =2
AND list_price >1000
ORDER BY brand_id DESC;

--To get the product whose brand id is one or two and list price is larger than 1,000.

SELECT *
FROM production.products
WHERE (brand_id =1 or brand_id =2)
AND list_price >1000
ORDER BY brand_id;

SELECT product_name,list_price
FROM production.products
WHERE list_price < 200
OR list_price > 6000
ORDER BY list_price;


SELECT product_name,brand_id
FROM production.products
WHERE brand_id =1
OR brand_id =2
OR brand_id =4
ORDER BY brand_id DESC;

SELECT product_name,brand_id
FROM production.products
WHERE brand_id IN(1,2,3)
ORDER BY brand_id DESC;

SELECT product_name,brand_id,list_price
FROM production.products
WHERE brand_id =1
	OR brand_id = 2
	AND list_price >500
ORDER BY brand_id DESC,list_price;

SELECT product_name,brand_id,list_price
FROM production.products
WHERE (brand_id = 1 OR brand_id =2)
AND list_price > 500
ORDER BY brand_id;

--IN OPERATOR
SELECT product_name,list_price
FROM production.products
WHERE list_price IN(89.99,109.99,159.99)
ORDER BY list_price;

SELECT product_name,list_price
FROM production.products
WHERE list_price =89.99 OR list_price =109.99 OR list_price = 159.99
ORDER BY list_price;

SELECT product_name,list_price
FROM production.products
WHERE list_price NOT IN(89.99,109.99,159.99)
ORDER BY list_price;

SELECT product_id
FROM production.stocks
WHERE store_id = 1 AND quantity >=30;

SELECT product_name,list_price
FROM production.products
WHERE product_id IN(
	SELECT product_id FROM production.stocks WHERE store_id =1 AND quantity >=30)
	order by product_name;

---IN operator
SELECT product_name,list_price
FROM production.products
WHERE list_price IN (89.99,109.99,159.99)
order by list_price;

SELECT product_name,list_price
FROM production.products
WHERE list_price =89.99 OR list_price = 109.99 OR list_price = 159.99
ORDER BY list_price;

SELECT product_name,list_price
FROM production.products
WHERE list_price NOT IN (89.99,109.99,159.99)
ORDER BY list_price;

SELECT product_id
FROM production.stocks
WHERE store_id =1 AND quantity >= 30;

SELECT product_name,list_price
FROM production.products
WHERE product_id IN( SELECT 
product_id FROM production.stocks
WHERE store_id =1 AND quantity >=30
)
ORDER BY product_name;

--BETWEEN OPERATOR
SELECT product_id,product_name,list_price
FROM production.products
WHERE list_price BETWEEN 149.99 AND 199.99
ORDER BY list_price;

SELECT product_id,product_name,list_price
FROM production.products
WHERE list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY list_price;

SELECT order_id,customer_id,
order_date,order_status
FROM sales.orders
WHERE order_date BETWEEN '20170115' AND '20170117'
ORDER BY order_date;

SELECT customer_id,first_name,
last_name
FROM sales.customers
WHERE last_name LIKE '%z'
order by first_name;

SELECT customer_id,first_name,
last_name
FROM sales.customers
WHERE last_name LIKE '%er'
ORDER BY first_name;

SELECT customer_id,first_name,
last_name
FROM sales.customers
WHERE last_name LIKE 't%s'
ORDER BY first_name;

SELECT customer_id,first_name,
last_name
FROM sales.customers
WHERE last_name LIKE '_u%'
ORDER BY first_name;

SELECT customer_id,
first_name,
last_name
FROM sales.customers
WHERE last_name LIKE '[YZ]%'
ORDER BY last_name;

SELECT customer_id,
first_name,
last_name
FROM sales.customers
WHERE last_name LIKE '[A-C]%'
ORDER BY first_name;

SELECT customer_id,
first_name,
last_name
FROM sales.customers
WHERE last_name LIKE '[^A-X]%'
ORDER BY last_name;

SELECT customer_id,first_name,last_name
FROM sales.customers
WHERE first_name NOT LIKE '%A'
ORDER BY first_name;

CREATE TABLE sales.feedbacks(
feedback_id INT IDENTITY(1,1) PRIMARY KEY,
comment VARCHAR(255) NOT NULL
);

INSERT INTO sales.feedbacks(comment)
VALUES('Can you give me 30% discount'),
	('May i get me 30USD off?'),
	('Is this having 20% discount today?');

SELECT * FROM sales.feedbacks;

SELECT feedback_id,
comment
FROM sales.feedbacks
WHERE 
comment LIKE '%30%';

SELECT feedback_id,
comment
FROM sales.feedbacks
WHERE comment LIKE '%30!%%' ESCAPE '!';

--ALIASES
SELECT 
	first_name + ' ' + last_name as 'full name'
FROM sales.customers
ORDER BY first_name;

SELECT 
	category_name 'Product category'
from production.categories;

SELECT 
category_name 'Product category'
FROM production.categories
ORDER BY category_name;

SELECT
category_name 'Product category'
FROM production.categories
ORDER BY 'Product Category';

SELECT 
sales.customers.customer_id,
first_name,
last_name,
order_id
FROM sales.customers
INNER JOIN sales.orders ON sales.orders.customer_id = sales.customers.customer_id;

SELECT
c.customer_id,
first_name,
last_name,
order_id
FROM sales.customers c
INNER JOIN sales.orders o ON o.customer_id =c.customer_id;

