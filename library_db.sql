
--  Creating the Database
CREATE DATABASE library_db;
USE library_db;

--  Creating tables in order of dependency

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
-- Creating the members table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE NOT NULL
);
-- Creating the books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) UNIQUE NOT NULL,
    published_year YEAR,
    category_id INT,
    total_copies INT NOT NULL,
    available_copies INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Creating the authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- SELECT book_id, title FROM books;
-- SELECT author_id, name FROM authors;


-- Creating the table for the authors of various books
CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Creating the table for the books being borrowed
CREATE TABLE borrowings (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Creating the table for Library staff
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL
);

--  Inserting data into categories
INSERT INTO categories (name) 
VALUES  ('Fiction'), 
		('Science'), 
        ('Technology'), 
        ('History'), 
        ('Philosophy');

--  Inserting into authors
INSERT INTO authors (name) 
VALUES  ('George Orwell'), 
		('Isaac Newton'), 
		('Jane Austen'), 
		('Yuval Noah Harari'), 
		('Plato');

--  Insert into members
INSERT INTO members (first_name, last_name, email, join_date) 
VALUES	('Alice', 'Johnson', 'alice.johnson@example.com', '2023-01-15'),
		('Bob', 'Smith', 'bob.smith@example.com', '2023-03-10'),
		('Carol', 'Davis', 'carol.davis@example.com', '2023-06-01');

--  Inserting into books
INSERT INTO books (title, isbn, published_year, category_id, total_copies, available_copies) 
VALUES	('1984', '9780141036144', 1949, 1, 3, 3), -- Fiction
		('Philosophiæ Naturalis Principia Mathematica', '9780520088177', 1987, 2, 3, 3), -- Science
		('Pride and Prejudice', '9780141439518', 1913, 1, 4, 4), -- Fiction
		('Sapiens: A Brief History of Humankind', '9780062316097', 2011, 4, 6, 2); -- History


-- ALTER TABLE books AUTO_INCREMENT = 1;

-- Inserting into book_authors with verified IDs
INSERT INTO book_authors (book_id, author_id) VALUES
    (13, 1),  -- 1984 - George Orwell
    (14, 2),  -- Principia - Isaac Newton
    (15, 3),  -- Pride and Prejudice - Jane Austen
    (16, 4);  -- Sapiens - Yuval Noah Harari


--  Inserting into borrowings
INSERT INTO borrowings (member_id, book_id, borrow_date, return_date) VALUES
    (1, 13, '2024-12-01', '2025-01-01'),  -- Alice borrows '1984'
    (2, 14, '2025-01-10', NULL),          -- Bob borrows 'Principia'
    (3, 15, '2025-03-01', '2025-04-01');  -- Carol borrows 'Pride and Prejudice'


-- Inserting into staff
INSERT INTO staff (name, role, email) VALUES
    ('David Miller', 'Librarian', 'david.miller@example.com'),
    ('Eve Thompson', 'Assistant', 'eve.thompson@example.com');
