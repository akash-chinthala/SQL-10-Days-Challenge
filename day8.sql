-- 1. Calculate Customer Lifetime Value (CLV).
-- ans
select customer_id,sum(total_sale) as total,count(distinct sale_date) as active_days
from sales_data
group by customer_id;


-- 2. Identify repeat customers (customers with multiple transactions).
-- ans
select customer_id,count(transactions_id) as trans_count from sales_data
group by customer_id
having count(transactions_id) >1
order by trans_count desc;



-- 3.Find revenue for each month
-- ans

select month(sale_date) as month,SUM(total_sale) as revenue
from sales_data
group by month(sale_date);


-- 4.Count unique customers
-- ans

select COUNT(distinct customer_id) as unique_customers
from sales_data;


-- 5.Find customer with highest total spending
-- ans
select customer_id,sum(total_sale) as total_spent from sales_data
group by customer_id
order by total_spent desc
limit 1;



-- 6. Identify top 10% customers by spending.
-- ans

select * from (
select customer_id,sum(total_sale) as spent ,percent_rank() over(order by sum(total_sale) desc) as per_ranked
from sales_data 
group by customer_id
) t 
where per_ranked >=0.9;



-- 7. Find fastest selling category (by quantity).
-- ans

select category,sum(quantiy) as tot_quant from sales_data
group by category
order by tot_quant desc
limit 1;


-- 8. Find category with lowest revenue
-- ans

select category,sum(total_sale) AS revenue from sales_data
group by category
order by revenue asc
limit 1;


-- 9. Calculate average basket size (average quantity per transaction).
-- ans

select avg(quantiy) as avg_bask
from (
    select transactions_id, sum(quantiy) as quantiy from sales_data
    group by transactions_id
) t;

-- 10. Identify customers with highest purchase frequency
-- ans

select customer_id ,count(total_sale) as total_freq from sales_data
group by customer_id
order by total_freq desc
limit 1;





