-- Views
-- View to display book details along with author names
CREATE VIEW online_bookstore_dataset.book_details AS
SELECT b.book_id, b.title, b.isbn13, b.num_pages, b.publication_date, b.price,
       STRING_AGG(a.author_name, ', ') AS authors
FROM online_bookstore_dataset.book_data b
JOIN online_bookstore_dataset.book_author_data ba ON b.book_id = ba.book_id
JOIN online_bookstore_dataset.author_data a ON ba.author_id = a.author_id
GROUP BY b.book_id, b.title, b.isbn13, b.num_pages, b.publication_date, b.price;

-- View to display customer orders with shipping details
CREATE VIEW online_bookstore_dataset.customer_order_details AS
SELECT co.customer_order_id, co.order_date, co.total_price,
       c.first_name, c.last_name, c.email, c.phone,
       s.method_name AS shipping_method, s.cost AS shipping_cost,
       a.street_number, a.street_name, a.apartment_number, a.city,
       a.zip_code, ads.state_name
FROM online_bookstore_dataset.customer_order_data co
JOIN online_bookstore_dataset.customer_data c ON co.customer_id = c.customer_id
JOIN online_bookstore_dataset.shipping_method_data s ON co.shipping_method_id = s.shipping_method_id
JOIN online_bookstore_dataset.address_data a ON co.destination_address_id = a.address_id
JOIN online_bookstore_dataset.address_state_data ads ON a.address_state_id = ads.address_state_id;

-- View to display total sales by book
CREATE VIEW online_bookstore_dataset.total_sales_by_book AS
SELECT b.book_id, b.title, COUNT(oi.order_item_id) AS total_sales
FROM online_bookstore_dataset.book_data b
LEFT JOIN online_bookstore_dataset.order_item_data oi ON b.book_id = oi.book_id
GROUP BY b.book_id, b.title;

-- View to display customers with their order counts
CREATE VIEW online_bookstore_dataset.customer_order_counts AS
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
       COUNT(co.customer_order_id) AS order_count
FROM online_bookstore_dataset.customer_data c
LEFT JOIN online_bookstore_dataset.customer_order_data co ON c.customer_id = co.customer_id
GROUP BY c.customer_id, customer_name;

-- View to display order item returns with associated details
CREATE VIEW online_bookstore_dataset.order_item_return_details AS
SELECT oir.order_item_return_id, oi.order_item_id, oi.book_id, 
       oi.quantity AS original_quantity, oi.price AS original_price,
       oir.item_quantity AS returned_quantity, oir.item_return_request_date, 
       oir.item_return_delivered_date, oir.status
FROM online_bookstore_dataset.order_item_return_data oir
JOIN online_bookstore_dataset.order_item_data oi ON oir.order_item_id = oi.order_item_id;


-- Stored Procedures
-- Stored Procedure to retrieve order history for a specific customer
CREATE PROCEDURE online_bookstore_dataset.GetOrderHistory(customerId INT64)
BEGIN
    SELECT os.status_value AS order_status, oh.status_date
    FROM `online_bookstore_dataset.order_history_data` oh
    JOIN `online_bookstore_dataset.order_status_data` os ON oh.order_status_id = os.order_status_id
    JOIN `online_bookstore_dataset.customer_order_data` co ON oh.customer_order_id = co.customer_order_id
    WHERE co.customer_id = customerId;
END;

-- Stored Procedure to retrieve order items for a specific order
CREATE PROCEDURE online_bookstore_dataset.GetOrderItems(orderId INT64)
BEGIN
    SELECT oi.order_item_id, oi.book_id, b.title, oi.quantity, oi.price
    FROM online_bookstore_dataset.order_item_data oi
    JOIN online_bookstore_dataset.book_data b ON oi.book_id = b.book_id
    WHERE oi.customer_order_id = orderId;
END;

-- Stored Procedure to update order status
CREATE PROCEDURE online_bookstore_dataset.UpdateOrderStatus(orderId INT64, statusValue STRING)
BEGIN
    DECLARE statusId INT64;
    SET statusId = (
        SELECT order_status_id 
        FROM online_bookstore_dataset.order_status_data 
        WHERE status_value = statusValue
    );

    IF statusId IS NOT NULL THEN
        INSERT INTO online_bookstore_dataset.order_history_data (customer_order_id, order_status_id, status_date)
        VALUES (orderId, statusId, CURRENT_TIMESTAMP());
    END IF;
END;


--Functions
-- Function to calculate total price for an order item
CREATE TEMP FUNCTION CalculateOrderItemTotalPrice(quantity INT64, price FLOAT64)
RETURNS FLOAT64
LANGUAGE js AS """
  return quantity * price;
""";

-- Function to calculate total order price
CREATE TEMP FUNCTION CalculateOrderTotalPrice(orderId INT64)
RETURNS FLOAT64
LANGUAGE js AS """
  var total = 0;
  var orders = [
    { quantity: 2, price: 10.5 },
    { quantity: 3, price: 8.75 },
    { quantity: 1, price: 15.25 }
    // Add more order items here or fetch from another source
  ];

  // Iterate over each order item and calculate total price
  for (var i = 0; i < orders.length; i++) {
    total += orders[i].quantity * orders[i].price;
  }

  return total;
""";

-- Function to get the average number of pages per book
CREATE TEMP FUNCTION AveragePagesPerBook()
RETURNS FLOAT64
LANGUAGE js AS """
  var totalPages = 0;
  var numBooks = 0;

  // Fetch data from book table
  var books = [
    { num_pages: 200 },
    { num_pages: 300 },
    { num_pages: 150 }
    // Add more book data here or fetch from another source
  ];

  // Iterate over each book and calculate total pages
  for (var i = 0; i < books.length; i++) {
    totalPages += books[i].num_pages;
    numBooks++;
  }

  // Calculate the average
  var avgPages = totalPages / numBooks;
  return avgPages;
""";

-- Example usage of the functions
SELECT 
  CalculateOrderItemTotalPrice(3, 10.99) AS total_order_item_price,
  CalculateOrderTotalPrice(123) AS total_order_price,
  AveragePagesPerBook() AS avg_pages_per_book;




-- Data Transformation:
-- Clean the Data:

-- I will clean the customer table by removing any records with missing or invalid email addresses.

DELETE FROM customer WHERE email IS NULL OR email = '';

-- Enrich the Data:

-- I will enrich the book table by adding a column publication_year which extracts the year from the publication_date column.

ALTER TABLE online_bookstore_dataset.book_data ADD COLUMN publication_year YEAR;
UPDATE online_bookstore_dataset.book_data SET publication_year = YEAR(publication_date);

-- Filter the Data:

-- I will filter the order_item table to include only those items where the price is greater than $0.

DELETE FROM order_item WHERE price <= 0;

-- Aggregating Data:

-- I will calculate the total revenue generated by each book and store it in a new table book_revenue.

CREATE TABLE online_bookstore_dataset.book_revenue AS
SELECT
    b.book_id,
    b.title,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM
    `online_bookstore_dataset.book_data` b
INNER JOIN
    `online_bookstore_dataset.order_item_data` oi ON b.book_id = oi.book_id
GROUP BY
    b.book_id, b.title;
	
-- Query Optimization:
-- Indexing:

-- I will create indexes on frequently used columns to speed up query performance. For example, I will create an index on the customer_id column in the customer_order table.

CREATE INDEX idx_customer_id ON customer_order(customer_id);

-- Partitioning:

-- I will partition the customer_order table by order_date to improve query performance for date-based queries.

-- OPTION 1
CREATE TABLE online_bookstore_dataset.customer_order_partitioned (
    customer_order_id INT AUTO_INCREMENT,
    order_date DATETIME,
    customer_id INT,
    shipping_method_id INT,
    destination_address_id INT,
    total_price DECIMAL(5, 2),
    CONSTRAINT customer_order_partitioned PRIMARY KEY (customer_order_id, order_date),
    CONSTRAINT order_customer_partitioned FOREIGN KEY (customer_id) REFERENCES customer_data (customer_id),
    CONSTRAINT order_shipping_method_partitioned FOREIGN KEY (shipping_method_id) REFERENCES shipping_method_data (shipping_method_id),
    CONSTRAINT order_address_partitioned FOREIGN KEY (destination_address_id) REFERENCES address_data (address_id)
)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2019 VALUES LESS THAN (2020),
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN MAXVALUE
);

-- OR OPTION 2
CREATE TABLE online_bookstore_dataset.customer_order_partitioned (
    customer_order_id INT64,
    order_date TIMESTAMP,
    customer_id INT64,
    shipping_method_id INT64,
    destination_address_id INT64,
    total_price NUMERIC(5, 2)
)
PARTITION BY DATE(order_date)
OPTIONS(
    partition_expiration_days = 30 -- Set partition expiration days to a value less than 60 days
)
AS
SELECT 
    customer_order_id, 
    order_date, 
    customer_id, 
    shipping_method_id, 
    destination_address_id, 
    CAST(total_price AS NUMERIC) / 100 AS total_price -- Assuming total_price is in cents, dividing by 100 to convert to dollars
FROM `online-bookstore-jose-ambrosio.online_bookstore_dataset.customer_order_data`;

-- Clustering:

-- I will cluster the book table by the publisher_id column to physically group related rows together, which can improve query performance.

CREATE CLUSTERING KEY CLUSTER_BY_publisher_id ON online_bookstore_dataset.book_data;

-- Optimizing Joins and Aggregations:

-- I will rewrite the query to find the total revenue generated by each book using the aggregated table book_revenue.

SELECT
    b.title,
    br.total_revenue
FROM
    `online_bookstore_dataset.book_data` b
INNER JOIN
    `online_bookstore_dataset.book_revenue` br ON b.book_id = br.book_id;
	
