-- 1. Compare this month’s revenue with last month. Did it go up or down?
-- ans
select current_month,tot_rev,
lag(tot_rev) over(order by current_month ) as previous_month ,
tot_rev-lag(tot_rev) over(order by current_month ) as diff
from (
select extract( month from sale_date) as current_month,sum(total_sale) as tot_rev 
from sales_data
group by extract( month from sale_date) )t;


-- 2. Find customers who did not buy anything in the last 90 days.
-- ans
select customer_id,max(sale_date) as last_date from sales_data
group by customer_id
having max(sale_date) < current_date - interval 90 day;


-- 3. What part (percentage) of total revenue comes from each gender?
-- ans
select sum(total_sale) as revenue, gender ,
sum(total_sale)*100.0/sum(sum(total_sale)) over() as percent
from sales_data
group by gender;


-- 4. For each month, which category made the most money?
-- ans
select mon,category,rev from (
select extract( month from sale_date) as mon,category,sum(total_sale) as rev ,
rank() over(partition by extract( month from sale_date) order by sum(total_sale) desc) as ranked
from sales_data
group by extract( month from sale_date),category )t
where ranked =1;



-- 5. Find customers who are spending more money over time.
-- ans
select * from(
select mon,customer_id,rev,lag(rev) over( partition by customer_id order by mon)  as previous 
from(
select extract(month from sale_date) as mon ,customer_id,sum(total_sale) as rev  from sales_data
group by customer_id,extract(month from sale_date)
)t1
)t2
where rev<previous;




-- 6. What is the average money earned from one customer?
-- ans
select sum(total_sale) / count(distinct customer_id)   as avg_money from sales_data;


-- 7. For each age group, which category do people buy the most?
-- ans
select age_group, category, qty from (
    select age_group,category,sum(quantiy) as qty,rank() over (partition by age_group order by sum(quantiy) desc) as ranked from (
        select category,quantiy,
case when age between 20 and 30 then '20-30'
	   when age between 31 and 40 then '31-40'
	   when age between 41 and 50 then '41-50'
	 else '50+'
	end as age_group from sales_data) t1
    group by age_group, category) t2
where ranked = 1;



-- 8. What percentage of total revenue comes from each category?
-- ans
select category,sum(total_sale) as revenue,(sum(total_sale) * 100.0 / sum(sum(total_sale)) over ()) as percentage from sales_data
group by category;


-- 9. In each month, how many customers are new and how many are returning?
-- ans

select month,count(distinct case when month = first_month then customer_id end) as new_customers,
count(distinct case when month > first_month then customer_id end) as returning_customers
from ( select 
        customer_id,extract(month from sale_date) as month,min(extract(month from sale_date)) as first_month from sales_data
    group by customer_id, extract(month from sale_date)) t
group by month 
order by month;



-- 10. At what time of day do we get the highest sales?
-- ans

select extract(hour from sale_date) as hours,sum(total_sale) as revenue from sales_data
group by extract(hour from sale_date)
order by revenue desc
limit 1;





