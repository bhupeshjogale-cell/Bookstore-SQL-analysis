CREATE TABLE BOOKS(
BOOK_ID SERIAL PRIMARY KEY,
TITLE VARCHAR (250),
AUTHOR VARCHAR(50),
GENRE VARCHAR(100),
PUBLISHED_YEAR INT,
PRICE NUMERIC(10,2),
STOCK INT
);

CREATE TABLE CUSTOMERS(
CUSTOMER_ID SERIAL PRIMARY KEY,
NAME VARCHAR (50),
EMAIL VARCHAR (100),
PHONE VARCHAR (15),
CITY VARCHAR (50),
COUNTRY VARCHAR(50)
);

CREATE TABLE ORDERS(
ORDER_ID SERIAL PRIMARY KEY,
CUSTOMER_ID  INT REFERENCES CUSTOMERS(CUSTOMER_ID),
BOOK_ID INT REFERENCES BOOKS(BOOK_ID),
ORDERS_DATE DATE,
QUANTITY INT,
TOTAL_AMOUNT NUMERIC (10,2)
);

--Importing Data

--Importing Books Data
COPY
BOOKS(BOOKS_ID,TITLE,AUTHOR,GENRE,PUBLISHED_YEAR,PRICE,STOCK)
FROM COPY books FROM '/your/path/data/Books.csv' CSV HEADER;'
CSV HEADER ;

--Importing Customers Data
COPY 
CUSTOMERS(CUSTOMER_ID, NAME, EMAIL, PHONE, CITY, COUNTRY)
FROM COPY customers FROM '/your/path/data/Customers.csv' CSV HEADER;'
CSV HEADER;

--Importing Orders Data
COPY ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, ORDER_DATE, QUANTITY, TOTAL_AMOUNT)
FROM 'COPY orders FROM '/your/path/data/Orders.csv' CSV HEADER;'
CSV HEADER;

---Altering Table
ALTER TABLE CUSTOMERS
ALTER COLUMN CITY TYPE VARCHAR (100);

TRUNCATE TABLE CUSTOMERS;

ALTER TABLE CUSTOMERS
ALTER COLUMN COUNTRY TYPE VARCHAR (100);

--Checking Data
SELECT * FROM BOOKS;
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;

--Basic SQL Query

--1) Retrieve all books in the "Fiction" genre:

SELECT * FROM BOOKS
WHERE GENRE = 'Fiction';

--2) find books published after the year 1950:

Select * from books
where Published_year > 1950;

--3) List all the customers from the canada:

Select * from customers
where country = 'Canada';

--4) Show orders placed in november 2023:

Select * from books
where orders_date between '2023-11-01' and '2023-11-30';

--5) Retrive the total stock of books available book;
Select sum(stock) as total_books_available
from books;

--6)Find the detail of most expensive book:

Select * from books
order by price desc 
limit 1; 00

--7)Show all customers who ordered more then 1 quantity of a books:

Select C.customer_id,C.name,
	   O.quantity
from customers C
inner join 
orders O
on C.customer_id = O.customer_id
where O.quantity > 1;

--8)Rerive all orders where the total amount exceeds 20$;

Select * from orders
where total_amount > 20;

--9) List all genres available in the Books table:
Select Distinct genre
from books;

--10) Find the book with the lowest stock

Select * from books
order by stock 
limit 5;

--11) Calculate the toatal revenue generated from all orders;
Select sum(total_amount) as total_revenue
from orders;

--Advance Querys

--1) Retrieve thr total number of books sold for each genre:

Select B.genre, sum(O.quantity) as total_books_Sold
from books B
inner join orders O
on B.book_id = O.book_id
group by B.genre;

--2) Find the average price of books in the " Fantasy" genre:		

Select avg(price) as Average_price
from books
where genre = 'Fantasy'
;

--3) List customers who have placed at least 2 orders:

Select o.customer_id, c.name, count(o.order_id) as order_count
from orders o
join customers c
on o.customer_id = c.customer_id
group by o.customer_id, c.name
having count(order_id) >= 2;

--4) Find the most frequently orderd book:

select o.book_id, b.title, count(o.order_id) as frequently_order
from orders o
join books b
on b.book_id = o.book_id
group by o.book_id, b.title
order by frequently_order desc
limit 1;

--5) Show the top 3 most expensive books of 'Fantasy' genre:

Select *
from books
where genre  = 'Fantasy'
order by price desc
limit 3;

--6) Retrive the total quantity of books sold by each author:

Select b. author, sum(o.quantity) as total_sold
from orders o
join books b
on b.book_id = o.book_id
group by b.author;

--7)List the cities where customers who spent over $300 are located:

Select  distinct c.city,
	   o.total_amount
from customers c
join orders o
on o.customer_id = c.customer_id
where  o.total_amount > 300;

--8) Find  the customer who spent the most on orders:

Select c.name, sum(o.total_amount) as total_amount_spent
from customers c
join orders o
on o.customer_id = c.customer_id
group by c.name
order by total_amount_spent desc
limit 1
;

--9)Calculate the stock remaining ater fulfilling all orders;

Select b.book_id, b.book_id,b.stock , coalesce (sum(o.quantity),0) as reamaing_quantity,
b. stock- coalesce(sum(o.quantity),0) as reaminging_quantity
from books b
left join orders o
on b.book_id = o.book_id
group by b.book_id
order by b.book_id;
group by b.book_id