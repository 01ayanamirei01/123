-- Load prepared CSV files into PostgreSQL (run after schema.sql)
-- Run from the project root where csv_import/ exists.

BEGIN;

\copy customers(id, full_name, email, phone) FROM 'csv_import/customers.csv' WITH (FORMAT csv, HEADER true);
\copy positions(id, name) FROM 'csv_import/positions.csv' WITH (FORMAT csv, HEADER true);
\copy employees(id, full_name, position_id) FROM 'csv_import/employees.csv' WITH (FORMAT csv, HEADER true);
\copy warehouses(id, name, address, capacity, shelf_count) FROM 'csv_import/warehouses.csv' WITH (FORMAT csv, HEADER true);

\copy categories(id, name) FROM 'csv_import/categories.csv' WITH (FORMAT csv, HEADER true);
\copy manufacturers(id, name) FROM 'csv_import/manufacturers.csv' WITH (FORMAT csv, HEADER true);
\copy colors(id, name) FROM 'csv_import/colors.csv' WITH (FORMAT csv, HEADER true);

\copy products(id, model_name, category_id, manufacturer_id) FROM 'csv_import/products.csv' WITH (FORMAT csv, HEADER true);
\copy product_variants(id, product_id, size, color_id, price) FROM 'csv_import/product_variants.csv' WITH (FORMAT csv, HEADER true);

\copy orders(id, order_number, order_date, customer_id, employee_id, warehouse_id) FROM 'csv_import/orders.csv' WITH (FORMAT csv, HEADER true);
\copy order_items(id, order_id, variant_id, quantity, unit_price) FROM 'csv_import/order_items.csv' WITH (FORMAT csv, HEADER true);

-- reset sequences
SELECT setval(pg_get_serial_sequence('customers','id'), (SELECT MAX(id) FROM customers));
SELECT setval(pg_get_serial_sequence('positions','id'), (SELECT MAX(id) FROM positions));
SELECT setval(pg_get_serial_sequence('employees','id'), (SELECT MAX(id) FROM employees));
SELECT setval(pg_get_serial_sequence('warehouses','id'), (SELECT MAX(id) FROM warehouses));
SELECT setval(pg_get_serial_sequence('categories','id'), (SELECT MAX(id) FROM categories));
SELECT setval(pg_get_serial_sequence('manufacturers','id'), (SELECT MAX(id) FROM manufacturers));
SELECT setval(pg_get_serial_sequence('colors','id'), (SELECT MAX(id) FROM colors));
SELECT setval(pg_get_serial_sequence('products','id'), (SELECT MAX(id) FROM products));
SELECT setval(pg_get_serial_sequence('product_variants','id'), (SELECT MAX(id) FROM product_variants));
SELECT setval(pg_get_serial_sequence('orders','id'), (SELECT MAX(id) FROM orders));
SELECT setval(pg_get_serial_sequence('order_items','id'), (SELECT MAX(id) FROM order_items));

COMMIT;