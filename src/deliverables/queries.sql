# 1. List all the customer’s names, dates, and products bought by these customers in a range of two dates.

# "query_cost": "228.84"
# actual time=0.472..3.027
# query analyze :
# -> Nested loop inner join  (cost=228.84 rows=31) (actual time=0.472..3.027 rows=181 loops=1)
#     -> Nested loop inner join  (cost=217.99 rows=31) (actual time=0.467..2.754 rows=181 loops=1)
#         -> Nested loop inner join  (cost=207.14 rows=31) (actual time=0.462..2.514 rows=181 loops=1)
#             -> Nested loop inner join  (cost=109.44 rows=279) (actual time=0.441..1.861 rows=264 loops=1)
#                 -> Table scan on product  (cost=11.75 rows=115) (actual time=0.050..0.084 rows=115 loops=1)
#                 -> Index lookup on order_product using fk_order_products_store_products_id (store_product_id=product.id)  (cost=0.61 rows=2) (actual time=0.011..0.012 rows=2 loops=115)
#             -> Filter: (orders.`time` between '2021-01-01' and <cache>(now()))  (cost=0.25 rows=0.1) (actual time=0.002..0.002 rows=1 loops=264)
#                 -> Single-row index lookup on orders using PRIMARY (id=order_product.order_id)  (cost=0.25 rows=1) (actual time=0.002..0.002 rows=1 loops=264)
#         -> Single-row index lookup on store using PRIMARY (id=orders.store_id)  (cost=0.25 rows=1) (actual time=0.001..0.001 rows=1 loops=181)
#     -> Single-row index lookup on customer using PRIMARY (id=orders.customer_id)  (cost=0.25 rows=1) (actual time=0.001..0.001 rows=1 loops=181)
SELECT
    CONCAT(customer.first_name, ' ', customer.last_name) as FullName,
    orders.time as OrderTime,
    store.store_name as StoreName,
    product.name as ProductName,
    order_product.quantity as ProductQuantity,
    order_product.unit_price as ProductPrice
FROM `customer`
    join orders on orders.customer_id = customer.id
    join store on store.id = orders.store_id
    join order_products order_product on  order_product.order_id = orders.id
    join product on product.id = order_product.store_product_id
WHERE orders.time BETWEEN '2021-01-01' AND NOW();

# 2.1. List the best three stores (Best Sales stores)

# "query_cost": "297.80"
# actual time=5.351..5.352
# query analyze :
# -> Limit: 3 row(s)  (actual time=5.351..5.352 rows=3 loops=1)
#     -> Sort: TotalSales DESC, TotalOrders DESC, limit input to 3 row(s) per chunk  (actual time=5.350..5.351 rows=3 loops=1)
#         -> Table scan on <temporary>  (actual time=5.248..5.259 rows=13 loops=1)
#             -> Aggregate using temporary table  (actual time=5.246..5.246 rows=13 loops=1)
#                 -> Nested loop inner join  (cost=297.80 rows=1500) (actual time=0.294..3.734 rows=1500 loops=1)
#                     -> Table scan on s  (cost=1.55 rows=13) (actual time=0.036..0.043 rows=13 loops=1)
#                     -> Index lookup on orders using fk_order_store_id (store_id=s.id)  (cost=12.14 rows=115) (actual time=0.211..0.274 rows=115 loops=13)
SELECT s.store_name as StoreName, count(*) AS TotalOrders, SUM(amount) AS TotalSales
FROM orders
    JOIN store s ON s.id = orders.store_id
GROUP BY store_id ORDER BY TotalSales DESC , TotalOrders DESC LIMIT 3;

# 2.2. List the best three products (Most selling product across all stores).

# "query_cost": "1370.11"
# actual time=11.610..11.611
# query analyze :
# -> Limit: 3 row(s)  (actual time=11.610..11.611 rows=3 loops=1)
#     -> Sort: TotalSoldQuantity DESC, limit input to 3 row(s) per chunk  (actual time=11.610..11.610 rows=3 loops=1)
#         -> Stream results  (cost=1709.91 rows=3398) (actual time=0.258..11.541 rows=115 loops=1)
#             -> Group aggregate: sum(op.quantity)  (cost=1709.91 rows=3398) (actual time=0.253..11.470 rows=115 loops=1)
#                 -> Nested loop inner join  (cost=1370.11 rows=3398) (actual time=0.087..10.908 rows=3398 loops=1)
#                     -> Nested loop inner join  (cost=180.81 rows=1400) (actual time=0.069..1.347 rows=1400 loops=1)
#                         -> Index scan on p using PRIMARY  (cost=11.75 rows=115) (actual time=0.048..0.096 rows=115 loops=1)
#                         -> Covering index lookup on sp using fk_store_products_product_id (product_id=p.id)  (cost=0.26 rows=12) (actual time=0.006..0.009 rows=12 loops=115)
#                     -> Index lookup on op using fk_order_products_store_products_id (store_product_id=sp.id)  (cost=0.61 rows=2) (actual time=0.005..0.006 rows=2 loops=1400)
SELECT p.name as ProductName, SUM(op.quantity) TotalSoldQuantity
FROM order_products op
    JOIN store_products sp ON op.store_product_id = sp.id
    JOIN product p ON sp.product_id = p.id
GROUP BY p.id
ORDER BY TotalSoldQuantity desc LIMIT 3;


# 3. Get the average amount of sales for a period that involves 2 or more years,
CALL GET_AvgSales(5, 2021, 2022);

# 4. Get the total sales/bookings/rents/deliveries by geographical location (city/country).

# "query_cost": "306.90"
# actual time=9.744..9.748
# query analyze :
# -> Table scan on <temporary>  (actual time=9.744..9.748 rows=13 loops=1)
#     -> Aggregate using temporary table  (actual time=9.742..9.742 rows=13 loops=1)
#         -> Nested loop inner join  (cost=306.90 rows=1500) (actual time=0.795..6.234 rows=1500 loops=1)
#             -> Nested loop inner join  (cost=10.65 rows=13) (actual time=0.163..0.235 rows=13 loops=1)
#                 -> Nested loop inner join  (cost=6.10 rows=13) (actual time=0.145..0.207 rows=13 loops=1)
#                     -> Filter: (s.location_id is not null)  (cost=1.55 rows=13) (actual time=0.097..0.106 rows=13 loops=1)
#                         -> Table scan on s  (cost=1.55 rows=13) (actual time=0.095..0.102 rows=13 loops=1)
#                     -> Single-row index lookup on l using PRIMARY (id=s.location_id)  (cost=0.26 rows=1) (actual time=0.007..0.007 rows=1 loops=13)
#                 -> Single-row index lookup on c using PRIMARY (id=l.country_id)  (cost=0.26 rows=1) (actual time=0.002..0.002 rows=1 loops=13)
#             -> Index lookup on orders using fk_order_store_id (store_id=s.id)  (cost=12.14 rows=115) (actual time=0.358..0.445 rows=115 loops=13)

SELECT c.name as CountryName, l.city as cityName, s.store_name as StoreName, SUM(amount) as TotalSales
FROM orders
    JOIN store s on orders.store_id = s.id
    JOIN location l on s.location_id = l.id
    JOIN country c on c.id = l.country_id
GROUP BY c.id, l.city, s.id;

# 5. List all the locations where products/services were sold, and the product has customer’s ratings.

# "query_cost": "3300.14"
# actual time=21.449..21.672
# query analyze :
# -> Sort: sp.rate DESC  (actual time=21.449..21.672 rows=2732 loops=1)
#     -> Table scan on <temporary>  (cost=3645.71..3691.39 rows=3456) (actual time=20.620..20.928 rows=2732 loops=1)
#         -> Temporary table with deduplication  (cost=3645.70..3645.70 rows=3456) (actual time=20.619..20.619 rows=2732 loops=1)
#             -> Nested loop inner join  (cost=3300.14 rows=3456) (actual time=0.201..17.388 rows=3398 loops=1)
#                 -> Nested loop inner join  (cost=2090.68 rows=3456) (actual time=0.192..13.036 rows=3398 loops=1)
#                     -> Nested loop inner join  (cost=881.23 rows=3456) (actual time=0.178..7.464 rows=3398 loops=1)
#                         -> Nested loop inner join  (cost=159.71 rows=1500) (actual time=0.162..0.888 rows=1500 loops=1)
#                             -> Nested loop inner join  (cost=6.10 rows=13) (actual time=0.124..0.165 rows=13 loops=1)
#                                 -> Filter: (s.location_id is not null)  (cost=1.55 rows=13) (actual time=0.092..0.101 rows=13 loops=1)
#                                     -> Table scan on s  (cost=1.55 rows=13) (actual time=0.085..0.090 rows=13 loops=1)
#                                 -> Single-row index lookup on l using PRIMARY (id=s.location_id)  (cost=0.26 rows=1) (actual time=0.004..0.005 rows=1 loops=13)
#                             -> Covering index lookup on orders using fk_order_store_id (store_id=s.id)  (cost=1.17 rows=115) (actual time=0.021..0.047 rows=115 loops=13)
#                         -> Covering index lookup on op using PRIMARY (order_id=orders.id)  (cost=0.25 rows=2) (actual time=0.003..0.004 rows=2 loops=1500)
#                     -> Single-row index lookup on sp using PRIMARY (id=op.store_product_id)  (cost=0.25 rows=1) (actual time=0.001..0.001 rows=1 loops=3398)
#                 -> Single-row index lookup on p using PRIMARY (id=sp.product_id)  (cost=0.25 rows=1) (actual time=0.001..0.001 rows=1 loops=3398)
SELECT l.city as City, s.store_name as StoreName, p.name as productName, sp.rate as avgRate
FROM orders
    JOIN order_products op on orders.id = op.order_id
    JOIN store_products sp on sp.id = op.store_product_id
    JOIN store s on orders.store_id = s.id
    JOIN location l on s.location_id = l.id
    JOIN product p on p.id = sp.product_id
GROUP BY l.city, p.id, s.id, avgRate
ORDER BY avgRate desc ;

# 6.1. Create view to recreate the information on the INVOICE, one view for the head and totals.

# "query_cost": "7.45"
# actual time=0.046..0.104
# query analyze :
# -> Nested loop inner join  (cost=7.45 rows=9) (actual time=0.046..0.104 rows=9 loops=1)
#     -> Nested loop inner join  (cost=4.30 rows=9) (actual time=0.034..0.070 rows=9 loops=1)
#         -> Index lookup on op using PRIMARY (order_id=452)  (cost=1.15 rows=9) (actual time=0.017..0.025 rows=9 loops=1)
#         -> Single-row index lookup on sp using PRIMARY (id=op.store_product_id)  (cost=0.26 rows=1) (actual time=0.004..0.004 rows=1 loops=9)
#     -> Single-row index lookup on p using PRIMARY (id=sp.product_id)  (cost=0.26 rows=1) (actual time=0.004..0.004 rows=1 loops=9)
EXPLAIN ANALYZE SELECT * FROM vw_invoice_details WHERE invoiceId = 452;

#6.2. Create view to recreate the information on the INVOICE, one view for the details.
# "query_cost": "0.35"
# actual time=0.046..0.104
# query analyze :
# -> Index lookup on t using fk_transaction_order_id (order_id=452)  (cost=0.35 rows=1) (actual time=0.179..0.183 rows=1 loops=1)
EXPLAIN ANALYZE SELECT * FROM vw_invoice_summary WHERE invoiceId = 452;