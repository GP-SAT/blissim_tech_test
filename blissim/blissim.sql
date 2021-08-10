-- Guillaume Potier

-- Building a data architecture in which we can order from an Online store:
CREATE TABLE customers (
  customer_id INT NOT NULL,
  first_name VARCHAR(30),
  last_name VARCHAR(40),
  phone VARCHAR(20),
  email VARCHAR(50),
  street_address VARCHAR(255),
  city VARCHAR(30),
  country VARCHAR(30),
  zip_code VARCHAR(20),
  PRIMARY KEY (customer_id)
);

CREATE TABLE orders (
  order_id INT NOT NULL,
  customer_id INT NOT NULL,
  order_status VARCHAR(30),
  order_date DATE,
  shipped_date DATE,
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
  product_id INT NOT NULL,
  brand_id INT NOT NULL,
  category_id INT NOT NULL,
  product_name VARCHAR(255),
  model_year DATE,
  price DECIMAL(10, 2),
  PRIMARY KEY (product_id),
  FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Junction table between orders and products tables:
CREATE TABLE order_items (
  order_item INT NOT NULL,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT,
  list_price DECIMAL(10, 2),
  PRIMARY KEY (order_item),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE categories (
  category_id INT NOT NULL,
  category_name VARCHAR(30),
  PRIMARY KEY (category_id)
);

CREATE TABLE brands (
  brand_id INT NOT NULL,
  brand_name VARCHAR(30),
  creation_date DATE,
  PRIMARY KEY (brand_id)
);

-- Populating the db architecture with some test orders:
INSERT INTO customers VALUES(1, 'Michael', 'Scott', '+33789451269', 'Swelis1960@gustr.com', '3426 Austin Avenue', 'Savannah', 'United States', '31401');
INSERT INTO customers VALUES(2, 'Dwight', 'Schrute', '+33682226946', 'cwalid-ra@conisay.com', '1689 Gregory Lane', 'Louisville', 'United States', '40202');
INSERT INTO customers VALUES(3, 'Jim', 'Halpert', '+4163989784623', 'jcarmen.francia.q@rtfn.site', '130 rue de Vaugirard', 'Paris', 'France', '75015');
INSERT INTO customers VALUES(4, 'Pam', 'Beesly', '+4123579846689', 'xvedal@nbobd.com', '12 rue de la Huchette', 'Deauville', 'France', '14800');
INSERT INTO customers VALUES(5, 'Erin', 'Hannon', '+3361155442233', 'vmidoxp20e@24hinbox.com', 'Rhinstrasse 74', 'München', 'Germany', '80798');

INSERT INTO brands VALUES(1, 'pitchoune', '1995-11-11');
INSERT INTO brands VALUES(2, 'Chouquettes', '2009-12-01');
INSERT INTO brands VALUES(3, 'Bioderma', '1977-05-06');
INSERT INTO brands VALUES(4, 'Clarins', '1954-07-22');
INSERT INTO brands VALUES(5, 'Kiehls', '1851-11-11');

INSERT INTO categories VALUES(1, 'Maquillage');
INSERT INTO categories VALUES(2, 'Cheveux');
INSERT INTO categories VALUES(3, 'Corps & bain');
INSERT INTO categories VALUES(4, 'Parfum');
INSERT INTO categories VALUES(5, 'Soins visage');

INSERT INTO products VALUES (1, 2, 4, 'Sucs exotiques', '2015-01-01', 39.50);
INSERT INTO products VALUES (2, 3, 5, 'Gel moussant Créaline', '2012-01-01', 11);
INSERT INTO products VALUES (3, 4, 5, 'Eau à lèvres', '2007-01-01', 24.90);
INSERT INTO products VALUES (4, 5, 1, 'Huile démaquillante Midnight Recovery', '2019-01-01', 14.00);
INSERT INTO products VALUES (5, 1, 3, 'Lotion nutritive', '2005-01-01', 9.99);

INSERT INTO order_items VALUES(1, 1, 4, 2, 28.00);
INSERT INTO order_items VALUES(2, 3, 1, 1, 39.50);
INSERT INTO order_items VALUES(3, 4, 2, 5, 55.00);
INSERT INTO order_items VALUES(4, 2, 4, 1, 14.00);
INSERT INTO order_items VALUES(5, 2, 5, 3, 27.97);

INSERT INTO orders VALUES(1, 3, 'Pending', '2021-08-03', '2021-08-05');
INSERT INTO orders VALUES(2, 2, 'Delivered', '2021-05-21', '2021-05-24');
INSERT INTO orders VALUES(3, 4, 'Cancelled', '2021-07-15', '2021-07-17');
INSERT INTO orders VALUES(4, 5, 'Delivered', '2021-08-01', '2021-08-02');
INSERT INTO orders VALUES(5, 1, 'Shipping', '2021-08-06', '2021-08-06');

--1)Get firstname and email of customers who ordered PRODUCT_1:
SELECT first_name AS 'First name', email AS 'Email'
FROM customers AS c
JOIN orders  AS o
ON o.customer_id = c.customer_id
JOIN order_items AS oi
ON oi.order_id = o.order_id
JOIN products AS p
ON p.product_id = oi.product_id
WHERE p.product_id = 1;

--2) Get all the products name and quantity of products sold for the last 7 days:
SELECT product_name AS 'Product name'
FROM products AS p
JOIN order_items AS oi
ON oi.product_id = p.product_id
JOIN orders AS o
ON o.order_id = oi.order_id
WHERE order_date >= SUBDATE(CURRENT_DATE(), INTERVAL 7 DAY)
UNION
SELECT SUM(quantity)
FROM order_items AS oi
JOIN orders AS o
ON o.order_id = oi.order_id
WHERE order_date >= SUBDATE(CURRENT_DATE(), INTERVAL 7 DAY);