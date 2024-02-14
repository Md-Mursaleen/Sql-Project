-- Create Authors table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

DESC Authors;

-- Create Books table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    price DECIMAL(10, 2) NOT NULL,
    quantity_available INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

DESC Books;

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    address VARCHAR(255),
    phone_number VARCHAR(10)
);

DESC Customers;

-- Create Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

DESC Orders;

-- Insert data into Authors table
INSERT INTO Authors (author_name) VALUES 
('J.K. Rowling'),
('George Orwell'),
('Harper Lee');

-- Insert data into Books table
INSERT INTO Books (title, author_id, price, quantity_available) VALUES
('Harry Potter and the Philosopher''s Stone', 1, 199, 100),
('1984', 2, 154, 50),
('To Kill a Mockingbird', 3, 390, 75);

-- Insert data into Customers table
INSERT INTO Customers (customer_name, email, address) VALUES
('HR Recruiter', 'blinkit@example.com', 'Gurugram, India'),
('Md Mursaleen', 'zomato@example.com', 'Banglore, India');

-- Insert data into Orders table
INSERT INTO Orders (customer_id, book_id, quantity, order_date) VALUES
(1, 1, 2, '2024-01-15'),
(1, 2, 1, '2024-01-20'),
(2, 1, 1, '2024-01-25'),
(2, 3, 3, '2024-01-28');

-- Reteriving the list of top-selling books
SELECT b.title, a.author_name, SUM(o.quantity) as total_sold
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.title, a.author_name
ORDER BY total_sold DESC;

-- Calcualte the total sales for a given period (i take the period of january 2024)
SELECT SUM(b.price * o.quantity) as total_revenue
FROM Books b
JOIN Orders o ON b.book_id = o.book_id
WHERE MONTH(o.order_date) = 1 AND YEAR(o.order_date) = 2024;
