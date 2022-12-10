# 1. List all the customer’s names, dates, and products bought by these customers in a range of two dates.
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

# 2. List the best three stores (you are free to define the criteria for what means “best”)
SELECT s.store_name as StoreName, count(*) AS TotalOrders, SUM(amount) AS TotalSales
FROM orders
    JOIN store s ON s.id = orders.store_id
GROUP BY store_id ORDER BY TotalSales DESC , TotalOrders DESC LIMIT 3;

# 2. List the best three products (you are free to define the criteria for what means “best”)
# Most selling product across all stores
SELECT p.name as ProductName, SUM(op.quantity) TotalSoldQuantity
FROM order_products op
    JOIN store_products sp ON op.store_product_id = sp.id
    JOIN product p ON sp.product_id = p.id
GROUP BY p.id
ORDER BY TotalSoldQuantity desc LIMIT 3;


# 3. Get the average amount of sales for a period that involves 2 or more years,
CALL GET_AvgSales(5, 2021, 2022);

# 4. Get the total sales/bookings/rents/deliveries by geographical location (city/country).
SELECT c.name as CountryName, l.city as cityName, s.store_name as StoreName, SUM(amount) as TotalSales
FROM orders
    JOIN store s on orders.store_id = s.id
    JOIN location l on s.location_id = l.id
    JOIN country c on c.id = l.country_id
GROUP BY c.id, l.city, s.id;

# List all the locations where products/services were sold, and the product has customer’s ratings.
SELECT l.city as City, s.store_name as StoreName, p.name as productName, sp.rate as avgRate
FROM orders
    JOIN order_products op on orders.id = op.order_id
    JOIN store_products sp on sp.id = op.store_product_id
    JOIN store s on orders.store_id = s.id
    JOIN location l on s.location_id = l.id
    JOIN product p on p.id = sp.product_id
GROUP BY l.city, p.id, s.id, avgRate
ORDER BY avgRate desc ;