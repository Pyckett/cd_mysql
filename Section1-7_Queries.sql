use classicmodels;

# Section 1
SELECT * FROM employees;

SELECT 1 + 1;

# Section 2
SELECT * FROM employees
ORDER BY employeeNumber;

# Section 3
SELECT firstName FROM employees
WHERE employeeNumber = 1002;

SELECT DISTINCT lastname
FROM employees
ORDER BY lastname;
    
SELECT 1 AND 1;

SELECT 1 OR 1, 1 OR 0, 0 OR 1;

SELECT 1 IN (1,2,3);

SELECT 1 NOT IN (1,2,3);

SELECT 15 BETWEEN 10 AND 20;

SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName LIKE '%on';

SELECT customerNumber, customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;

SELECT customerName, country, salesrepemployeenumber
FROM customers
WHERE salesrepemployeenumber IS NULL
ORDER BY customerName;

# Section 4
SELECT CONCAT_WS(', ', lastName, firstname) AS `Full name`
FROM employees;
   
SELECT 
    productCode, 
    productName, 
    textDescription
FROM
    products t1
INNER JOIN productlines t2 
    ON t1.productline = t2.productline;
    
SELECT 
    customers.customerNumber, 
    customerName, 
    orderNumber, 
    status
FROM
    customers
LEFT JOIN orders ON 
    orders.customerNumber = customers.customerNumber;
    
SELECT 
    employeeNumber, 
    customerNumber
FROM
    customers
RIGHT JOIN employees 
    ON salesRepEmployeeNumber = employeeNumber
ORDER BY 
	employeeNumber;

SELECT 
  suit_name, 
  rank_name 
FROM 
  suits CROSS 
  JOIN ranks 
ORDER BY 
  suit_name, 
  rank_name;

SELECT 
    CONCAT(m.lastName, ', ', m.firstName) AS Manager,
    CONCAT(e.lastName, ', ', e.firstName) AS 'Direct report'
FROM
    employees e
INNER JOIN employees m ON 
    m.employeeNumber = e.reportsTo
ORDER BY 
    Manager;
    
# Section 5
SELECT 
  status 
FROM 
  orders 
GROUP BY 
  status;
  
SELECT 
  ordernumber, 
  SUM(quantityOrdered) AS itemsCount, 
  SUM(priceeach * quantityOrdered) AS total 
FROM 
  orderdetails 
GROUP BY 
  ordernumber;
  
SELECT product_name, COUNT(id)
FROM sales
GROUP BY product_name;

SELECT
    productLine,
    YEAR(orderDate) orderYear,
    SUM(quantityOrdered * priceEach) orderValue
FROM
    orderDetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productLine ,
    YEAR(orderDate);

SELECT 
    id, 
    SUM(sale_amount) totalOrderValue
FROM
    sales
GROUP BY 
    id WITH ROLLUP;

# Section 6
SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM
    payments
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            payments);
    
SELECT 
    productCode, 
    ROUND(SUM(quantityOrdered * priceEach)) sales
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
WHERE
    YEAR(shippedDate) = 2003
GROUP BY productCode
ORDER BY sales DESC
LIMIT 5;

SELECT 
    customerNumber, 
    customerName
FROM
    customers c
WHERE
    EXISTS( 
        SELECT 
            1 
        FROM 
            orders o 
        WHERE 
            o.customerNumber = c.customerNumber
    )
ORDER BY customerName;

# Section 7
SELECT 
    firstName, 
    lastName
FROM
    employees 
UNION 
SELECT 
    contactFirstName, 
    contactLastName
FROM
    customers;
    
SELECT firstName
FROM employees
EXCEPT
SELECT contactFirstName
FROM customers;

SELECT 
    firstName
FROM
    employees 
INTERSECT
SELECT 
    contactFirstname
FROM
    customers;