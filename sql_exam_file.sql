/*  Module End Exam - SQL */
----------------------------------------------------------------------------------------
-- Q 1]
USE new_data;
SELECT * FROM employee;
-- i. Alter the table to change the datatype of empID from int to varchar2(10)
ALTER TABLE employee MODIFY EmpID VARCHAR(10);

-- ii. Select the data from the table grouped by address and blood group.
SELECT EmpAddress, Blood_Group, COUNT(*) AS TotalCount
FROM employee
GROUP BY EmpAddress, Blood_Group;

-- iii. Display the data of employee no 2 and 3.
SELECT * FROM employee WHERE EmpID IN (2, 3);

-- iv. Delete the record of employee no 1.
DELETE FROM employee 
WHERE EmpID = 1;
--------------------------------------------------------------------------------------------------------
-- Q 2]
-- i. To select the appointments with the patient dated 20/2/2022
SELECT *
FROM Appointments
WHERE date =  '2022-02-20';
-- ii. To find the appointment time and patient name of all appointments for doctor Akash on April-14-2021
SELECT A.time, P.name
FROM Appointments A
INNER JOIN Patient P ON A.PID = P.PID
INNER JOIN Doctor D ON A.SID = D.SID
WHERE D.name = 'Akash' AND A.date =  '2021-04-14';
---------------------------------------------------------------------------------------------------------------
-- Q 3]
/* To find the orders where the order amount exists between 500 and 2000, 
and return the ord_no, purch_amt, cust_name, and city */
SELECT * FROM orders;
SELECT * FROM customer;
SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM orders o
INNER JOIN customer c ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000;
----------------------------------------------------------------------------------------------------------------------------
-- Q 4]
-- i. Create a view for those salespeople who belong to the city of New York
SELECT * FROM salesman;
CREATE VIEW Salespeople_NewYork AS
SELECT *
FROM salesman
WHERE city = 'New York';
SELECT * FROM Salespeople_NewYork;

-- ii. Return salesperson ID, name, and city
SELECT salesman_id, name, city
FROM salesman;

-- iii. Create a view to find all the salesmen who have the commission = 0.15. Return all the fields of the salesman
CREATE VIEW Salesmen_Commission_015 AS
SELECT *
FROM salesman
WHERE commission >= 0.15 AND commission <= 0.1500001;

SELECT * FROM Salesmen_Commission_015;

-- iv. Create a view to count the number of salespeople in each city. Return city, number of salespersons
CREATE VIEW Salespeople_Count_By_City AS
SELECT city, COUNT(*) AS No_of_Salespeople
FROM salesman
GROUP BY city;
SELECT * FROM Salespeople_Count_By_City;
----------------------------------------------------------------------------------------------------------------------
-- Q 5]
-- i. Select the appointments with the customer dated 20/2/2022
SELECT *
FROM Appointments
WHERE date =  '2022-02-20';

-- ii. Find the appointment time and client name of all appointments for employee member Joy on Dec-14-2021
SELECT A.time, C.name
FROM Appointments A
INNER JOIN Customer C ON A.CID = C.CID
INNER JOIN Employee E ON A.SID = E.SID
WHERE E.name = 'Joy' AND A.date = '2021-12-14';
-----------------------------------------------------------------------------------------------------------------------
-- Q 6]
-- i. To display empid, empname, and deptmanager
SELECT e.empid, e.empname, d.deptmanager
FROM Employee e
INNER JOIN Department d ON e.deptid = d.deptid;

-- ii. To display empid and salary
SELECT i.empid, i.salary
FROM Income i;

-- iii. To run a left join on employee and department
SELECT e.empid, e.empname, d.deptmanager
FROM Employee e
LEFT JOIN Department d ON e.deptid = d.deptid;

-- iv. To run a right join on employee and salary
SELECT e.empid, i.salary
FROM Employee e
RIGHT JOIN Income i ON e.empid = i.empid;

-- v. To run a cross join on all three tables
SELECT e.empid, e.empname, e.empaddress, e.emp_designation, e.deptid,
       d.deptid, d.deptname, d.deptmanager,
       i.empid, i.salary
FROM Employee e
CROSS JOIN Department d
CROSS JOIN Income i;
------------------------------------------------------------------------------------------------------------
-- Q 7]
-- a. Create a table customer (columns: customerid, customer_name, customer_address)

CREATE TABLE customer (
  customerid INT,
  customer_name VARCHAR(100),
  customer_address VARCHAR(200)
);

-- b. Alter the above table to add another column customer_contactnumber
ALTER TABLE customer ADD customer_contactnumber VARCHAR(20);

-- c. Insert a record in the table
INSERT INTO customer 
VALUES (1, 'John', '123 Main Street', '123-456-7890');

-- d. Delete a record from the above table where customerid = 1
DELETE FROM customer WHERE customerid = 1;

-- e. Update the above table to change customer_name as 'Rajesh' where customerid = 1:
UPDATE customer SET customer_name = 'Rajesh' WHERE customerid = '1';
------------------------------------------------------------------------------------------------------------------------
-- Q 8]
-- i. Write a SQL query to display sid, sname, books_issued, books_returned
SELECT s.sid, s.sname, l.books_issued, l.books_returned
FROM Student s
LEFT JOIN Library l ON s.sid = l.sid;

-- ii. Write a SQL query to display sname, grade
SELECT s.sname, m.grade
FROM Student s
INNER JOIN Marks m ON s.sid = m.sid;

-- iii. Write a SQL query to run a left join on student and library
SELECT s.sid, s.sname, l.books_issued, l.books_returned
FROM Student s
LEFT JOIN Library l ON s.sid = l.sid;

-- iv. Write a SQL query to run a right join on library and marks
SELECT l.sid, l.books_issued, l.books_returned, m.grade
FROM Library l
RIGHT JOIN Marks m ON l.sid = m.sid;

-- v. Write a PL/SQL query to run a full join on all three tables

SELECT s.sid, s.sname, l.books_issued, l.books_returned, m.grade
FROM Student s
LEFT JOIN Library l ON s.sid = l.sid
LEFT JOIN Marks m ON s.sid = m.sid
UNION
SELECT s.sid, s.sname, l.books_issued, l.books_returned, m.grade
FROM Library l
LEFT JOIN Student s ON l.sid = s.sid
LEFT JOIN Marks m ON l.sid = m.sid;

--------------------------------------------------------------------------------------------------------------------
-- Q 9] Explain group by clauses in plsql with the help of example
/* 
GROUP BY clause is used to group rows based on one or more columns in a result set. 
It allows you to perform aggregate functions on the grouped data, such as calculating 
sums, counts, averages, or finding the maximum or minimum values within each group.

consider an example:
Suppose we have a table named "orders" with the columns: 
order_id, customer_id, order_date, and order_amount. 
We want to calculate the total order amount for each customer.   */
select * from orders;
SELECT salesman_id, SUM(purch_amt) AS total_amount
FROM orders
GROUP BY salesman_id;
/*
The query selects the salesman_id column and applies the SUM function to the purch_amt column.
The result is grouped by the salesman_id column using the GROUP BY clause.
The SUM function calculates the total purches amount for each salesman.
The alias "total_amount" is used to label the calculated sum as "total_amount" in the result set.

Output look like this:
salesman_id   total_amount
5002	      1099
5005	      270.6499938964844
5001	      65.26000213623047
5003	      110.5
*/
----------------------------------------------------------------------------------------------------------------
-- Q 10] Explain subqueries in pl/sql with the help of an example.
/* subquery is a query nested within another query. 
It allows you to use the result of one query as a part of another query. 
The subquery is executed first, and its result is then used by the outer query to perform further processing.

Suppose we have two tables named "orders" and "customers". The "orders" table contains information 
about orders such as order_id, customer_id, and purch_amt. The "customer" table contains 
information about customers such as customer_id, custr_name, and city.

We want to find the total purches amount for all customers from a specific city.
*/
SELECT * FROM orders;
SELECT * FROM customer;
SELECT cust_name, city,
       (SELECT SUM(purch_amt) FROM orders WHERE customer_id = customer.customer_id) AS total_amount
FROM customer
WHERE city = 'New York';
/*
The outer query selects the customer_name and city columns from the "customer" table
The subquery (SELECT SUM(purch_amt) FROM orders WHERE customer_id = customers.customer_id) 
is used within the outer query to calculate the total purches amount for each customer.
The subquery is correlated by the condition WHERE customer_id = customer.customer_id, 
which links the subquery to the customer_id column in the outer query.
The result of the subquery, which is the sum of purch_amt for each customer, 
is aliased as "total_amount" in the result set of the outer query.

output of the query
cust_name       city        total_amount
Nick Rimando	New York	65.26000213623047
Brad Davis	    New York	
*/
--- Thank you---












