CREATE DATABASE jh8vn;

-- Give access to accounts jh8vn_a, jh8vn_b, jh8vn_c, and jh8vn_d basic rights for CRUD; password for each account is default "Spring2024"
GRANT SELECT, INSERT, UPDATE, DELETE ON jh8vn.* TO 'jh8vn_a'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON jh8vn.* TO 'jh8vn_b'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON jh8vn.* TO 'jh8vn_c'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON jh8vn.* TO 'jh8vn_d'@'%';

-- Create 'users' table
CREATE TABLE users(
	userId INT PRIMARY KEY,
    email VARCHAR(50),
    userPassword VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL
);

-- Create 'book' table; pageLength attribute removed as it is not metadata for Project Gutenburg
CREATE TABLE book(
	bookId INT PRIMARY KEY,
    bookName VARCHAR(100) UNIQUE NOT NULL,
    author VARCHAR(50) NOT NULL,
    totalQuantity INT NOT NULL,
    numCheckedOut INT NOT NULL,
    coverImagePath VARCHAR(150),
    rating FLOAT
);

-- Create 'librarian' table
CREATE TABLE librarian(
	userId INT PRIMARY KEY,
    specialization VARCHAR(50) NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(userId)
);

-- Create 'student' table
CREATE TABLE student(
	userId INT PRIMARY KEY,
    gradeLevel INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(userId)
);

-- Create 'checkouts' table
CREATE TABLE checkouts(
    userId INT,
    bookId INT,
    checkoutDate DATE NOT NULL,
    PRIMARY KEY (userId, bookId),
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (bookId) REFERENCES book(bookId)
);

-- Create 'rates' table
CREATE TABLE rates(
    userId INT,
    bookId INT,
    oneTimeRating FLOAT NOT NULL,
    PRIMARY KEY (userId, bookId),
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (bookId) REFERENCES book(bookId)
);

-- Create 'favorites' table
CREATE TABLE favorites(
    userId INT,
    bookId INT,
    comment VARCHAR(200) NOT NULL,
    PRIMARY KEY (userId, bookId),
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (bookId) REFERENCES book(bookId)
);

-- Create 'addLogs' table
CREATE TABLE addLogs(
    userId INT,
    bookId INT,
    addDate DATE NOT NULL,
    PRIMARY KEY (userId, bookId),
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (bookId) REFERENCES book(bookId)
);

-- Create 'deleteUpdateLogs' table
CREATE TABLE deleteUpdateLogs(
    userId INT,
    bookId INT,
    modifyDate DATE NOT NULL,
    PRIMARY KEY (userId, bookId),
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (bookId) REFERENCES book(bookId)
);

-- Create 'taughtBy' table
CREATE TABLE taughtBy(
    studentId INT,
    librarianId INT,
    meetingDays DATE NOT NULL,
    PRIMARY KEY (studentId, librarianId),
    FOREIGN KEY (studentId) REFERENCES student(userId),
    FOREIGN KEY (librarianId) REFERENCES librarian(userId)
);


-- DB from https://www.gutenberg.org/cache/epub/feeds/      ; pg_catatlog.csv last modified 03/24/2024