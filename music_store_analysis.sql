1)who is the senior most  employee based on job title?
select * from employee
order by levels desc
limit 1;

2)which countries have the most invoices?
select count(*) as c,billing_country
from invoice
group by billing_country
order by c desc;

select * from invoice;
3)what are the top 3 values of total invoice?
select total from invoice
order by total desc
limit 3;

4)which city has the best customers? we would like to throw promotional Musical festival in the city we made the most money.Write a query
that returns one city that has the highest sum of invoice totals.returns both the city name and sum of all invoice totals.
select sum(total) as invoice_total,billing_city
from invoice
group by billing_city
order by invoice_total desc;


5)who is the customer?the customer who has spent the most money will be declared the best customer.
select c.customer_id,c.first_name,c.last_name,sum(i.total)as total
from customer c
join invoice i on c.customer_id = i.customer_id
group by c.customer_id
order by total desc
limit 1;

6)write query to return the email,firstname,lastname and genre of all Rock Music
listeners.Return your list ordered alphabetically by email starting with A.
select distinct email,first_name,last_name
from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line ivl on i.invoice_id = ivl.invoice_id
where track_id IN(
	select track_id from track t
	join genre g on t.genre_id = g.genre_id
where g.name LIKE 'Rock')
 order by email asc;
 
 7) LETS INVITE THE ARTISTS WHO HAVE WRITTEN THE MOST ROCK MUSIC OUR DATASET.
 WRITE A QUERY THAT RETURNS THE ARTIST NAME AND TOTAL TRACK COUNT OF THE TOP 10 ROCK BANDS
 
 SELECT a1.artist_id,a1.name,COUNT(a1.artist_id) AS number_of_songs
 FROM track t
 join album a on a.album_id = t.album_id
 join artist a1 ON a1.artist_id = a.artist_id
 join genre g ON g.genre_id =t.genre_id
 where g.name like 'Rock'
 group by a1.artist_id
 order by number_of_songs desc
 limit 10;
 
 8) RETURN ALL THE TRACK NAMES THAT HAVE A SONG LENGTH LONGER THAN THE AVERAGE SONG LENGTH.RETURN THE NAME AND MILLISECONDS FOR
 EACH TRACK.ORDER BY THE SONG LENGTH WITH THE LONGEST SONGS LISTED FIRST.
 
 SELECT name,milliseconds
 from track
 where milliseconds >(SELECT AVG(milliseconds) as avg_track_length
					 from track)
order by milliseconds desc;

9)find how much amount spent by each customer on artists? write a query to return customer name,
artist name and total spent.

with best_selling_artist as(
select artist.artist_id as artist_id,artist.name as artist_name,
sum(invoice_line .unit_price*invoice_line.quantity) as total_sales
from invoice_line
join track on track.track_id =invoice_line.track_id
join album on album.album_id =track.album_id
join artist on artist.artist_id =album.artist_id
	group by 1
	order by 3 desc
	limit 1
)
select c.customer_id,c.first_name,c.last_name,bsa.artist_name,
sum(il.unit_price*il.quantity) as amount_spent
from invoice i
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id =i.invoice_id
join track t on t.track_id =il.track_id
join album alb on alb.album_id =t.album_id
join best_selling_artist bsa on bsa.artist_id =alb.artist_id
group by 1,2,3,4
order by 5 desc;

10)We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres.

WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1

--method-2
WITH RECURSIVE
	sales_per_country AS(
		SELECT COUNT(*) AS purchases_per_genre, customer.country, genre.name, genre.genre_id
		FROM invoice_line
		JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
		JOIN customer ON customer.customer_id = invoice.customer_id
		JOIN track ON track.track_id = invoice_line.track_id
		JOIN genre ON genre.genre_id = track.genre_id
		GROUP BY 2,3,4
		ORDER BY 2
	),
	max_genre_per_country AS (SELECT MAX(purchases_per_genre) AS max_genre_number, country
		FROM sales_per_country
		GROUP BY 2
		ORDER BY 2)

SELECT sales_per_country.* 
FROM sales_per_country
JOIN max_genre_per_country ON sales_per_country.country = max_genre_per_country.country
WHERE sales_per_country.purchases_per_genre = max_genre_per_country.max_genre_number;

11)Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount.

WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1

--method-2
WITH RECURSIVE 
	customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 2,3 DESC),

	country_max_spending AS(
		SELECT billing_country,MAX(total_spending) AS max_spending
		FROM customter_with_country
		GROUP BY billing_country)

SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
FROM customter_with_country cc
JOIN country_max_spending ms
ON cc.billing_country = ms.billing_country
WHERE cc.total_spending = ms.max_spending
ORDER BY 1;


 