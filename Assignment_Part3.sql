
#Q1)

DELIMITER $$
Create procedure order_status( IN t_year INT, IN t_month INT )

BEGIN 
select orderNumber,orderdate,status
from orders
where year(orderDate) = t_year
AND
month(orderDate) = t_month;
END $$

DELIMITER ;

call order_status(2005, 4);

#Q2)

DELIMITER $$
CREATE PROCEDURE cancelled_order( )
	BEGIN
		DROP TABLE IF EXISTS cancellation ;
		CREATE TABLE cancellation
			(
             id int primary key auto_increment,
             customerNumber int,
             orderNumber int,
             comments text,
             FOREIGN KEY (customerNumber)
				REFERENCES customers(customerNumber)
					ON DELETE CASCADE,
             FOREIGN KEY (orderNumber)
				REFERENCES orders(orderNumber)
					ON DELETE CASCADE
			 );
			 INSERT INTO cancellation ( customerNumber, orderNumber, comments)
			                   SELECT   customerNumber, orderNumber, comments
									FROM orders
										WHERE status = 'Cancelled';
			 SELECT *
				FROM cancellation;
		END $$
DELIMITER ;

CALL cancelled_order();

#Q3) A)

SELECT * ,
CASE
  WHEN AMOUNT<25000 THEN 'SILVER'
  WHEN AMOUNT BETWEEN 25000 AND 50000 THEN 'GOLD'
  WHEN AMOUNT >50000 THEN 'PLATINUM'
 END AS STATUS
 FROM payments ;
 

 DELIMITER $$
 CREATE PROCEDURE C_STATUS ( customerNumber int)
 begin

 SELECT CASE
  WHEN AMOUNT<25000 THEN 'SILVER'
  WHEN AMOUNT BETWEEN 25000 AND 50000 THEN 'GOLD'
  WHEN AMOUNT >50000 THEN 'PLATINUM'
 END AS STATUS
 FROM payments ;

 end $$
 DELIMITER ;
 
 CALL C_STATUS(103);
 
#Q3) B)

SELECT* FROM customers;
SELECT* FROM ORDERS;

SELECT c.customernumber, c.customerName , o.status 
from customers c LEFT JOIN orders o
using (customerNumber);

#Q4)


#Q5)
SELECT FNAME,salary ,
DENSE_RANK () OVER(ORDER BY SALARY DESC) AS RANK_NO
FROM EMPLOYEE;

#Q6)
 select *,
dense_rank () OVER (order by salary desc) as Rank_No
from employee;
 
 





