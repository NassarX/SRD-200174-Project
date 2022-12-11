# 6. Create view to recreate the information on the INVOICE, one view for the head and totals.
DROP VIEW IF EXISTS vw_invoice_details;
CREATE VIEW vw_invoice_details
    AS
    SELECT o.id as invoiceId, p.name AS ProductName, op.unit_price AS unitCost, op.quantity AS QTY, op.amount AS AMOUNT
    FROM orders o
        JOIN order_products op ON o.id = op.order_id
        JOIN store_products sp ON op.store_product_id = sp.id
        JOIN product p ON sp.product_id = p.id;

#7. Create view to recreate the information on the INVOICE, one view for the details.
DROP VIEW IF EXISTS vw_invoice_summary;
CREATE VIEW vw_invoice_summary
    AS
    SELECT o.id as invoiceId, o.code as invoiceNumber, o.time as dateOfIssue, t.sub_total as subTotal,
           t.discount as Discount, t.tax_rate as taxRate, t.tax as Tax, t.total as Total,
           concat(c.first_name, ' ', c.last_name) as clientName, c.address as clientAddress,
           s.store_name as storeName, l.city as storeCity, l.street_address as storeAddress, l.postal_code as storePostalCode,
           concat(e.first_name, ' ', e.last_name) as employeeName, e.email as employeeEmail, j.title as employeeJobtitle
    FROM orders o
        JOIN transaction t on o.id = t.order_id
        JOIN store s on o.store_id = s.id
        JOIN location l on s.location_id = l.id
        JOIN customer c on c.id = o.customer_id
        JOIN employee e on o.employee_id = e.id
        JOIN job j on e.job_id = j.id;
