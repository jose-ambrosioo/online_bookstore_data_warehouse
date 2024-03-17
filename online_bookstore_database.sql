CREATE DATABASE online_bookstore;

USE online_bookstore;

CREATE TABLE author (
    author_id INT AUTO_INCREMENT,
    author_name VARCHAR(400),
    CONSTRAINT author PRIMARY KEY (author_id)
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT,
    publisher_name VARCHAR(400),
    CONSTRAINT publisher PRIMARY KEY (publisher_id)
);

CREATE TABLE book_language (
    book_language_id INT AUTO_INCREMENT,
    language_code VARCHAR(8),
    language_name VARCHAR(50),
    CONSTRAINT book_language PRIMARY KEY (book_language_id)
);

CREATE TABLE book (
    book_id INT AUTO_INCREMENT,
    title VARCHAR(400),
    isbn13 VARCHAR(13),
    book_language_id INT,
    num_pages INT,
    publication_date DATE,
    publisher_id INT,
	price DECIMAL(5, 2),
    CONSTRAINT book PRIMARY KEY (book_id),
    CONSTRAINT book_lang FOREIGN KEY (book_language_id) REFERENCES book_language (book_language_id),
    CONSTRAINT book_pub FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id)
);

CREATE TABLE book_author (
	book_author_id INT AUTO_INCREMENT,
    book_id INT,
    author_id INT,
    CONSTRAINT book_author PRIMARY KEY (book_author_id),
    CONSTRAINT ba_book FOREIGN KEY (book_id) REFERENCES book (book_id),
    CONSTRAINT ba_author FOREIGN KEY (author_id) REFERENCES author (author_id)
);

CREATE TABLE address_state (
    address_state_id INT AUTO_INCREMENT,
    state_name VARCHAR(200),
    CONSTRAINT address_state PRIMARY KEY (address_state_id)
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
	apartment_number VARCHAR(50),
    city VARCHAR(100),
    address_state_id INT,
	zip_code VARCHAR(9),
    CONSTRAINT address PRIMARY KEY (address_id),
	CONSTRAINT address_address_state FOREIGN KEY (address_state_id) REFERENCES address_state (address_state_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(254),
	phone VARCHAR(10),
	address_id INT,
    CONSTRAINT customer PRIMARY KEY (customer_id),
    CONSTRAINT customer_address FOREIGN KEY (address_id) REFERENCES address (address_id)
);

CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT,
    method_name VARCHAR(100),
    cost DECIMAL(6, 2),
    CONSTRAINT shipping_method PRIMARY KEY (shipping_method_id)
);

CREATE TABLE customer_order (
    customer_order_id INT AUTO_INCREMENT,
    order_date DATETIME,
    customer_id INT,
    shipping_method_id INT,
    destination_address_id INT,
	total_price DECIMAL(5, 2),
    CONSTRAINT customer_order PRIMARY KEY (customer_order_id),
    CONSTRAINT order_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT order_shipping_method FOREIGN KEY (shipping_method_id) REFERENCES shipping_method (shipping_method_id),
    CONSTRAINT order_address FOREIGN KEY (destination_address_id) REFERENCES address (address_id)
);

CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT,
    status_value VARCHAR(20),
    CONSTRAINT order_status PRIMARY KEY (order_status_id)
);

CREATE TABLE order_item (
    order_item_id INT AUTO_INCREMENT,
    customer_order_id INT,
    book_id INT,
	quantity INT,
    price DECIMAL(5, 2),
    CONSTRAINT order_item PRIMARY KEY (order_item_id),
    CONSTRAINT order_item_costumer FOREIGN KEY (customer_order_id) REFERENCES customer_order (customer_order_id),
    CONSTRAINT order_item_book FOREIGN KEY (book_id) REFERENCES book (book_id)
);

CREATE TABLE order_history (
    order_history_id INT AUTO_INCREMENT,
    customer_order_id INT,
    order_status_id INT,
    status_date DATETIME,
    CONSTRAINT order_history PRIMARY KEY (order_history_id),
    CONSTRAINT order_history_costumer FOREIGN KEY (customer_order_id) REFERENCES customer_order (customer_order_id),
    CONSTRAINT order_history_status FOREIGN KEY (order_status_id) REFERENCES order_status (order_status_id)
);

CREATE TABLE order_item_return (
    order_item_return_id INT AUTO_INCREMENT,
    order_item_id INT,
	item_quantity INT,
	item_return_request_date DATETIME,
	item_return_delivered_date DATETIME,
	status ENUM('yes', 'no') NOT NULL,
    CONSTRAINT order_item_return PRIMARY KEY (order_item_return_id),
    CONSTRAINT order_item_return_order_item FOREIGN KEY (order_item_id) REFERENCES order_item (order_item_id)
);


-- Inserts for table 'author'
INSERT INTO author (author_name) VALUES
('Jane Austen'),
('Charles Dickens'),
('Leo Tolstoy'),
('Mark Twain'),
('Fyodor Dostoevsky'),
('George Orwell'),
('J.K. Rowling'),
('Ernest Hemingway'),
('Agatha Christie'),
('Toni Morrison'),
('Stephen King'),
('Harper Lee'),
('J.R.R. Tolkien'),
('Gabriel Garcia Marquez'),
('Virginia Woolf'),
('Franz Kafka'),
('James Joyce'),
('Emily Bronte'),
('Albert Camus'),
('Hermann Hesse'),
('Edgar Allan Poe'),
('John Steinbeck'),
('William Faulkner'),
('George Eliot'),
('Charlotte Bronte'),
('Nathaniel Hawthorne'),
('Oscar Wilde'),
('Miguel de Cervantes'),
('Anton Chekhov'),
('D.H. Lawrence'),
('Victor Hugo'),
('Voltaire'),
('H.G. Wells'),
('Thomas Hardy'),
('Jack London'),
('Robert Louis Stevenson'),
('Arthur Conan Doyle'),
('Homer'),
('Hans Christian Andersen'),
('Jules Verne'),
('Lewis Carroll'),
('Mary Shelley'),
('Sir Arthur Conan Doyle'),
('O. Henry'),
('Rudyard Kipling'),
('Ralph Waldo Emerson'),
('H.P. Lovecraft'),
('Walt Whitman');

-- Inserts for table 'publisher'
INSERT INTO publisher (publisher_name) VALUES
('Penguin Books'),
('HarperCollins Publishers'),
('Random House'),
('Simon & Schuster'),
('Macmillan Publishers'),
('Hachette Livre'),
('Pearson Education'),
('Scholastic'),
('Bloomsbury Publishing'),
('Oxford University Press'),
('Cambridge University Press'),
('Wiley'),
('McGraw-Hill Education'),
('Houghton Mifflin Harcourt'),
('Harvard University Press'),
('Cengage Learning'),
('Elsevier'),
('Springer'),
('John Wiley & Sons'),
('Taylor & Francis'),
('Routledge'),
('SAGE Publications'),
('W.W. Norton & Company'),
('Thomson Reuters'),
('Palgrave Macmillan'),
('Brill'),
('Rowman & Littlefield'),
('Emerald Group Publishing'),
('Blackwell Publishing'),
('Wolters Kluwer'),
('Oxford University Press'),
('Cambridge University Press'),
('Pearson Education'),
('Scholastic'),
('Bloomsbury Publishing'),
('Oxford University Press'),
('Cambridge University Press'),
('Pearson Education'),
('Scholastic'),
('Bloomsbury Publishing'),
('Oxford University Press'),
('Cambridge University Press'),
('Pearson Education'),
('Scholastic'),
('Bloomsbury Publishing'),
('Oxford University Press'),
('Cambridge University Press');

-- Inserts for table 'book_language'
INSERT INTO book_language (language_code, language_name) VALUES
('en', 'English'),
('fr', 'French'),
('es', 'Spanish'),
('de', 'German'),
('it', 'Italian'),
('pt', 'Portuguese'),
('zh', 'Chinese'),
('ja', 'Japanese'),
('ko', 'Korean'),
('ru', 'Russian');

-- Inserts for table 'book'
INSERT INTO book (title, isbn13, book_language_id, num_pages, publication_date, publisher_id, price) VALUES
('Pride and Prejudice', '9780141439518', 1, 279, '2002-12-31', 1, 12.99),
('Oliver Twist', '9780141439747', 1, 608, '2002-04-29', 1, 15.99),
('War and Peace', '9780140447934', 3, 1440, '2005-09-27', 2, 29.99),
('The Adventures of Tom Sawyer', '9780141439648', 1, 272, '2002-04-29', 1, 10.99),
('Crime and Punishment', '9780140449136', 3, 576, '2003-03-25', 2, 19.99),
('1984', '9780141036144', 1, 328, '2008-02-07', 3, 14.99),
('Harry Potter and the Sorcerer''s Stone', '9780590353403', 1, 320, '1999-09-08', 6, 18.99),
('The Old Man and the Sea', '9780684801223', 1, 127, '1995-05-05', 4, 11.99),
('Murder on the Orient Express', '9780062693662', 1, 265, '2017-03-07', 2, 14.99),
('Beloved', '9781400033416', 1, 324, '2004-06-08', 7, 16.99),
('The Shining', '9780307743657', 1, 688, '2012-06-26', 5, 22.99),
('To Kill a Mockingbird', '9780061120084', 1, 336, '2006-05-23', 2, 17.99),
('The Hobbit', '9780345339683', 1, 366, '1999-09-08', 1, 19.99),
('One Hundred Years of Solitude', '9780060883287', 1, 417, '2006-02-21', 8, 16.99),
('Mrs. Dalloway', '9780156628709', 1, 194, '1990-10-23', 9, 13.99),
('The Metamorphosis', '9780553213690', 1, 224, '1986-01-01', 1, 12.99),
('Ulysses', '9780679722762', 1, 732, '1990-02-28', 10, 24.99),
('Wuthering Heights', '9780141439556', 1, 416, '2002-12-31', 1, 16.99),
('The Stranger', '9780679720201', 1, 123, '1989-05-08', 10, 11.99),
('Siddhartha', '9780142437186', 1, 160, '2002-12-31', 1, 10.99),
('The Tell-Tale Heart and Other Writings', '9780451530318', 1, 400, '2011-12-06', 11, 14.99),
('The Grapes of Wrath', '9780143039433', 1, 464, '2006-01-03', 12, 17.99),
('The Great Gatsby', '9780141182636', 1, 200, '2000-11-06', 1, 13.99),
('Middlemarch','9780141196893', 1, 904, '2003-12-04', 2, 27.99),
('Jane Eyre', '9780142437209', 1, 688, '2003-09-30', 13, 22.99),
('The Scarlet Letter', '9780142437261', 1, 238, '2003-09-30', 1, 14.99),
('The Picture of Dorian Gray', '9780141439570', 1, 304, '2003-09-30', 1, 15.99),
('Don Quixote', '9780142437230', 1, 1023, '2003-10-01', 14, 29.99),
('Selected Stories', '9780142437629', 1, 672, '2003-11-25', 15, 21.99),
('Women in Love', '9780141441542', 1, 576, '2007-02-27', 16, 19.99),
('Les Misérables', '9780140444308', 1, 1463, '2000-04-27', 17, 31.99),
('Candide', '9780140440041', 1, 144, '1988-12-01', 18, 11.99),
('The Time Machine', '9780141439976', 1, 118, '2005-09-27', 2, 11.99),
('Tess of the d''Urbervilles', '9780141439594', 1, 518, '2003-12-04', 2, 18.99),
('White Fang', '9780142437919', 1, 256, '2001-02-27', 19, 14.99),
('Treasure Island', '9780141321002', 1, 320, '2007-07-31', 1, 15.99),
('The Adventures of Sherlock Holmes', '9780140439077', 1, 576, '2001-02-27', 20, 22.99),
('The Iliad', '9780140445923', 1, 704, '2003-05-27', 21, 23.99),
('The Little Mermaid and Other Fairy Tales', '9780141191607', 1, 368, '2004-12-07', 1, 16.99),
('Around the World in Eighty Days', '9780140449068', 1, 256, '2004-06-29', 22, 14.99),
('Alice''s Adventures in Wonderland', '9780141439761', 1, 272, '2003-09-02', 23, 13.99),
('Frankenstein', '9780141439471', 1, 352, '2003-09-02', 1, 16.99),
('The Hound of the Baskervilles', '9780140437868', 1, 240, '2001-03-27', 24, 14.99),
('The Call of the Wild', '9780142437704', 1, 160, '2000-04-27', 1, 12.99),
('The Jungle Book', '9780141325291', 1, 240, '2008-08-28', 25, 14.99),
('Self-Reliance and Other Essays', '9780140390338', 1, 416, '1993-09-01', 1, 17.99),
('The Call of Cthulhu and Other Weird Stories', '9780141182346', 1, 420, '1999-11-01', 1, 18.99),
('Leaves of Grass', '9780140421997', 1, 528, '2000-09-01', 1, 21.99);

-- Inserts for table 'book_author'
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30),
(31, 31),
(32, 32),
(33, 33),
(34, 34),
(35, 35),
(36, 36),
(37, 37),
(38, 38),
(39, 39),
(40, 40),
(41, 41),
(42, 42),
(43, 43),
(44, 44),
(45, 45),
(46, 46),
(47, 47),
(48, 48);

-- Inserts for table 'address_state'
INSERT INTO address_state (state_name) VALUES
('Alabama'),
('Alaska'),
('Arizona'),
('Arkansas'),
('California'),
('Colorado'),
('Connecticut'),
('Delaware'),
('Florida'),
('Georgia'),
('Hawaii'),
('Idaho'),
('Illinois'),
('Indiana'),
('Iowa'),
('Kansas'),
('Kentucky'),
('Louisiana'),
('Maine'),
('Maryland'),
('Massachusetts'),
('Michigan'),
('Minnesota'),
('Mississippi'),
('Missouri'),
('Montana'),
('Nebraska'),
('Nevada'),
('New Hampshire'),
('New Jersey'),
('New Mexico'),
('New York'),
('North Carolina'),
('North Dakota'),
('Ohio'),
('Oklahoma'),
('Oregon'),
('Pennsylvania'),
('Rhode Island'),
('South Carolina'),
('South Dakota'),
('Tennessee'),
('Texas'),
('Utah'),
('Vermont'),
('Virginia'),
('Washington'),
('West Virginia'),
('Wisconsin'),
('Wyoming');

-- Inserts for table 'address'
INSERT INTO address (street_number, street_name, apartment_number, city, address_state_id, zip_code) VALUES
('123', 'Main St', NULL, 'Anytown', 1, '12345'),
('456', 'Broadway', NULL, 'Smallville', 2, '23456'),
('789', 'Elm St', 'Apt 101', 'Cityville', 3, '34567'),
('321', 'Oak St', 'Unit B', 'Villageville', 4, '45678'),
('654', 'Maple Ave', NULL, 'Townsville', 5, '56789'),
('987', 'Cedar Ln', NULL, 'Hamletville', 6, '67890'),
('741', 'Pine St', NULL, 'Metropolis', 7, '78901'),
('852', 'Spruce Rd', 'Apt 202', 'Ruralville', 8, '89012'),
('963', 'Forest Ave', NULL, 'Suburbia', 9, '90123'),
('147', 'River Rd', 'Unit C', 'Villageland', 10, '01234'),
('258', 'Lake St', NULL, 'Cityburgh', 11, '12340'),
('369', 'Mountain View', NULL, 'Hilltown', 12, '23456'),
('159', 'Valley Dr', NULL, 'Downtown', 13, '34567'),
('357', 'High St', 'Suite 303', 'Uptown', 14, '45678'),
('753', 'Low Rd', NULL, 'Countryside', 15, '56789'),
('951', 'Skyline Blvd', NULL, 'Lakeside', 16, '67890'),
('357', 'Hillcrest Dr', 'Apt 404', 'Seaside', 17, '78901'),
('753', 'Sunset Ave', NULL, 'Riverside', 18, '89012'),
('951', 'Ocean Blvd', NULL, 'Hometown', 19, '90123'),
('159', 'Beach Dr', 'Unit D', 'Hometown', 20, '01234'),
('357', 'Main St', NULL, 'Hometown', 21, '12340'),
('753', 'Broadway', NULL, 'Hometown', 22, '23456'),
('951', 'Elm St', 'Apt 505', 'Hometown', 23, '34567'),
('159', 'Oak St', 'Suite 606', 'Hometown', 24, '45678'),
('357', 'Maple Ave', NULL, 'Hometown', 25, '56789'),
('753', 'Cedar Ln', NULL, 'Hometown', 26, '67890'),
('951', 'Pine St', NULL, 'Hometown', 27, '78901'),
('159', 'Spruce Rd', 'Apt 707', 'Hometown', 28, '89012'),
('357', 'Forest Ave', NULL, 'Hometown', 29, '90123'),
('753', 'River Rd', NULL, 'Hometown', 30, '01234'),
('951', 'Lake St', 'Unit E', 'Hometown', 31, '12340'),
('159', 'Mountain View', NULL, 'Hometown', 32, '23456'),
('357', 'Valley Dr', 'Suite 808', 'Hometown', 33, '34567'),
('753', 'High St', NULL, 'Hometown', 34, '45678'),
('951', 'Low Rd', NULL, 'Hometown', 35, '56789'),
('159', 'Skyline Blvd', 'Apt 909', 'Hometown', 36, '67890'),
('357', 'Hillcrest Dr', NULL, 'Hometown', 37, '78901'),
('753', 'Sunset Ave', NULL, 'Hometown', 38, '89012'),
('951', 'Ocean Blvd', 'Unit F', 'Hometown', 39, '90123'),
('159', 'Beach Dr', NULL, 'Hometown', 40, '01234'),
('357', 'Main St', NULL, 'Hometown', 41, '12340'),
('753', 'Broadway', NULL, 'Hometown', 42, '23456'),
('951', 'Elm St', NULL, 'Hometown', 43, '34567'),
('159', 'Oak St', 'Apt 1010', 'Hometown', 44, '45678'),
('357', 'Maple Ave', NULL, 'Hometown', 45, '56789'),
('753', 'Cedar Ln', NULL, 'Hometown', 46, '67890'),
('951', 'Pine St', NULL, 'Hometown', 47, '78901'),
('159', 'Spruce Rd', 'Unit G', 'Hometown', 48, '89012'),
('357', 'Forest Ave', NULL, 'Hometown', 49, '90123'),
('753', 'River Rd', NULL, 'Hometown', 50, '01234');

-- Inserts for table 'customer'
INSERT INTO customer (first_name, last_name, email, phone, address_id) VALUES
('John', 'Doe', 'johndoe@example.com', '1234567890', 1),
('Jane', 'Smith', 'janesmith@example.com', '2345678901', 2),
('David', 'Johnson', 'davidjohnson@example.com', '3456789012', 3),
('Sarah', 'Williams', 'sarahwilliams@example.com', '4567890123', 4),
('Michael', 'Brown', 'michaelbrown@example.com', '5678901234', 5),
('Maria', 'Jones', 'mariajones@example.com', '6789012345', 6),
('James', 'Garcia', 'jamesgarcia@example.com', '7890123456', 7),
('Jennifer', 'Martinez', 'jennifermartinez@example.com', '8901234567', 8),
('Robert', 'Hernandez', 'roberthernandez@example.com', '9012345678', 9),
('William', 'Young', 'williamyoung@example.com', '0123456789', 10),
('Linda', 'King', 'lindaking@example.com', '1234567890', 11),
('Charles', 'Lee', 'charleslee@example.com', '2345678901', 12),
('Karen', 'Walker', 'karenwalker@example.com', '3456789012', 13),
('Lisa', 'Allen', 'lisaallen@example.com', '4567890123', 14),
('Edward', 'Scott', 'edwardscott@example.com', '5678901234', 15),
('Eric', 'Green', 'ericgreen@example.com', '6789012345', 16),
('Mary', 'Adams', 'maryadams@example.com', '7890123456', 17),
('Jennifer', 'Hill', 'jenniferhill@example.com', '8901234567', 18),
('John', 'Baker', 'johnbaker@example.com', '9012345678', 19),
('Dorothy', 'Ramirez', 'dorothyramirez@example.com', '0123456789', 20),
('Richard', 'Campbell', 'richardcampbell@example.com', '1234567890', 21),
('Daniel', 'Mitchell', 'danielmitchell@example.com', '2345678901', 22),
('Susan', 'Roberts', 'susanroberts@example.com', '3456789012', 23),
('Joseph', 'Carter', 'josephcarter@example.com', '4567890123', 24),
('Betty', 'Phillips', 'bettyphillips@example.com', '5678901234', 25),
('Margaret', 'Evans', 'margaretevans@example.com', '6789012345', 26),
('Sarah', 'Turner', 'sarahturner@example.com', '7890123456', 27),
('Kenneth', 'Ward', 'kennethward@example.com', '8901234567', 28),
('Steven', 'Morris', 'stevenmorris@example.com', '9012345678', 29),
('Dennis', 'Sullivan', 'dennissullivan@example.com', '0123456789', 30),
('Amy', 'Russell', 'amyrussell@example.com', '1234567890', 31),
('George', 'Ortiz', 'georgeortiz@example.com', '2345678901', 32),
('Sharon', 'Jenkins', 'sharonjenkins@example.com', '3456789012', 33),
('Patrick', 'Gutierrez', 'patrickgutierrez@example.com', '4567890123', 34),
('Debra', 'Perry', 'debraperry@example.com', '5678901234', 35),
('Henry', 'Butler', 'henrybutler@example.com', '6789012345', 36),
('Carol', 'Barnes', 'carolbarnes@example.com', '7890123456', 37),
('Jesse', 'Fisher', 'jessefisher@example.com', '8901234567', 38),
('Shirley', 'Hoffman', 'shirleyhoffman@example.com', '9012345678', 39),
('Janet', 'Long', 'janetlong@example.com', '0123456789', 40),
('Harry', 'Ward', 'harryward@example.com', '1234567890', 41),
('Douglas', 'Flores', 'douglasflores@example.com', '2345678901', 42),
('Anna', 'Jackson', 'annajackson@example.com', '3456789012', 43),
('Jose', 'Wood', 'josewood@example.com', '4567890123', 44),
('Timothy', 'Bennett', 'timothybennett@example.com', '5678901234', 45),
('Virginia', 'Barnes', 'virginiabarnes@example.com', '6789012345', 46),
('Larry', 'Watkins', 'larrywatkins@example.com', '7890123456', 47),
('Cheryl', 'Olson', 'cherylolson@example.com', '8901234567', 48),
('Mildred', 'Webb', 'mildredwebb@example.com', '9012345678', 49),
('Andrew', 'Spencer', 'andrewspencer@example.com', '0123456789', 50);

-- Inserts for table 'shipping_method'
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard Shipping', 5.99),
('Express Shipping', 12.99),
('Next-Day Shipping', 19.99);

-- Inserts for table 'customer_order'
INSERT INTO customer_order (order_date, customer_id, shipping_method_id, destination_address_id, total_price) VALUES
('2023-01-01 10:00:00', 1, 1, 1, 12.99),
('2023-01-02 11:00:00', 2, 2, 2, 15.99),
('2023-01-03 12:00:00', 3, 3, 3, 29.99),
('2023-01-04 13:00:00', 4, 1, 4, 10.99),
('2023-01-05 14:00:00', 5, 2, 5, 19.99),
('2023-01-06 15:00:00', 6, 3, 6, 14.99),
('2023-01-07 16:00:00', 7, 1, 7, 18.99),
('2023-01-08 17:00:00', 8, 2, 8, 22.99),
('2023-01-09 18:00:00', 9, 3, 9, 17.99),
('2023-01-10 19:00:00', 10, 1, 10, 19.99),
('2023-01-11 20:00:00', 11, 2, 11, 16.99),
('2023-01-12 21:00:00', 12, 3, 12, 24.99),
('2023-01-13 22:00:00', 13, 1, 13, 16.99),
('2023-01-14 23:00:00', 14, 2, 14, 13.99),
('2023-01-15 10:00:00', 15, 3, 15, 12.99),
('2023-01-16 11:00:00', 16, 1, 16, 11.99),
('2023-01-17 12:00:00', 17, 2, 17, 14.99),
('2023-01-18 13:00:00', 18, 3, 18, 17.99),
('2023-01-19 14:00:00', 19, 1, 19, 16.99),
('2023-01-20 15:00:00', 20, 2, 20, 31.99),
('2023-01-21 16:00:00', 21, 3, 21, 11.99),
('2023-01-22 17:00:00', 22, 1, 22, 12.99),
('2023-01-23 18:00:00', 23, 2, 23, 14.99),
('2023-01-24 19:00:00', 24, 3, 24, 15.99),
('2023-01-25 20:00:00', 25, 1, 25, 29.99),
('2023-01-26 21:00:00', 26, 2, 26, 21.99),
('2023-01-27 22:00:00', 27, 3, 27,19.99),
('2023-01-28 23:00:00', 28, 1, 28, 23.99),
('2023-01-29 10:00:00', 29, 2, 29, 16.99),
('2023-01-30 11:00:00', 30, 3, 30, 18.99),
('2023-01-31 12:00:00', 31, 1, 31, 21.99),
('2023-02-01 13:00:00', 32, 2, 32, 19.99),
('2023-02-02 14:00:00', 33, 3, 33, 14.99),
('2023-02-03 15:00:00', 34, 1, 34, 15.99),
('2023-02-04 16:00:00', 35, 2, 35, 14.99),
('2023-02-05 17:00:00', 36, 3, 36, 11.99),
('2023-02-06 18:00:00', 37, 1, 37, 12.99),
('2023-02-07 19:00:00', 38, 2, 38, 14.99),
('2023-02-08 20:00:00', 39, 3, 39, 15.99),
('2023-02-09 21:00:00', 40, 1, 40, 23.99),
('2023-02-10 22:00:00', 41, 2, 41, 16.99),
('2023-02-11 23:00:00', 42, 3, 42, 18.99),
('2023-02-12 10:00:00', 43, 1, 43, 21.99),
('2023-02-13 11:00:00', 44, 2, 44, 19.99),
('2023-02-14 12:00:00', 45, 3, 45, 14.99),
('2023-02-15 13:00:00', 46, 1, 46, 15.99),
('2023-02-16 14:00:00', 47, 2, 47, 16.99),
('2023-02-17 15:00:00', 48, 3, 48, 17.99),
('2023-02-18 16:00:00', 49, 1, 49, 18.99),
('2023-02-19 17:00:00', 50, 2, 50, 19.99);

-- Inserts for table 'order_status'
INSERT INTO order_status (status_value) VALUES
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled');

-- Inserts for table 'order_item'
INSERT INTO order_item (customer_order_id, book_id, quantity, price) VALUES
(1, 1, 1, 12.99),
(2, 2, 1, 15.99),
(3, 3, 1, 29.99),
(4, 4, 1, 10.99),
(5, 5, 1, 19.99),
(6, 6, 1, 14.99),
(7, 7, 1, 18.99),
(8, 8, 1, 22.99),
(9, 9, 1, 17.99),
(10, 10, 1, 19.99),
(11, 11, 1, 16.99),
(12, 12, 1, 24.99),
(13, 13, 1, 16.99),
(14, 14, 1, 13.99),
(15, 15, 1, 12.99),
(16, 16, 1, 11.99),
(17, 17, 1, 14.99),
(18, 18, 1, 17.99),
(19, 19, 1, 16.99),
(20, 20, 1, 31.99),
(21, 21, 1, 11.99),
(22, 22, 1, 12.99),
(23, 23, 1, 14.99),
(24, 24, 1, 15.99),
(25, 25, 1, 29.99),
(26, 26, 1,21.99),
(27, 27, 1, 19.99),
(28, 28, 1, 23.99),
(29, 29, 1, 16.99),
(30, 30, 1, 18.99),
(31, 31, 1, 21.99),
(32, 32, 1, 19.99),
(33, 33, 1, 14.99),
(34, 34, 1, 15.99),
(35, 35, 1, 14.99),
(36, 36, 1, 11.99),
(37, 37, 1, 12.99),
(38, 38, 1, 14.99),
(39, 39, 1, 15.99),
(40, 40, 1, 23.99),
(41, 41, 1, 16.99),
(42, 42, 1, 18.99),
(43, 43, 1, 21.99),
(44, 44, 1, 19.99),
(45, 45, 1, 14.99),
(46, 46, 1, 15.99),
(47, 47, 1, 16.99),
(48, 48, 1, 17.99);

-- Inserts for table 'order_history'
INSERT INTO order_history (customer_order_id, order_status_id, status_date) VALUES
(1, 1, '2023-01-01 10:00:00'),
(1, 2, '2023-01-01 10:05:00'),
(1, 3, '2023-01-01 11:00:00'),
(1, 4, '2023-01-02 12:00:00'),
(2, 1, '2023-01-02 11:00:00'),
(2, 2, '2023-01-02 11:05:00'),
(2, 3, '2023-01-03 12:00:00'),
(2, 4, '2023-01-04 13:00:00'),
(3, 1, '2023-01-03 12:00:00'),
(3, 2, '2023-01-03 12:05:00'),
(3, 3, '2023-01-03 13:00:00'),
(3, 4, '2023-01-04 14:00:00'),
(4, 1, '2023-01-04 13:00:00'),
(4, 2, '2023-01-04 13:05:00'),
(4, 3, '2023-01-04 14:00:00'),
(4, 4, '2023-01-05 15:00:00'),
(5, 1, '2023-01-05 14:00:00'),
(5, 2, '2023-01-05 14:05:00'),
(5, 3, '2023-01-05 15:00:00'),
(5, 4, '2023-01-06 16:00:00'),
(6, 1, '2023-01-06 15:00:00'),
(6, 2, '2023-01-06 15:05:00'),
(6, 3, '2023-01-06 16:00:00'),
(6, 4, '2023-01-07 17:00:00'),
(7, 1, '2023-01-07 16:00:00'),
(7, 2, '2023-01-07 16:05:00'),
(7, 3, '2023-01-07 17:00:00'),
(7, 4, '2023-01-08 18:00:00'),
(8, 1, '2023-01-08 17:00:00'),
(8, 2, '2023-01-08 17:05:00'),
(8, 3, '2023-01-08 18:00:00'),
(8, 4, '2023-01-09 19:00:00'),
(9, 1, '2023-01-09 18:00:00'),
(9, 2, '2023-01-09 18:05:00'),
(9, 3, '2023-01-09 19:00:00'),
(9, 4, '2023-01-10 20:00:00'),
(10, 1, '2023-01-10 19:00:00'),
(10, 2, '2023-01-10 19:05:00'),
(10, 3, '2023-01-10 20:00:00'),
(10, 4, '2023-01-11 21:00:00'),
(11, 1, '2023-01-11 20:00:00'),
(11, 2, '2023-01-11 20:05:00'),
(11, 3, '2023-01-11 21:00:00'),
(11, 4, '2023-01-12 22:00:00'),
(12, 1, '2023-01-12 21:00:00'),
(12, 2, '2023-01-12 21:05:00'),
(12, 3, '2023-01-12 22:00:00'),
(12, 4, '2023-01-13 23:00:00'),
(13, 1, '2023-01-13 22:00:00'),
(13, 2, '2023-01-13 22:05:00'),
(13, 3, '2023-01-13 23:00:00'),
(13, 4, '2023-01-14 10:00:00'),
(14, 1, '2023-01-14 23:00:00'),
(14, 2, '2023-01-14 23:05:00'),
(14, 3, '2023-01-15 10:00:00'),
(14, 4, '2023-01-16 11:00:00'),
(15, 1, '2023-01-15 10:00:00'),
(15, 2, '2023-01-15 10:05:00'),
(15, 3, '2023-01-15 11:00:00'),
(15, 4, '2023-01-16 12:00:00'),
(16, 1, '2023-01-16 11:00:00'),
(16, 2, '2023-01-16 11:05:00'),
(16, 3, '2023-01-16 12:00:00'),
(16, 4, '2023-01-17 13:00:00'),
(17, 1, '2023-01-17 12:00:00'),
(17, 2, '2023-01-17 12:05:00'),
(17, 3, '2023-01-17 13:00:00'),
(17, 4, '2023-01-18 14:00:00'),
(18, 1, '2023-01-18 13:00:00'),
(18, 2, '2023-01-18 13:05:00'),
(18, 3, '2023-01-18 14:00:00'),
(18, 4, '2023-01-19 15:00:00'),
(19, 1, '2023-01-19 14:00:00'),
(19, 2, '2023-01-19 14:05:00'),
(19, 3, '2023-01-19 15:00:00'),
(19, 4, '2023-01-20 16:00:00'),
(20, 1, '2023-01-20 15:00:00'),
(20, 2, '2023-01-20 15:05:00'),
(20, 3, '2023-01-20 16:00:00'),
(20, 4, '2023-01-21 17:00:00'),
(21, 1, '2023-01-21 16:00:00'),
(21, 2, '2023-01-21 16:05:00'),
(21, 3, '2023-01-21 17:00:00'),
(21, 4, '2023-01-22 18:00:00'),
(22, 1, '2023-01-22 17:00:00'),
(22, 2, '2023-01-22 17:05:00'),
(22, 3, '2023-01-22 18:00:00'),
(22, 4, '2023-01-23 19:00:00'),
(23, 1, '2023-01-23 18:00:00'),
(23, 2, '2023-01-23 18:05:00'),
(23, 3, '2023-01-23 19:00:00'),
(23, 4, '2023-01-24 20:00:00'),
(24, 1, '2023-01-24 19:00:00'),
(24, 2, '2023-01-24 19:05:00'),
(24, 3, '2023-01-24 20:00:00'),
(24, 4, '2023-01-25 21:00:00'),
(25, 1, '2023-01-25 20:00:00'),
(25, 2, '2023-01-25 20:05:00'),
(25, 3, '2023-01-25 21:00:00'),
(25, 4, '2023-01-26 22:00:00'),
(26, 1, '2023-01-26 21:00:00'),
(26, 2, '2023-01-26 21:05:00'),
(26, 3, '2023-01-26 22:00:00'),
(26, 4, '2023-01-27 23:00:00'),
(27, 1, '2023-01-27 22:00:00'),
(27, 2, '2023-01-27 22:05:00'),
(27, 3, '2023-01-27 23:00:00'),
(27, 4, '2023-01-28 10:00:00'),
(28, 1, '2023-01-28 23:00:00'),
(28, 2, '2023-01-28 23:05:00'),
(28, 3, '2023-01-29 10:00:00'),
(28, 4, '2023-01-30 11:00:00'),
(29, 1, '2023-01-29 10:00:00'),
(29, 2, '2023-01-29 10:05:00'),
(29, 3, '2023-01-29 11:00:00'),
(29, 4, '2023-01-30 12:00:00'),
(30, 1, '2023-01-30 11:00:00'),
(30, 2, '2023-01-30 11:05:00'),
(30, 3, '2023-01-30 12:00:00'),
(30, 4, '2023-01-31 13:00:00'),
(31, 1, '2023-01-31 12:00:00'),
(31, 2, '2023-01-31 12:05:00'),
(31, 3, '2023-01-31 13:00:00'),
(31, 4, '2023-02-01 14:00:00'),
(32, 1, '2023-02-01 13:00:00'),
(32, 2, '2023-02-01 13:05:00'),
(32, 3, '2023-02-01 14:00:00'),
(32, 4, '2023-02-02 15:00:00'),
(33, 1, '2023-02-02 14:00:00'),
(33, 2, '2023-02-02 14:05:00'),
(33, 3, '2023-02-02 15:00:00'),
(33, 4, '2023-02-03 16:00:00'),
(34, 1, '2023-02-03 15:00:00'),
(34, 2, '2023-02-03 15:05:00'),
(34, 3, '2023-02-03 16:00:00'),
(34, 4, '2023-02-04 17:00:00'),
(35, 1, '2023-02-04 16:00:00'),
(35, 2, '2023-02-04 16:05:00'),
(35, 3, '2023-02-04 17:00:00'),
(35, 4, '2023-02-05 18:00:00'),
(36, 1, '2023-02-05 17:00:00'),
(36, 2, '2023-02-05 17:05:00'),
(36, 3, '2023-02-05 18:00:00'),
(36, 4, '2023-02-06 19:00:00'),
(37, 1, '2023-02-06 18:00:00'),
(37, 2, '2023-02-06 18:05:00'),
(37, 3, '2023-02-06 19:00:00'),
(37, 4, '2023-02-07 20:00:00'),
(38, 1, '2023-02-07 19:00:00'),
(38, 2, '2023-02-07 19:05:00'),
(38, 3, '2023-02-07 20:00:00'),
(38, 4, '2023-02-08 21:00:00'),
(39, 1, '2023-02-08 20:00:00'),
(39, 2, '2023-02-08 20:05:00'),
(39, 3, '2023-02-08 21:00:00'),
(39, 4, '2023-02-09 22:00:00'),
(40, 1, '2023-02-09 21:00:00'),
(40, 2, '2023-02-09 21:05:00'),
(40, 3, '2023-02-09 22:00:00'),
(40, 4, '2023-02-10 23:00:00'),
(41, 1, '2023-02-10 22:00:00'),
(41, 2, '2023-02-10 22:05:00'),
(41, 3, '2023-02-10 23:00:00'),
(41, 4, '2023-02-11 10:00:00'),
(42, 1, '2023-02-11 23:00:00'),
(42, 2, '2023-02-11 23:05:00'),
(42, 3, '2023-02-12 10:00:00'),
(42, 4, '2023-02-13 11:00:00'),
(43, 1, '2023-02-12 10:00:00'),
(43, 2, '2023-02-12 10:05:00'),
(43, 3, '2023-02-12 11:00:00'),
(43, 4, '2023-02-13 12:00:00'),
(44, 1, '2023-02-13 11:00:00'),
(44, 2, '2023-02-13 11:05:00'),
(44, 3, '2023-02-13 12:00:00'),
(44, 4, '2023-02-14 13:00:00'),
(45, 1, '2023-02-14 12:00:00'),
(45, 2, '2023-02-14 12:05:00'),
(45, 3, '2023-02-14 13:00:00'),
(45, 4, '2023-02-15 14:00:00'),
(46, 1, '2023-02-15 13:00:00'),
(46, 2, '2023-02-15 13:05:00'),
(46, 3, '2023-02-15 14:00:00'),
(46, 4, '2023-02-16 15:00:00'),
(47, 1, '2023-02-16 14:00:00'),
(47, 2, '2023-02-16 14:05:00'),
(47, 3, '2023-02-16 15:00:00'),
(47, 4, '2023-02-17 16:00:00'),
(48, 1, '2023-02-17 15:00:00'),
(48, 2, '2023-02-17 15:05:00'),
(48, 3, '2023-02-17 16:00:00'),
(48, 4, '2023-02-18 17:00:00'),
(49, 1, '2023-02-18 16:00:00'),
(49, 2, '2023-02-18 16:05:00'),
(49, 3, '2023-02-18 17:00:00'),
(49, 4, '2023-02-19 18:00:00'),
(50, 1, '2023-02-19 17:00:00'),
(50, 2, '2023-02-19 17:05:00'),
(50, 3, '2023-02-19 18:00:00'),
(50, 4, '2023-02-20 19:00:00');

-- Inserts for table 'order_item_return'
INSERT INTO order_item_return (order_item_id, item_quantity, item_return_request_date, item_return_delivered_date, status) VALUES
(1, 1, '2023-01-02 12:00:00', '2023-01-05 15:00:00', 'yes'),
(2, 1, '2023-01-03 13:00:00', '2023-01-07 17:00:00', 'yes'),
(3, 1, '2023-01-04 14:00:00', '2023-01-09 19:00:00', 'yes'),
(4, 1, '2023-01-05 15:00:00', '2023-01-11 21:00:00', 'yes'),
(5, 1, '2023-01-06 16:00:00', '2023-01-13 23:00:00', 'yes'),
(6, 1, '2023-01-07 17:00:00', '2023-01-15 10:00:00', 'yes'),
(7, 1, '2023-01-08 18:00:00', '2023-01-17 13:00:00', 'yes'),
(8, 1, '2023-01-09 19:00:00', '2023-01-19 15:00:00', 'yes'),
(9, 1, '2023-01-10 20:00:00', '2023-01-21 17:00:00', 'yes'),
(10, 1, '2023-01-11 21:00:00', '2023-01-23 19:00:00', 'yes'),
(11, 1, '2023-01-12 22:00:00', '2023-01-25 21:00:00', 'yes'),
(12, 1, '2023-01-13 23:00:00', '2023-01-27 23:00:00', 'yes'),
(13, 1, '2023-01-14 10:00:00', '2023-01-29 10:00:00', 'yes'),
(14, 1, '2023-01-15 11:00:00', '2023-01-31 13:00:00', 'yes'),
(15, 1, '2023-01-16 12:00:00', '2023-02-03 16:00:00', 'yes'),
(16, 1, '2023-01-17 13:00:00', '2023-02-05 18:00:00', 'yes'),
(17, 1, '2023-01-18 14:00:00', '2023-02-07 20:00:00', 'yes'),
(18, 1, '2023-01-19 15:00:00', '2023-02-09 22:00:00', 'yes'),
(19, 1, '2023-01-20 16:00:00', '2023-02-11 23:00:00', 'yes'),
(20, 1, '2023-01-21 17:00:00', '2023-02-13 11:00:00', 'yes'),
(21, 1, '2023-01-22 18:00:00', '2023-02-15 14:00:00', 'yes'),
(22, 1, '2023-01-23 19:00:00', '2023-02-17 16:00:00', 'yes'),
(23, 1, '2023-01-24 20:00:00', '2023-02-19 18:00:00', 'yes'),
(24, 1, '2023-01-25 21:00:00', '2023-02-21 10:00:00', 'yes'),
(25, 1, '2023-01-26 22:00:00', '2023-02-23 11:00:00', 'yes'),
(26, 1, '2023-01-27 23:00:00', '2023-02-25 12:00:00', 'yes'),
(27, 1, '2023-01-28 10:00:00', '2023-02-27 13:00:00', 'yes'),
(28, 1, '2023-01-29 10:00:00', '2023-03-01 14:00:00', 'yes'),
(29, 1, '2023-01-30 12:00:00', '2023-03-03 15:00:00', 'yes'),
(30, 1, '2023-01-31 13:00:00', '2023-03-05 16:00:00', 'yes'),
(31, 1, '2023-02-01 14:00:00', '2023-03-07 17:00:00', 'yes'),
(32, 1, '2023-02-02 15:00:00', '2023-03-09 18:00:00', 'yes'),
(33, 1, '2023-02-03 16:00:00', '2023-03-11 19:00:00', 'yes'),
(34, 1, '2023-02-04 17:00:00', '2023-03-13 20:00:00', 'yes'),
(35, 1, '2023-02-05 18:00:00', '2023-03-15 21:00:00', 'yes'),
(36, 1, '2023-02-06 19:00:00', '2023-03-17 22:00:00', 'yes'),
(37, 1, '2023-02-07 20:00:00', '2023-03-19 23:00:00', 'yes'),
(38, 1, '2023-02-08 21:00:00', '2023-03-21 10:00:00', 'yes'),
(39, 1, '2023-02-09 22:00:00', '2023-03-23 11:00:00', 'yes'),
(40, 1, '2023-02-10 23:00:00', '2023-03-25 12:00:00', 'yes'),
(41, 1, '2023-02-11 10:00:00', '2023-03-27 13:00:00', 'yes'),
(42, 1, '2023-02-12 11:00:00', '2023-03-29 14:00:00', 'yes'),
(43, 1, '2023-02-13 12:00:00', '2023-03-31 15:00:00', 'yes'),
(44, 1, '2023-02-14 13:00:00', '2023-04-02 16:00:00', 'yes'),
(45, 1, '2023-02-15 14:00:00', '2023-04-04 17:00:00', 'yes'),
(46, 1, '2023-02-16 15:00:00', '2023-04-06 18:00:00', 'yes'),
(47, 1, '2023-02-17 16:00:00', '2023-04-08 19:00:00', 'yes'),
(48, 1, '2023-02-18 17:00:00', '2023-04-10 20:00:00', 'yes');


UPDATE address
JOIN address_state ON address_state.address_state_id = address.address_state_id
SET 
    apartment_number = COALESCE(apartment_number, 'Apt 1'),
    city = CASE 
                WHEN city = 'Hometown' THEN 
                    CASE 
                        WHEN address_state.state_name = 'Alabama' THEN 'Birmingham'
                        WHEN address_state.state_name = 'Alaska' THEN 'Anchorage'
                        WHEN address_state.state_name = 'Arizona' THEN 'Phoenix'
                        WHEN address_state.state_name = 'Arkansas' THEN 'Little Rock'
                        WHEN address_state.state_name = 'California' THEN 'Los Angeles'
                        WHEN address_state.state_name = 'Colorado' THEN 'Denver'
                        WHEN address_state.state_name = 'Connecticut' THEN 'Hartford'
                        WHEN address_state.state_name = 'Delaware' THEN 'Wilmington'
                        WHEN address_state.state_name = 'Florida' THEN 'Jacksonville'
                        WHEN address_state.state_name = 'Georgia' THEN 'Atlanta'
                        WHEN address_state.state_name = 'Hawaii' THEN 'Honolulu'
                        WHEN address_state.state_name = 'Idaho' THEN 'Boise'
                        WHEN address_state.state_name = 'Illinois' THEN 'Chicago'
                        WHEN address_state.state_name = 'Indiana' THEN 'Indianapolis'
                        WHEN address_state.state_name = 'Iowa' THEN 'Des Moines'
                        WHEN address_state.state_name = 'Kansas' THEN 'Wichita'
                        WHEN address_state.state_name = 'Kentucky' THEN 'Louisville'
                        WHEN address_state.state_name = 'Louisiana' THEN 'New Orleans'
                        WHEN address_state.state_name = 'Maine' THEN 'Portland'
                        WHEN address_state.state_name = 'Maryland' THEN 'Baltimore'
                        WHEN address_state.state_name = 'Massachusetts' THEN 'Boston'
                        WHEN address_state.state_name = 'Michigan' THEN 'Detroit'
                        WHEN address_state.state_name = 'Minnesota' THEN 'Minneapolis'
                        WHEN address_state.state_name = 'Mississippi' THEN 'Jackson'
                        WHEN address_state.state_name = 'Missouri' THEN 'Kansas City'
                        WHEN address_state.state_name = 'Montana' THEN 'Billings'
                        WHEN address_state.state_name = 'Nebraska' THEN 'Omaha'
                        WHEN address_state.state_name = 'Nevada' THEN 'Las Vegas'
                        WHEN address_state.state_name = 'New Hampshire' THEN 'Manchester'
                        WHEN address_state.state_name = 'New Jersey' THEN 'Newark'
                        WHEN address_state.state_name = 'New Mexico' THEN 'Albuquerque'
                        WHEN address_state.state_name = 'New York' THEN 'New York City'
                        WHEN address_state.state_name = 'North Carolina' THEN 'Charlotte'
                        WHEN address_state.state_name = 'North Dakota' THEN 'Fargo'
                        WHEN address_state.state_name = 'Ohio' THEN 'Columbus'
                        WHEN address_state.state_name = 'Oklahoma' THEN 'Oklahoma City'
                        WHEN address_state.state_name = 'Oregon' THEN 'Portland'
                        WHEN address_state.state_name = 'Pennsylvania' THEN 'Philadelphia'
                        WHEN address_state.state_name = 'Rhode Island' THEN 'Providence'
                        WHEN address_state.state_name = 'South Carolina' THEN 'Columbia'
                        WHEN address_state.state_name = 'South Dakota' THEN 'Sioux Falls'
                        WHEN address_state.state_name = 'Tennessee' THEN 'Memphis'
                        WHEN address_state.state_name = 'Texas' THEN 'Houston'
                        WHEN address_state.state_name = 'Utah' THEN 'Salt Lake City'
                        WHEN address_state.state_name = 'Vermont' THEN 'Burlington'
                        WHEN address_state.state_name = 'Virginia' THEN 'Virginia Beach'
                        WHEN address_state.state_name = 'Washington' THEN 'Seattle'
                        WHEN address_state.state_name = 'West Virginia' THEN 'Charleston'
                        WHEN address_state.state_name = 'Wisconsin' THEN 'Milwaukee'
                        WHEN address_state.state_name = 'Wyoming' THEN 'Cheyenne'
                        ELSE city
                    END
                ELSE city
            END
WHERE apartment_number IS NULL OR city = 'Hometown';


-- Views
-- View to display book details along with author names
CREATE VIEW book_details AS
SELECT b.book_id, b.title, b.isbn13, b.num_pages, b.publication_date, b.price,
       GROUP_CONCAT(a.author_name SEPARATOR ', ') AS authors
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
GROUP BY b.book_id;

-- View to display customer orders with shipping details
CREATE VIEW customer_order_details AS
SELECT co.customer_order_id, co.order_date, co.total_price,
       c.first_name, c.last_name, c.email, c.phone,
       s.method_name AS shipping_method, s.cost AS shipping_cost,
       a.street_number, a.street_name, a.apartment_number, a.city,
       a.zip_code, ads.state_name
FROM customer_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN shipping_method s ON co.shipping_method_id = s.shipping_method_id
JOIN address a ON co.destination_address_id = a.address_id
JOIN address_state ads ON a.address_state_id = ads.address_state_id;

-- View to display total sales by book
CREATE VIEW total_sales_by_book AS
SELECT b.book_id, b.title, COUNT(oi.order_item_id) AS total_sales
FROM book b
LEFT JOIN order_item oi ON b.book_id = oi.book_id
GROUP BY b.book_id;

-- View to display customers with their order counts
CREATE VIEW customer_order_counts AS
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
       COUNT(co.customer_order_id) AS order_count
FROM customer c
LEFT JOIN customer_order co ON c.customer_id = co.customer_id
GROUP BY c.customer_id;

-- View to display order item returns with associated details
CREATE VIEW order_item_return_details AS
SELECT oir.order_item_return_id, oi.order_item_id, oi.book_id, 
       oi.quantity AS original_quantity, oi.price AS original_price,
       oir.item_quantity AS returned_quantity, oir.item_return_request_date, 
       oir.item_return_delivered_date, oir.status
FROM order_item_return oir
JOIN order_item oi ON oir.order_item_id = oi.order_item_id;


-- Stored Procedures
-- Stored Procedure to retrieve order history for a specific customer
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrderHistory`(IN customerId INT)
BEGIN
    SELECT os.status_value AS order_status, oh.status_date
    FROM order_history oh
    JOIN order_status os ON oh.order_status_id = os.order_status_id
    JOIN customer_order co ON oh.customer_order_id = co.customer_order_id
    WHERE co.customer_id = customerId;
END //
DELIMITER ;

-- Stored Procedure to retrieve order items for a specific order
DELIMITER //
CREATE PROCEDURE GetOrderItems(IN orderId INT)
BEGIN
    SELECT oi.order_item_id, oi.book_id, b.title, oi.quantity, oi.price
    FROM order_item oi
    JOIN book b ON oi.book_id = b.book_id
    WHERE oi.customer_order_id = orderId;
END //
DELIMITER ;

-- Stored Procedure to update order status
DELIMITER //
CREATE PROCEDURE UpdateOrderStatus(IN orderId INT, IN statusValue VARCHAR(20))
BEGIN
    DECLARE statusId INT;
    SELECT order_status_id INTO statusId FROM order_status WHERE status_value = statusValue;
    IF statusId IS NOT NULL THEN
        INSERT INTO order_history (customer_order_id, order_status_id, status_date)
        VALUES (orderId, statusId, NOW());
    END IF;
END //
DELIMITER ;


-- Functions
-- Function to calculate total price for an order item
DELIMITER //
CREATE FUNCTION CalculateOrderItemTotalPrice(quantity INT, price DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE totalPrice DECIMAL(10, 2);
    SET totalPrice = quantity * price;
    RETURN totalPrice;
END //
DELIMITER ;

-- Function to calculate total order price
DELIMITER //
CREATE FUNCTION CalculateOrderTotalPrice(orderId INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(quantity * price) INTO total
    FROM order_item
    WHERE customer_order_id = orderId;
    RETURN total;
END //
DELIMITER ;

-- Function to get the average number of pages per book
DELIMITER //
CREATE FUNCTION AveragePagesPerBook()
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE avgPages DECIMAL(10, 2);
    SELECT AVG(num_pages) INTO avgPages FROM book;
    RETURN avgPages;
END //
DELIMITER ;
