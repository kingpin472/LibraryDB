-- Create database
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- Create Authors table
CREATE TABLE Authors (
  AuthorID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  UNIQUE (FirstName, LastName)
);

-- Create Books table
CREATE TABLE Books (
  BookID INT AUTO_INCREMENT PRIMARY KEY,
  Title VARCHAR(255) NOT NULL,
  ISBN VARCHAR(20) NOT NULL UNIQUE,
  PublishedYear INT NOT NULL
);

-- Create Customers table
CREATE TABLE Customers (
  CustomerID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(100) NOT NULL,
  LastName VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL UNIQUE,
  PhoneNumber VARCHAR(15),
  UNIQUE (Email)
);

-- Create Transactions table (M-M relationship between Books and Customers)
CREATE TABLE Transactions (
  TransactionID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT,
  BookID INT,
  BorrowDate DATE NOT NULL,
  ReturnDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
  FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);

-- Create many-to-many relationship table between Books and Authors
CREATE TABLE BookAuthors (
  BookID INT,
  AuthorID INT,
  PRIMARY KEY (BookID, AuthorID),
  FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
  FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- Sample Data for Authors
INSERT INTO Authors (FirstName, LastName) VALUES 
('George', 'Orwell'),
('J.K.', 'Rowling'),
('J.R.R.', 'Tolkien');

-- Sample Data for Books
INSERT INTO Books (Title, ISBN, PublishedYear) VALUES 
('1984', '978-0451524935', 1949),
('Harry Potter and the Philosopher\'s Stone', '978-0747532699', 1997),
('The Hobbit', '978-0618260300', 1937);

-- Sample Data for Customers
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901'),
('Emily', 'Clark', 'emily.clark@example.com', '345-678-9012');

-- Sample Data for Transactions
INSERT INTO Transactions (CustomerID, BookID, BorrowDate, ReturnDate) VALUES 
(1, 1, '2023-01-01', '2023-02-01'),
(2, 2, '2023-01-15', '2023-02-15'),
(3, 3, '2023-01-20', '2023-02-20');

-- Sample Data for BookAuthors
INSERT INTO BookAuthors (BookID, AuthorID) VALUES 
(1, 1), -- 1984 by George Orwell
(2, 2), -- Harry Potter by J.K. Rowling
(3, 3); -- The Hobbit by J.R.R. Tolkien
