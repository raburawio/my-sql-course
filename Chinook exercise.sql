SELECT
    c.Address
    ,c.City
FROM
    Customer c

SELECT
    e.EmployeeId
    ,e.FirstName
    ,e.LastName
FROM
    Employee e

SELECT
    i.InvoiceId
    ,i.Total
FROM
    Invoice i

-- List all customers. Show only the CustomerId, FirstName and LastName columns
SELECT * FROM Customer c

-- List customers in the United Kingdom  
SELECT
    c.CustomerId
    ,c.FirstName 
    ,c.LastName
FROM
    Customer c
WHERE c.Country = 'United Kingdom'

-- List customers whose first names begins with an A.
-- Hint: use LIKE and the % wildcard
SELECT * FROM Customer c
where c.FirstName like 'A%'

-- List Customers with an apple email address
SELECT * FROM Customer c
where c.Email like '%@apple%'

-- Which customers have the initials LK?
SELECT * FROM Customer c
where c.FirstName like 'L%'
and c.LastName like 'K%'
----------------------------------------------------------------------------------------------

-- Which are the corporate customers i.e. those with a value, not NULL, in the Company column?
SELECT *
 from  Customer c 
 WHERE c.Company is not NULL;

-- How many customers are in each country.  Order by the most popular country first.
 SELECT *
 FROM  Customer c 
GROUP BY c.Country
ORDER BY c.Country DESC;

-- When was the oldest employee born?  Who is that?
SELECT TOP 3
E.FirstName
,E.LastName
,E.BirthDate
from Employee e 
order by E.BirthDate ASC;

select min(e.birthDate)
from e.Employee;

-- List the 10 latest invoices. Include the InvoiceId, InvoiceDate and Total

-- Then  also include the customer full name (first and last name together)

-- List the customers who have spent more than £45

 SELECT c.FirstName
 ,c.LastName
 ,sum(i.Total) as InvoiceTotal
 FROM  Invoice i 
JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY c.FirstName
,c.LastName
HAVING SUM(i.Total) > 45;

 --implement as a table subquery

select * 
from Customer 
where CustomerID IN
(SELECT 
i.CustomerId 
FROM Invoice i 
GROUP BY i.CustomerId
HAVING SUM(i.Total) > 45)

-- implement as a CTE
;
with cte AS
(SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45 )
select
    c.FirstName
    ,c.LastName
    ,cte.InvoiceTotal
from  Customer c JOIN cte on c.CustomerId = cte.CustomerId
 
--implement as temporary tables
 
SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
INTO #TopCust
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45
 
select * from #TopCust 
JOIN Customer c ON #topCust.CustomerId = c.CustomerId

-- List the City, CustomerId and LastName of all customers in Paris and London,
-- and the Total of their invoices
 


