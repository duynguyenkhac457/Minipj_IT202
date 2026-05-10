create database sales_management;

use sales_management;

create table customer (
    customer_id int primary key auto_increment,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(15) unique,
    address varchar(255),
    created_at datetime default current_timestamp
);

create table category (
    category_id int primary key auto_increment,
    category_name varchar(100) not null unique,
    description text
);

create table product (
    product_id int primary key auto_increment,
    product_name varchar(150) not null,
    price decimal(10,2) not null,
    stock int not null default 0,
    category_id int not null,

    foreign key (category_id)
    references category(category_id)
);

create table orders (
    order_id int primary key auto_increment,
    customer_id int not null,
    order_date datetime default current_timestamp,
    status varchar(50) not null,

    foreign key (customer_id)
    references customer(customer_id)
);

create table order_detail (
    order_id int not null,
    product_id int not null,
    quantity int not null,
    unit_price decimal(10,2) not null,

    primary key (order_id, product_id),

    foreign key (order_id)
    references orders(order_id),

    foreign key (product_id)
    references product(product_id)
);

INSERT INTO category (category_name) VALUES 
('Phone'), 
('Laptop'), 
('Accessory'), 
('Mouse'), 
('Keyboard');

INSERT INTO product (product_name, price, category_id) VALUES 
('Redmi 12', 3500000, 1),
('Poco X7 Pro', 8000000, 1),
('Lenovo LOQ 2025', 22000000, 2),
('Logitech G102 Mouse', 400000, 4),
('Akko Mechanical Keyboard', 1200000, 5);

INSERT INTO customer (full_name, email, phone, address) VALUES 
('Dinh Quang Hao', 'hao@gmail.com', '0901234567', 'Ho Chi Minh City'),
('Nguyen Khac Duy', 'duy@gmail.com', '0912345678', 'Thu Duc, Ho Chi Minh City'),
('Le Thanh Hai', 'hai@gmail.com', '0923456789', 'District 1, Ho Chi Minh City'),
('Nguyen Nhat Quoc Hung', 'hung@gmail.com', '0934567890', 'District 3, Ho Chi Minh City'),
('Bui Minh Hieu', 'hieu@gmail.com', '0945678901', 'District 5, Ho Chi Minh City');

INSERT INTO orders (order_date, customer_id, status) VALUES 
('2026-05-01', 1, 'Pending'),
('2026-05-02', 2, 'Completed'),
('2026-05-03', 3, 'Shipping'),
('2026-05-04', 4, 'Pending'),
('2026-05-05', 5, 'Cancelled');

INSERT INTO order_detail (order_id, product_id, quantity, unit_price) VALUES 
(1, 3, 1, 22000000), 
(2, 1, 1, 3500000),  
(3, 4, 2, 400000),   
(4, 2, 1, 8000000),  
(5, 5, 1, 1200000);

UPDATE product
SET price = 5000000
WHERE product_id = 1;

UPDATE customer
SET email = 'lethanhhai@gmail.com'
WHERE customer_id = 3;

DELETE FROM order_detail
WHERE order_id = 5;INSERT INTO category (category_name) VALUES  ('Phone'),  ('Laptop'),  ('Accessory'),  ('Mouse'),  ('Keyboard')