CREATE DATABASE `library_db` ;

CREATE TABLE `library_db`.`books` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `genre` VARCHAR(100) NOT NULL,
  `publish_year` INT NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`book_id`));

CREATE TABLE `library_db`.`authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `country` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`author_id`));

-- INSERT INTO with the data provided 
INSERT INTO `library_db`.`authors` (`author_id`, `name`, `country`) VALUES ('101', 'Thandiwe Mkhize', 'South Africa');
INSERT INTO `library_db`.`authors` (`author_id`, `name`, `country`) VALUES ('102', 'Johan van der Merwe', 'Netherlands');
INSERT INTO `library_db`.`authors` (`author_id`, `name`, `country`) VALUES ('103', 'Sipho Dlamini', 'South Africa');
INSERT INTO `library_db`.`authors` (`author_id`, `name`, `country`) VALUES ('104', 'Zanele Molefe', 'Zimbabwe');

INSERT INTO `library_db`.`books` (`book_id`, `title`, `genre`, `publish_year`, `author_id`) VALUES ('1', 'The Journey of Knowledge', 'Non-Fiction', '2018', '101');
INSERT INTO `library_db`.`books` (`book_id`, `title`, `genre`, `publish_year`, `author_id`) VALUES ('2', 'Adventures in Coding', 'echnology', '2021', '102');
INSERT INTO `library_db`.`books` (`book_id`, `title`, `genre`, `publish_year`, `author_id`) VALUES ('3', 'The Art of Storytelling', 'Fiction', '2015', '103');
INSERT INTO `library_db`.`books` (`book_id`, `title`, `genre`, `publish_year`, `author_id`) VALUES ('4', 'Learning SQL for Beginners', 'Technology', '2020', '102');
INSERT INTO `library_db`.`books` (`book_id`, `title`, `genre`, `publish_year`, `author_id`) VALUES ('5', 'Hidden Gems of South African Tales', 'Fiction', '2017', '104');

-- Query Tasks
-- Tasks 3: Sorting data
-- Books sorted by published year (descending)
SELECT *
FROM  `library_db`.`books`
ORDER BY `publish_year` DESC;

-- Authors sorted alphabetically by name
SELECT *
FROM `library_db`.`authors`
ORDER BY `name` ASC;

-- Task 4: Restricting Data
-- Displays the first 3 books
SELECT *
FROM `library_db`.`books`
ORDER BY `publish_year` DESC -- ORDER BY defines which books are considered "first"
LIMIT 3; -- LIMIT 3 restricts the output to 3 rows

-- Displays the next 2 books
SELECT *
FROM `library_db`.`books`
ORDER BY `publish_year` DESC
LIMIT 2 OFFSET 3; -- OFFSET 3 skips the first 3 rows and LIMIT 2 returns the next 2 rows

-- Task 5: Wildcards (LIKE)
SELECT *
FROM `library_db`.`books`
WHERE `title` LIKE '%Coding%'; -- '%' reprsents any number of characters, %Coding% matches with the word "coding" 

-- Authors whose names start with 'S'
SELECT *
FROM `library_db`.`authors`
WHERE `name` LIKE 'S%'; -- S% matches with text that start with "S"

-- Using the "_" Wildcard
SELECT *
FROM `library_db`.`authors`
WHERE `name` LIKE '_mith'; -- "_" matchs exactly one character

-- Task 6: Joins and Advanced Queries
-- INNER JOIN displays each book with it's author's Name and Country
SELECT `library_db`.`books`.`title`, `library_db`.`authors`.`name` AS `name`, `library_db`.`authors`.`country`
FROM `library_db`.`books`
INNER JOIN `library_db`.`authors` -- INNER JOIN returns only matching records from both tables
ON `library_db`.`books`.`author_id` = `library_db`.`authors`.`author_id`; -- ON specifies the join condition using `author_id`

-- Count how many books each author has written
SELECT `library_db`.`authors`.`name` AS `name`, COUNT(`library_db`.`books`.`book_id`) AS total_books -- COUNT(`library_db`.`books`.`book_id`) counts the number of books per author
FROM `library_db`.`authors`
INNER JOIN `library_db`.`books`
ON `library_db`.`authors`.`author_id`
GROUP BY `library_db`.`authors`.`name`; -- GROUP BY `library_db`.`authors`.`name` groups results by author

-- Bonus Challenge
-- Writing a query to find all books published before 2019, written by authors from South Africa
SELECT `library_db`.`books`.`title`, `library_db`.`books`.`publish_year`, `library_db`.`authors`.`name` AS `name`
FROM `library_db`.`books`
INNER JOIN `library_db`.`authors` -- INNER JOIN links books to their authors
ON `library_db`.`books`.`author_id` = `library_db`.`authors`.`author_id`
WHERE `library_db`.`books`.`publish_year` < 2018 -- WHERE applies both conditions
	AND `library_db`.`authors`.`country` = 'South Africa';

-- Adding a new column `ISBN` to the `books` table, then inserting IBSN numbers for each book
ALTER TABLE `library_db`.`books` 
ADD COLUMN `ISBN` VARCHAR(17) NULL AFTER `author_id`,
ADD UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE;
;

-- Updating the ISBN values
UPDATE `library_db`.`books` SET `ISBN` = '978-0131103627' WHERE (`book_id` = '1');
UPDATE `library_db`.`books` SET `ISBN` = '978-0201633610' WHERE (`book_id` = '2');
UPDATE `library_db`.`books` SET `ISBN` = '978-1491950296' WHERE (`book_id` = '3');
UPDATE `library_db`.`books` SET `ISBN` = '978-1344121231' WHERE (`book_id` = '4');
UPDATE `library_db`.`books` SET `ISBN` = '978-0438175325' WHERE (`book_id` = '5');


