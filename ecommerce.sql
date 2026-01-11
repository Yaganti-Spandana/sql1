CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATE DEFAULT CURRENT_DATE
);
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    category VARCHAR(50)
);
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
INSERT INTO customers (name, email) VALUES
('Alex Brown', 'alex@gmail.com'),
('Maria Smith', 'maria@gmail.com'),
('John Lee', 'john@gmail.com');
INSERT INTO products (product_name, price, category) VALUES
('Laptop', 800.00, 'Electronics'),
('Headphones', 150.00, 'Electronics'),
('Office Chair', 300.00, 'Furniture');
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-01', 950.00),
(2, '2024-01-01', 300.00),
(1, '2024-01-02', 150.00),
(3, '2024-01-03', 800.00),
(2, '2024-01-03', 450.00);
SELECT 
    SUM(total_amount) AS january_revenue
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31';
