-- 1.Find all transactions where total_sale > 1000.
-- ans
select transactions_id,total_sale from sales_data
where total_sale>1000;

-- 2. Retrieve all sales made in the 'Clothing' category.
-- ans
select total_sale,category from sales_data
where category='clothing';

-- 3. Display the top 10 highest sales transactions.
-- ans
select transactions_id,total_sale from sales_data
order by total_sale desc
limit 10;

-- 4. Find transactions where quantity purchased is greater than 3.
-- ans
select transactions_id,quantiy from sales_data
where quantiy >3;

-- 5. Retrieve sales made by female customers.
-- ans
select total_sale,category,gender from sales_data
where gender='female';

-- 6. Find transactions that occurred in june 2023 per category.
-- ans 
select transactions_id, sale_date,category from sales_data
where sale_date between '2023-06-01' and '2023-06-30'
order by sale_date asc;


-- 7. Display category where price_per_unit is between 200 and 500.
-- ans 
select category,price_per_unit from sales_data 
where price_per_unit between 200 and 500 ;

-- 8. Retrieve the 5 most recent transactions.
-- ans
select transactions_id,category,age,gender,sale_date from sales_data
order by sale_date  desc
limit 5;

-- 9. Find customers whose age is greater than 50.
-- ans
select * from sales_data
where age>50;
-- 10. Display all transactions sorted by highest total_sale.
-- ans
select * from sales_data
order by total_sale desc;