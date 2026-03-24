-- 1.Group customers by first purchase month
-- ans

select customer_id,extract(month from min(sale_date)) as first_mon from sales_data
group by customer_id;


-- 2.Calculate retention by cohort 
-- ans

with c as (
    select customer_id, extract(month from min(sale_date)) as cohort from sales_data
    group by customer_id )
select c.cohort,extract(month from s.sale_date) as activity_month,count(DISTINCT s.customer_id) as customers
from c join sales_data s on c.customer_id = s.customer_id
group by c.cohort, activity_month;

-- 3.Find customers with consecutive month purchases
-- ans

select distinct customer_id from 
(select customer_id,extract(month from sale_date) as months,lag(extract(month from sale_date)) over(partition by customer_id order by sale_date) as prev_month
from sales_data) t
where months = prev_month + 1;


-- 4.Get top 10 customers per month by sales
-- ans

select * from (
select extract(month from sale_date) as month_val,customer_id,sum(total_sale) as revenue,
rank() over (partition by extract(month from sale_date) order by sum(total_sale) desc) as rnk from sales_data
group by extract(month from sale_date), customer_id) t
where rnk <= 10;

-- 5.Analyze monthly sales by category
-- ans

select extract(month from sale_date) as mon,category ,sum(total_sale) as rev from sales_data
group by mon, category;



-- 6.Segment customers by purchase frequency
-- ans

select customer_id,count(transactions_id) as orders,
case when count(transactions_id) >= 10 then 'high'
   when count(transactions_id) >= 5 then 'medium'
   else 'low'end as segment
from sales_data
group by customer_id;

-- 7.Find customers contributing 50% revenue
-- ans

with t as (
    select customer_id, sum(total_sale) as revenue from sales_data
    group by customer_id),
r as (
    select *,sum(revenue) over(order by revenue desc) as running_total,sum(revenue) over() as total
    from t )
select *from r where running_total <= total * 0.5;



-- 8.Compute RFM (Recency, Frequency, Monetary)
-- ans

select customer_id,max(sale_date) as recency,count(sale_date) as frequency,sum(total_sale) as monetary from sales_data
group by customer_id;


-- 9.Calculate avg revenue per customer
-- ans

select customer_id,avg(total_sale) as avg_revenue from sales_data
group by customer_id;


-- 10.Find frequently bought category pairs
-- ans

select a.category as cat1,b.category as cat2,count(*) as freq from sales_data a
join sales_data b on a.customer_id = b.customer_id
and a.category < b.category
group by cat1, cat2
order by freq desc;




