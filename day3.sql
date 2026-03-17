
-- 1. Calculate total revenue generated from all sales.
-- ans
select sum(total_sale) as total_rev from sales_data;

-- 2. Find the average total_sale value.
-- ans
select round(avg(total_sale),2) as avg_value from sales_data;

-- 3. Count the total number of unique transactions as per category
-- ans
select count(distinct transactions_id) as unq_id, category from sales_data
group by category;

-- 4. Find the highest sale value.
-- ans

select total_sale from sales_data
order by total_sale desc
limit 1;

-- 5. Calculate total sales for each product category.
-- ans

select sum(total_sale),category from sales_data
group by category;

-- 6. Find the total number of sales per gender.
-- ans
select gender,count(total_sale) from sales_data
group by gender;

-- 7. Count how many transactions occurred in each category for gender "male"
-- ans
select count(transactions_id),category,gender from sales_data
group by category,gender
having gender="male";



-- 8. Find the minimum price_per_unit.
-- ans
select min(price_per_unit) as min_pp_unit from sales_data;


-- 9. Calculate the average price_per_unit per category.
-- ans

select round(avg(price_per_unit),2) as avg_pp_unit,category  from sales_data
group by category;


-- 10. Find total sales per day.
-- ans
select extract(day from sale_date) as day_sale, sum(total_sale)  as total_sales from sales_data
group by day_sale
order by day_sale asc;


