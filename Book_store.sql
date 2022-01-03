CREATE DATABASE book_store;

USE book_store;

CREATE TABLE author (
    author_id INT,
    author_name VARCHAR(400),
    PRIMARY KEY (author_id)
);

CREATE TABLE publisher (
    publisher_id INT,
    publisher_name VARCHAR(400),
    PRIMARY KEY (publisher_id)
);

CREATE TABLE book_language (
    language_id INT,
    language_code VARCHAR(8),
    language_name VARCHAR(50),
    PRIMARY KEY (language_id)
);

CREATE TABLE book (
    book_id INT,
    title VARCHAR(400),
    isbn13 VARCHAR(13),
    language_id INT,
    num_pages INT,
    publication_date DATE,
    publisher_id INT,
    book_price INT,
    PRIMARY KEY (book_id),
    FOREIGN KEY (language_id) REFERENCES book_language (language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book (book_id),
    FOREIGN KEY (author_id) REFERENCES author (author_id)
);



CREATE TABLE address (
    address_id INT,
    customer_id INT,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
    city VARCHAR(100),
    country VARCHAR (100),
    PRIMARY KEY (address_id),
	FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

CREATE TABLE customer (
    customer_id INT,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(350),
    address_id INT,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (address_id) REFERENCES address (address_id)
);
 
 
        
CREATE TABLE shipping_method (
    method_id INT,
    method_name VARCHAR(100),
    cost DECIMAL(6, 2),
    PRIMARY KEY (method_id)
);



CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT,
    order_date DATETIME,
    customer_id INT,
    shipping_method_id INT,
    dest_address_id INT,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method (method_id),
    FOREIGN KEY (dest_address_id) REFERENCES address (address_id)
);

CREATE TABLE order_status (
    status_id INT,
    status_value VARCHAR(20),
    PRIMARY KEY (status_id)
);



CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT,
    order_id INT,
    status_id INT,
    status_date DATETIME,
    PRIMARY KEY (history_id),
    FOREIGN KEY (order_id) REFERENCES cust_order (order_id),
    FOREIGN KEY (status_id) REFERENCES order_status (status_id)
);
