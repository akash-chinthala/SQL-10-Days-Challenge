
--  1. Calculate the sum of distinct sale values for each category.
-- ans
select sum(distinct total_sale) as total_rev ,category from sales_data
group by category;

--  2. Calculate total spending per customer for the categories 'electronics' and 'clothing;'
-- ans
select customer_id ,category ,sum(total_sale) from sales_data
where category in ("electronics","clothing")
group by customer_id,category;

--  3. .Retrieve 5 customers who made purchases on '2022-06-07', showing their total spending using LIKE and DISTINCT.
-- ans
select  distinct(customer_id ),sale_date,sum(total_sale) from sales_data
where sale_date like "2022-06-07"
group by customer_id,sale_date
order by customer_id desc
limit 5;


--  4. Calculate total quantity sold per category.
-- ans

select sum(quantiy) as total_qty ,category from sales_data
group by category;

--  5. Calculate monthly revenue for each category based on the sale date.
-- ans
select extract(month from sale_date) as month_rev,sum(total_sale),category from sales_data
group by extract(month from sale_date) ,category
order by month_rev asc;


--  6. Find category generating the highest revenue.
-- ans
select category,sum(total_sale) as highest_sale from  sales_data
group by category 
order by category desc
limit 1;

--  7. Calculate average spending per customer. ₹ 
-- ans
select customer_id,concat(round(avg(total_sale),1),"₹")  as avg_spend from sales_data
group by customer_id;


--  8. Identify customers who made more than 5 transactions.
-- ans
select customer_id,count(transactions_id)from sales_data
group by customer_id
having count(transactions_id) > 5
order by customer_id asc;


--  9. Calculate daily transaction counts.
-- ans
select sale_date,count(transactions_id) as daily_trans from sales_data
group by sale_date
order by sale_date asc;

-- 10. Identify top 2 categories with highest sales.
-- ans
select category,sum(total_sale) as ts from sales_data
group by category
order by ts desc
limit 2;

