# LibraryDB
# Library Management System (Question 1)

## Overview

This project implements a **Library Management System** database using MySQL. It provides a complete relational schema to track **Books**, **Authors**, **Customers**, and **Borrowing Transactions**. The database enforces proper constraints and relationships to maintain data integrity.

## Features

* **Books**: Stores book metadata including title, ISBN, and publication year.
* **Authors**: Stores author names and enforces uniqueness.
* **Customers**: Stores customer contact information with unique email.
* **Transactions**: Records which customer borrowed which book and when.
* **Book–Author M\:N relationship**: A join table `BookAuthors` implements the many-to-many relationship between books and authors.

## Prerequisites

* **MySQL Server** (8.0+ recommended)
* **MySQL Workbench** or any SQL client
* **Internet access** for downloading MySQL if not already installed

## Setup Instructions

1. **Clone or download** this repository.
2. **Open MySQL Workbench** (or connect via CLI):

   ```sh
   mysql -u <username> -p
   ```
3. **Run the SQL script** `library_schema.sql` (provided) to create the database, tables, and sample data:

   ```sql
   SOURCE /path/to/library_schema.sql;
   ```
4. **Verify tables**:

   ```sql
   SHOW TABLES IN LibraryDB;
   ```
5. **Inspect sample data**:

   ```sql
   SELECT * FROM Authors;
   SELECT * FROM Books;
   SELECT * FROM Customers;
   SELECT * FROM Transactions;
   SELECT * FROM BookAuthors;
   ```

## Database Schema

### Tables and Columns

**Authors**

* `AuthorID` INT PRIMARY KEY AUTO\_INCREMENT
* `FirstName` VARCHAR(100) NOT NULL
* `LastName` VARCHAR(100) NOT NULL
* **Unique:** (`FirstName`,`LastName`)

**Books**

* `BookID` INT PRIMARY KEY AUTO\_INCREMENT
* `Title` VARCHAR(255) NOT NULL
* `ISBN` VARCHAR(20) NOT NULL UNIQUE
* `PublishedYear` INT NOT NULL

**Customers**

* `CustomerID` INT PRIMARY KEY AUTO\_INCREMENT
* `FirstName` VARCHAR(100) NOT NULL
* `LastName` VARCHAR(100) NOT NULL
* `Email` VARCHAR(100) NOT NULL UNIQUE
* `PhoneNumber` VARCHAR(15)

**Transactions**

* `TransactionID` INT PRIMARY KEY AUTO\_INCREMENT
* `CustomerID` INT NOT NULL (FK → `Customers.CustomerID`)
* `BookID` INT NOT NULL (FK → `Books.BookID`)
* `BorrowDate` DATE NOT NULL
* `ReturnDate` DATE

**BookAuthors** (Join Table)

* `BookID` INT NOT NULL (FK → `Books.BookID`)
* `AuthorID` INT NOT NULL (FK → `Authors.AuthorID`)
* **Primary Key:** (`BookID`,`AuthorID`)

## Relationships

* **M\:N** between `Books` and `Authors` via `BookAuthors`.
* **1\:M** from `Customers` to `Transactions`.
* **1\:M** from `Books` to `Transactions`.

## Sample Data

```sql
-- Authors
INSERT INTO Authors (FirstName, LastName) VALUES
  ('George', 'Orwell'),
  ('J.K.', 'Rowling'),
  ('J.R.R.', 'Tolkien');

-- Books
INSERT INTO Books (Title, ISBN, PublishedYear) VALUES
  ('1984', '978-0451524935', 1949),
  ('Harry Potter and the Philosopher''s Stone', '978-0747532699', 1997),
  ('The Hobbit', '978-0618260300', 1937);

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES
  ('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
  ('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901');

-- Transactions
INSERT INTO Transactions (CustomerID, BookID, BorrowDate, ReturnDate) VALUES
  (1, 1, '2025-01-01', '2025-02-01'),
  (2, 2, '2025-01-15', '2025-02-15');

-- BookAuthors
INSERT INTO BookAuthors (BookID, AuthorID) VALUES
  (1, 1),
  (2, 2),
  (3, 3);
```

## Usage Examples

* **Find all books borrowed by a customer**:

  ```sql
  SELECT b.Title, t.BorrowDate, t.ReturnDate
  FROM Transactions t
  JOIN Books b ON t.BookID = b.BookID
  WHERE t.CustomerID = 1;
  ```

* **List all authors of a specific book**:

  ```sql
  SELECT a.FirstName, a.LastName
  FROM BookAuthors ba
  JOIN Authors a ON ba.AuthorID = a.AuthorID
  WHERE ba.BookID = 2;
  ```


