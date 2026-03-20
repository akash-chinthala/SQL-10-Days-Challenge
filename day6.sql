--  1. Find transactions where total_sale is greater than average sale.
-- ans

SELECT transactions_id,category,quantiy,price_per_unit,total_sale
FROM sales_data
where total_sale > (select avg(total_sale)from sales_data);


--  2. Find the second highest total_sale.
-- ans

select customer_id,total_sale as high_sale from sales_data
order by total_sale desc
limit 1
offset 1;


--  3. Identify transactions where price_per_unit is above average.
-- ans

select transactions_id ,price_per_unit from sales_data
where price_per_unit > (select avg(price_per_unit) from sales_data);


--  4. Find customers who spent more than the average customer spending.
-- ans

select customer_id,sum(total_sale) as tot_spent from sales_data 
group by customer_id
having sum(total_sale)> (select avg(total_sale)from sales_data );


--  5. Identify categories whose average sale is above overall average.
-- ans

select category,concat(round(avg(total_sale),2)," ₹")avg_cate_sale from sales_data
group by category 
having avg(total_sale)>(select avg(total_sale) from sales_data);


--  6. Find the customer who spent the most money.
-- ans
select customer_id,sum(total_sale) as high_sale from sales_data
group by customer_id
order by high_sale desc
limit 1;

--  7. Identify transactions with quantity greater than average quantity.
-- ans

select transactions_id,quantiy from sales_data
where quantiy > (select avg(quantiy) from sales_data);


--  8. Find customers whose total purchases exceed 5000.
-- ans

select customer_id ,sum(total_sale) as max_sale from sales_data
group by customer_id
having max_sale >5000;


--  9. Identify the category with highest total sales.
-- ans

select category,sum(total_sale) as high_sale from sales_data
group by category
order by high_sale desc
limit 1;


--  10. Find customers who purchased from multiple categories.
-- ans

select customer_id,count(distinct category ) as cate_count ,
case when COUNT(DISTINCT category) = 1 then " Single category"
else ' Multiple Category' end as t
from sales_data
group by customer_id;



