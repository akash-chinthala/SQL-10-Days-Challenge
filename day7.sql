-- 1. Rank customers based on total spending.
-- ans
select customer_id, rank() over(order by sum(total_sale) desc) as ranked, sum(total_sale)  as tot_sale
from sales_data
group by customer_id;

-- 2. Find top 3 customers by spending.
-- ans

select * from (
select customer_id, dense_rank() over( order by sum(total_sale) desc) as rnk ,sum(total_sale) as total
 from sales_data 
 group by customer_id
) t 
  where rnk <= 3;



-- 3. Calculate running total of daily revenue.
-- ans

select sale_date,transactions_id,total_sale, sum(total_sale) over( order by sale_date asc) AS running_total
from sales_data
order by sale_date ;




-- 4. Rank categories based on total revenue.
-- ans

select category,sum(total_sale) as tot_rev, rank() over( order by sum(total_sale) desc)  from sales_data
group by category;


-- 5. Find previous transaction value for each customer.
-- ans

select transactions_id,customer_id,total_sale, lag(total_sale,1) over(partition by customer_id order by sale_date ) as previous_sale 
from sales_data;




-- 6. Calculate difference between current and previous purchase.
-- ans


select total_sale,transactions_id,customer_id ,lag(total_sale,1) over(partition by customer_id order by sale_date) as previous_purchase ,
total_sale - lag(total_sale,1) over(partition by customer_id order by sale_date) as diffrence
from sales_data ;


-- 7. Identify first purchase date for each customer.
-- ans

select sale_date,customer_id,transactions_id,total_sale ,first_value(sale_date) over(partition by customer_id order by sale_date)  as first_cust
from sales_data;



-- 8. Rank transactions by total_sale within each category.
-- ans
select transactions_id,total_sale,category,rank() over( partition by category  order by total_sale desc)  as ranked_cate
from sales_data;


-- 9. Find top sale per category.
-- ans
select * from (
select category,total_sale ,rank() over(partition by category order by total_sale desc) as top_sale 
from sales_data) t 
where top_sale = 1;


-- 10. Assign dense rank to customers by total spending.
-- ans

select * from (
select customer_id,sum(total_sale)as tot_spent,dense_rank() over(order by sum(total_sale)) as dense_ranked
 from sales_data
 group by customer_id
 ) t;




