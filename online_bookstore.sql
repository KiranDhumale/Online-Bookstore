create database online_bookstore;
use online_bookstore;

select * from books;
select * from customers c;
select * from orders o;

-- 1) Retrieve all the books of Fiction Genre.
select * from books b 
where b.genre = 'Fiction';

-- 2) Find the book published after the year 1950.
select * from books b 
where b.published_year > 1950;

-- 3) List all the customers from Canada and Japan.
select * from customers c 
where c.country in ('Canada', 'Japan');

-- 4) Show order placed in November 2023.
select * from orders o 
where o.order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books.
select SUM(b.stock) as total_stock 
from books b;

-- 6) Find the details of most expensive book.
select * from books b where b.price = (select MAX(b.price) from books b);

select * from books b
order by b.price desc 
limit 1;

-- 7) Show all the customers ordered more than 1 book.
select o.customer_id, c.name, c.country, o.quantity 
from orders o
left join customers c 
on o.customer_id = c.customer_id
where o.quantity > 5;

-- 8) List all the genre available in book store.
select distinct (b.genre) 
from books b;

-- 9) Find the book with lowest stock.
select * from books b 
order by b.stock asc;

-- 10) Calculate total revenue generated from all orders.
select SUM(o.total_amount) as total_revenue
from orders o; 

-- ADVANCED QUERIES

select * from books b;
select * from customers c;
select * from orders o;

-- 1) Retrieve the total number of book sold for each genre.
select b.genre, SUM(o.quantity) as total_books_sold
from orders o 
right join books b 
on o.book_id = b.book_id
group by b.genre
order by total_books_sold desc;

-- 2) Find the average price of books in 'fantasy' genre.
select b.genre, round(AVG(b.price),2) as average_price_of_fantasy_genre 
from books b
where b.genre  = 'Fantasy'
group by b.genre; 

-- 3) List the customers who placed atleast 5 order.
select c.customer_id, c.name, c.email, c.phone, c.city, c.country, o.quantity, o.total_amount 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
where o.quantity >= 5;

-- 4) Find most frequently ordered book.
select b.book_id, b.title, b.author, b.genre, COUNT(o.book_id) as frequently_ordered
from orders o 
join books b 
on o.book_id = b.book_id 
group by b.book_id, b.title, b.author, b.genre 
having frequently_ordered > 1
order by frequently_ordered desc;

-- 5) Show top 3 most expensive books from 'Fantasy' genre.
select *
from books b 
where b.genre = 'Fantasy'
order by b.price desc 
limit 3;

-- 6) Retrieve the total quantity of books sold by each author.
select b.author, SUM(o.quantity) as total_books_sold
from books b 
right join orders o 
on b.book_id = o.book_id 
group by b.author; 

-- 7) List the cities where customers who spent less than $30 located
select c.city, SUM(o.total_amount) as total_spent_amount 
from orders o 
join customers c 
on o.customer_id = c.customer_id 
where o.total_amount < 30
group by c.city;

-- 8) Find the customer who spend most on orders.
select o.customer_id, c.name , SUM(o.total_amount) as highest_spend_on_order
from customers c 
join orders o 
on c.customer_id = o.customer_id 
group by c.customer_id,c.name
order by highest_spend_on_order desc
limit 1;

-- 9) Calculate remaining stock after fulfilling all orders.
select b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) as ordered_quantity, 
		b.stock - COALESCE(SUM(o.quantity),0) as remaining_stock
from books b 
left join orders o 
on b.book_id = o.book_id
group by b.book_id, b.title, b.stock ; 



