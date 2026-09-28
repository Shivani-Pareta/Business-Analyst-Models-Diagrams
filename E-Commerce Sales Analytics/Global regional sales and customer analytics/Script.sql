

--create view ecommerce.customer_region_order_summary AS
--	select 
--		c.region,
--		c.customer_country,
--		COUNT(distinct c.customer_id ) as dictinct_customers
--		ROUND(cast(SUM(s.net_sales) as DECIMAL,2)) as total_sales
--	from ecommerce.customer_master c
--	join
--		ecommerce.sales_customer_analytics s
--			on
--			s.customer_id = c.customer_id
--	group by 
--		c.customer_country,
--		c.region,
--	order by 
--		total_sales;


create view ecommerce.ecommerce_view AS
--Creating a view is better inorder to avoid data loss in the original dataset
	SELECT 
	    c.region, 
	    c.customer_country, 
	    COUNT(DISTINCT c.customer_id) AS distinct_customer_count,
	    ROUND(cast (SUM(s.net_sales) as DECIMAL),2) AS total_net_sales
--selcting region and customer cu=ountry as our first columns so that we can group based on them 
--having the count distinct command helps us avoid the duplicates in the data
--the sum function is used to sum the net sales and round function is used to round the final calculation to two decimal places
	FROM ecommerce.customer_master c
	JOIN ecommerce.sales_customer_analytics s
	    ON s.customer_id = c.customer_id
--the join command helps us merge the two tables sales_customer_analytics and customer_master based on one common column in each
--in this case the common column is customer id 
	    GROUP BY 
	    c.region, 
	    c.customer_country
--group by region and cutomer country so that we can get the region wise country output 
--in the sense say usa so we will get north usa, south usa,east usa,west usa
	ORDER BY 
	    total_net_sales DESC;
--order by net sales so that with the very first look we know which region of which country is performing the best or the least.