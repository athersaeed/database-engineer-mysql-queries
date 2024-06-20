-- FILTERING DATA  
CREATE DATABASE IF NOT EXISTS Lucky_Shrub;
USE Lucky_Shrub;
-- Task 1: Write a SQL statement to print all records of orders where the cost is $250 or less. The expected output result should be the same as the following screenshot (assuming that you have populated the Orders table with the same data set)
SELECT * FROM Orders WHERE Cost <= 250;
-- Task 2: Write a SQL statement to print all records of orders where the cost is between $50 and $750. The expected output result should be the same as the following screenshot (assuming that you have populated the orders table with the same data set)
SELECT * FROM Orders WHERE Cost > 50 AND Cost < 750;
-- Task 3: Write a SQL statement to print all records of orders that have been placed by the client with the id of Cl3 and where the cost of the order is more than $100. The expected output result should be the same as the following screenshot (assuming that you have populated the Orders table with the same data set)
SELECT * FROM Orders WHERE ClientID = "Cl3" and Cost > 100; 
-- Task 4: Write a SQL statement to print all records of orders that have a product id of p1 or p2 and the order quantity is more than 2. The expected output result should be the same as the following screenshot (assuming that you have populated the Orders table with the same data set)
SELECT * FROM Orders WHERE ProductID = "P1" OR ProductID = "P2" AND Quantity > 2;

-- READING EXERCISE FILTERING DATA
USE luckyshrub_db;
-- Task 1: Use the AND operator to find employees who earn an annual salary of $50,000 or more attached to the Marketing department.
SELECT * FROM employees WHERE AnnualSalary >= 50000 AND Department = 'Marketing';
-- Task 2: Use the NOT operator to find employees not earning over $50,000 across all departments.
SELECT * FROM employees WHERE NOT AnnualSalary > 50000;
-- Task 3: Use the IN operator to find Marketing, Finance, and Legal employees whose annual salary is below $50,000.
SELECT * FROM employees WHERE AnnualSalary < 50000 AND Department IN('Marketing', 'Finance', 'Legal');
-- Task 4: Use the BETWEEN operator to find employees who earn annual salaries between $10,000 and $50,000.
SELECT * FROM employees WHERE AnnualSalary BETWEEN 10000 AND 50000; 
-- Task 5: Use the LIKE operator to find employees whose names start with ‘S’ and are at least 4 characters in length.
SELECT * FROM employees WHERE EmployeeName LIKE 'S___%';




-- JOINING TABLES
USE little_lemon;
-- Task 1: Little Lemon want a list of all customers who have made bookings. Write an INNER JOIN SQL statement to combine the full name and the phone number of each customer from the Customers table with the related booking date and 'number of guests' from the Bookings table. 
SELECT Customers.FullName, Customers.PhoneNumber, Bookings.BookingDate, Bookings.NumberOfGuests 
FROM Customers INNER JOIN Bookings 
ON Customers.CustomerID = Bookings.CustomerID;
-- Task 2: Little Lemon want to view information about all existing customers with bookings that have been made so far. This data must include customers who haven’t made any booking yet. 
SELECT Customers.CustomerID, Bookings.BookingID 
FROM Customers LEFT JOIN Bookings 
ON Customers.CustomerID = Bookings.CustomerID;





-- Grouping data
USE luckyshrub_db;
-- Task 1: Write a SQL SELECT statement to group all records that have the same order date.
SELECT OrderDate FROM Orders GROUP BY OrderDate;
-- Task 2: Write a SQL SELECT statement to retrieve the number of orders placed on the same day.
SELECT OrderDate,COUNT(OrderID) FROM Orders GROUP BY OrderDate;
-- Task 3: Write a SQL SELECT statement to retrieve the total order quantities placed by each department.
SELECT Department, SUM(OrderQty) FROM Orders GROUP BY Department;
-- Task 4: Write a SQL SELECT statement to retrieve the number of orders placed on the same day between the following dates: 1st June 2022 and 30th June 2022.
SELECT OrderDate,COUNT(OrderID) FROM Orders GROUP BY OrderDate HAVING OrderDate BETWEEN '2022-06-01' AND '2022-06-30';






-- MySQL REPLACE statement
USE Lucky_Shrub;
-- Task 1: Write a SQL REPLACE statement that inserts two new orders with the following details:
REPLACE INTO Orders (OrderID, ClientID, ProductID, Quantity, Cost) VALUES (9, "Cl1", "P1", 10, 5000), (10, "Cl2", "P2", 5, 100);
-- Task 2: Lucky Shrub have noticed that the cost of order number 9 is $5000. This is a mistake. The order must cost $500. You must help them to change it to $500 by writing a relevant REPLACE statement. 
REPLACE INTO Orders SET OrderID = 9, ClientID = "Cl1", ProductID = "P1", Quantity = 10, Cost = 500;

-- READING EXERCISE REPLACE INTO statement
USE little_lemon; 
-- Task 1: Use the REPLACE statement to insert a new data record with the following details. 
REPLACE INTO Starters (StarterName, Cost, StarterType) VALUES ("Cheese bread ", 9.50, "Indian");
-- Task 2: Use the REPLACE statement to change the cost of the Cheese bread from $9.50 to $9.75.
REPLACE INTO Starters (StarterName, Cost, StarterType) VALUES ("Cheese bread", 9.75, "Indian");






-- Working with constraints
USE Mangata_Gallo; 
-- Task 1: Create the Clients table with the following columns and constraints.
CREATE TABLE Clients (ClientID INT PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);
-- Task 2: Create the Items table with the following attributes and constraints:
CREATE TABLE Items (ItemID INT PRIMARY KEY, ItemName VARCHAR(100) NOT NULL, Price DECIMAL(5,2) NOT NULL);
-- Task 3: Create the Orders table with the following constraints.
CREATE TABLE Orders ( 
OrderID INT PRIMARY KEY,  
ItemID INT NOT NULL,   
ClientID INT NOT NULL,   
Quantity INT NOT NULL CHECK (Quantity < 4),  
Cost DECIMAL(6,2) NOT NULL,  
FOREIGN KEY (ClientID) REFERENCES Clients (ClientID), 
FOREIGN KEY (ItemID) REFERENCES Items (ItemID) 
);

-- Reading exercise: MySQL constraints
USE Mangata_Gallo;
-- Task 1:  Create the Staff table with the following PRIMARY KEY and NOT NULL constraints:
CREATE TABLE Staff (StaffID INT NOT NULL PRIMARY KEY, PhoneNumber INT NOT NULL UNIQUE, FullName VARCHAR(100) NOT NULL); 
SHOW COLUMNS FROM Staff;
-- Task 2: Create the 'ContractInfo' table with the following key and domain constraints:
CREATE TABLE ContractInfo (ContractID INT NOT NULL PRIMARY KEY, StaffID INT NOT NULL, Salary Decimal(7, 2) NOT NULL, Location VARCHAR(50) NOT NULL DEFAULT "Texas", StaffType VARCHAR(20) NOT NULL CHECK (StaffType = "Junior" OR StaffType = "Senior"));
-- Task 3: Create a foreign key that links the Staff table with the ContractInfo table. In this example, you need to apply the referential integrity rule as follows:
ALTER TABLE ContractInfo 
ADD CONSTRAINT FK_StaffID_ContractInfo
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);





-- Exercise: Changing table structure
 USE Mangata_Gallo;
-- Task 1: Write a SQL statement that creates the Staff table with the following columns.
CREATE TABLE Staff (StaffID INT, FullName VARCHAR(100), PhoneNumber VARCHAR(10));
-- Task 2: Write a SQL statement to apply the following constraints to the Staff table:
ALTER TABLE Staff MODIFY StaffID INT PRIMARY KEY, MODIFY FullName VARCHAR(100) NOT NULL, MODIFY PhoneNumber INT NOT NULL; 
-- Task 3: Write a SQL statement that adds a new column called 'Role' to the Staff table with the following constraints:
ALTER TABLE Staff ADD COLUMN Role VARCHAR(50) NOT NULL;
-- Task 4: Write a SQL statement that drops the Phone Number column from the 'Staff' table.
ALTER TABLE Staff DROP COLUMN PhoneNumber;



-- Reading exercise: ALTER TABLE statement
USE little_lemon;
-- Task 1: Use the ALTER TABLE statement with MODIFY command to make the OrderID the primary key of the 'FoodOrders' table.
ALTER TABLE FoodOrders MODIFY OrderID INT PRIMARY KEY;
-- Task 2: Apply the NOT NULL constraint to the quantity and cost columns.
ALTER TABLE FoodOrders, MODIFY Quantity INT NOT NULL, MODIFY Cost decimal(4,2) NOT NULL;
-- Task 3: Create two new columns, OrderDate with a DATE datatype and CustomerID with an INT datatype. Declare both must as NOT NULL. Declare the CustomerID as a foreign key in the FoodOrders table to reference the CustomerID column existing in the Customers table.
ALTER TABLE FoodOrders ADD COLUMN OrderDate DATE NOT NULL, ADD COLUMN CustomerID INT NOT NULL, ADD FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID);
-- Task 4: Use the DROP command with ALTER statement to delete the OrderDate column from the 'FoodOrder' table. 
ALTER TABLE FoodOrders DROP COLUMN OrderDate;
-- Task 5: Use the CHANGE command with ALTER statement to rename the column Order_Status in the OrderStatus table to DeliveryStatus. 
ALTER TABLE OrderStatus CHANGE Order_status DeliveryStatus VARCHAR(15);
-- Task 6: Use the RENAME command with ALTER statement to change the table name from OrderStatus to OrderDeliveryStatus.
ALTER TABLE OrderStatus RENAME OrderDeliveryStatus;







-- Working with subqueries
USE littlelemon_db;
-- Task 1: Write a SQL SELECT query to find all bookings that are due after the booking of the guest ‘Vanessa McCarthy’.
SELECT * FROM Bookings WHERE BookingSlot > (SELECT BookingSlot FROM Bookings WHERE GuestFirstName = 'Vanessa' AND GuestLastName = 'McCarthy');
-- Task 2: Write a SQL SELECT query to find the menu items that are more expensive than all the 'Starters' and 'Desserts' menu item types.
SELECT * FROM MenuItems WHERE Price > ALL (SELECT Price FROM MenuItems WHERE Type IN ('Starters', 'Desserts')); 
-- Task 3: Write a SQL SELECT query to find the menu items that costs the same as the starter menu items that are Italian cuisine.
SELECT * FROM MenuItems WHERE Price = (SELECT Price FROM Menus, MenuItems WHERE Menus.ItemID = MenuItems.ItemID AND MenuItems.Type = 'Starters' AND Cuisine = 'Italian'); 
-- Task 4: Write a SQL SELECT query to find the menu items that were not ordered by the guests who placed bookings.
SELECT * FROM MenuItems 
WHERE NOT EXISTS (SELECT * FROM TableOrders, Menus WHERE TableOrders.MenuID = Menus.MenuID AND Menus.ItemID = MenuItems.ItemID); 

-- Reading exercise: Practicing subqueries
USE littlelemon_db;
-- Task 1: Find the minimum and the maximum average prices at which the customers can purchase food and drinks.
SELECT ROUND(MIN(avgPrice),2), ROUND(MAX(avgPrice),2) 
FROM (SELECT Type,AVG(Price) AS avgPrice
FROM MenuItems 
GROUP BY Type) AS aPrice;
-- Task 2: Insert data of menu items with a minimum price based on the 'Type' into the LowCostMenuItems table.
INSERT INTO LowCostMenuItems 
SELECT ItemID,Name,Price 
FROM MenuItems 
WHERE Price =ANY(SELECT MIN(Price) FROM MenuItems GROUP BY Type);
-- Task 3: Delete all the low-cost menu items whose price is more than the minimum price of menu items that have a price between $5 and $10.
DELETE FROM LowCostMenuItems 
WHERE Price > ALL(SELECT MIN(Price) as p 
FROM MenuItems 
GROUP BY Type 
HAVING p BETWEEN 5 AND 10);








-- Views in MySQL
USE Lucky_Shrub; 
-- Task 1: Write a SQL statement to create the OrdersView Virtual table based on the Orders table. The table must include the following columns: Order ID, Quantity and Cost.
CREATE VIEW OrdersView AS SELECT OrderID, Quantity, Cost FROM Orders; 
-- Task 2: Write a SQL statement that utilizes the ‘OrdersView’ virtual table to Update the base Orders table. In the UPDATE TABLE statement, change the cost to 200 where the order id equals 2. 
UPDATE OrdersView SET Cost = 200 WHERE OrderID = 2; 
-- Task 3: Write a SQL statement that changes the name of the ‘OrdersView’ virtual table to ClientsOrdersView.
RENAME TABLE OrdersView TO ClientsOrdersView;
-- Task 4: Write a SQL statement to delete the Orders virtual table.
DROP VIEW ClientsOrdersView; 







-- Exercise: Working with MySQL functions
USE jewelrystore_db;
-- Task 1: Write a SQL SELECT query using appropriate MySQL string functions to list items, quantities and order status in the following format:
SELECT CONCAT(LCASE(Name),'-',Quantity,'-', UCASE(OrderStatus)) 
FROM item,mg_orders 
WHERE item.ItemID = mg_orders.ItemID;
-- Task 2: Write a SQL SELECT query using an appropriate date function and a format string to find the name of the weekday on which M&G’s orders are to be delivered.
SELECT DATE_FORMAT(DeliveryDate,'%W') FROM mg_orders; 
-- Task 3: Write a SQL SELECT query that calculates the cost of handling each order. This should be 5% of the total order cost. Use an appropriate math function to round that value to 2 decimal places.
SELECT OrderID, ROUND((Cost * 5 / 100),2) AS HandlingCost FROM mg_orders; 
-- Task 4: Review the query that you wrote in the second task. Use an appropriate comparison function to filter out the records that do not have a NULL value in the delivery date column.
SELECT DATE_FORMAT(DeliveryDate,'%W') FROM mg_orders WHERE !ISNULL(DeliveryDate);




-- Reading exercise: Practicing with functions
USE jewelrystore_db; 
CREATE TABLE clients 
(ClientID int NOT NULL, 
ClientName varchar(255) DEFAULT NULL, 
Address varchar(255) DEFAULT NULL, 
ContactNo varchar(10) DEFAULT NULL, 
PRIMARY KEY (ClientID));

CREATE TABLE client_orders 
(OrderID INT NOT NULL, 
ClientID INT DEFAULT NULL, 
ItemID INT DEFAULT NULL, 
Cost INT DEFAULT NULL, 
PRIMARY KEY (OrderID));

INSERT INTO clients VALUES 
(1, 'Kishan Hughes','223 Golden Hills, North Austin, TX','387986345'), 
(2, 'Indira Moncada','119 Silver Street, Bouldin Creek, TX','334567243'), 
(3, 'Mosha Setsile','785 Bronze Lane, East Austin, TX','315642597'), 
(4, 'Laura Mills','908 Diamond Crescent, South Lamar, TX','300842509'), 
(5, 'Henrik Kreida','345, Golden Hills, North Austin, TX','358208983'), 
(6, 'Millicent Blou','812, Diamond Crescent, North Burnet, TX','347898755');

INSERT INTO client_orders VALUES 
(1,1,1,2500), 
(2,2,2,400), 
(3,3,3,350), 
(4,4,4,1250), 
(5,5,5,800), 
(6,6,6,1500), 
(7,2,4,400), 
(8,3,4,1250), 
(9,4,2,400), 
(10,1,3,350); 

-- Task 1: Use the MySQL CEIL function to express the cost after the discount in the form of the smallest integer as follows:
SELECT ClientID, OrderID, CEIL((Cost -(Cost * 5 /100))) AS afterDiscount 
FROM client_orders
WHERE ItemID = 4;
-- Task 2: Format the afterDiscount column value from the earlier result for 5% discount in '#,###,###.##' format rounded to 2 decimal places using the FORMAT function.
SELECT ClientID, OrderID, FORMAT((Cost -(Cost * 5 /100)),2)AS afterDiscount 
FROM client_orders
WHERE ItemID = 4;
-- Task 3: Find the expected delivery dates for their orders. The scheduled delivery date is 30 days after the order date. Use the ADDDATE function.
SELECT ADDDATE(OrderDate,INTERVAL 30 DAY) AS ExpectedDelDate FROM mg_orders;
SELECT ADDDATE(OrderDate,30) AS ExpectedDelDate FROM mg_orders;
-- Task 4: Generate data required for a report with details of all orders that have not yet been delivered. The DeliveryDate column has a NULL value for orders not yet delivered. It would help if you showed a value of 'NOT DELIVERED' instead of showing NULL for orders that are not yet delivered. Use the COALESCE function to do this.
SELECT OrderID, ItemID, Quantity, Cost,  OrderDate,COALESCE (DeliveryDate,'NOT DELIVERED'), OrderStatus FROM mg_orders;
-- Task 5: Generate data required for the report by retrieving a list of M&G orders yet to be delivered. These orders have an 'In Progress' status using the NULLIF function.
SELECT OrderID, NULLIF(OrderStatus,'In Progress') AS status FROM mg_orders;






-- Working with procedures
USE Lucky_Shrub;
-- Task 1: Write a SQL statement that creates a stored procedure called 'GetOrdersData' which retrieves all data from the Orders table.
CREATE PROCEDURE GetOrdersData()
SELECT * FROM Orders;
CALL GetOrdersData();
-- Task 2: Write a SQL statement that creates a stored procedure called “GetListOfOrdersInRange”. The procedure must contain two parameters that determine the range of retrieved data based on the user input of two cost values “MinimumValue” and “MaximumValue”.
CREATE PROCEDURE GetListOfOrdersInRange(MIN INT, MAX INT)
SELECT * FROM Orders WHERE Cost >= MIN AND Cost <= MAX;
CALL GetListOfOrdersInRange (150, 600);






-- MySQL database project
CREATE DATABASE IF NOT EXISTS Little_Lemon1;
USE Little_Lemon1;
CREATE TABLE Customers(CustomerID INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);
REPLACE INTO Customers(CustomerID, FullName, PhoneNumber) VALUES 
(1, "Vanessa McCarthy", 0757536378), 
(2, "Marcos Romero", 0757536379), 
(3, "Hiroki Yamane", 0757536376), 
(4, "Anna Iversen", 0757536375), 
(5, "Diana Pinto", 0757536374),     
(6, "Altay Ayhan", 0757636378),      
(7, "Jane Murphy", 0753536379),      
(8, "Laurina Delgado", 0754536376),      
(9, "Mike Edwards", 0757236375),     
(10, "Karl Pederson", 0757936374);
CREATE TABLE Bookings (BookingID INT, BookingDate DATE,TableNumber INT, NumberOfGuests INT,CustomerID INT); 
INSERT INTO Bookings 
(BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) 
VALUES 
(10, '2021-11-10', 7, 5, 1),  
(11, '2021-11-10', 5, 2, 2),  
(12, '2021-11-10', 3, 2, 4), 
(13, '2021-11-11', 2, 5, 5),  
(14, '2021-11-11', 5, 2, 6),  
(15, '2021-11-11', 3, 2, 7), 
(16, '2021-11-11', 3, 5, 1),  
(17, '2021-11-12', 5, 2, 2),  
(18, '2021-11-12', 3, 2, 4), 
(19, '2021-11-13', 7, 5, 6),  
(20, '2021-11-14', 5, 2, 3),  
(21, '2021-11-14', 3, 2, 4);
CREATE TABLE Courses (CourseName VARCHAR(255) PRIMARY KEY, Cost Decimal(4,2));
INSERT INTO Courses (CourseName, Cost) VALUES 
("Greek salad", 15.50), 
("Bean soup", 12.25), 
("Pizza", 15.00), 
("Carbonara", 12.50), 
("Kabasa", 17.00), 
("Shwarma", 11.30);

-- Task 1: Filter data using the WHERE clause and logical operators.
SELECT * FROM Bookings WHERE BookingDate BETWEEN '2021-11-11' AND '2021-11-13';

-- Task 2: Create a JOIN query.
SELECT Customers.FullName, Bookings.BookingID
FROM Customers INNER JOIN Bookings
ON Customers.CustomerID = Bookings.CustomerID AND Bookings.BookingDate = '2021-11-11';

-- Task 3: Create a GROUP BY query.
SELECT BookingDate, COUNT(BookingDate) FROM Bookings GROUP BY BookingDate;

-- Task 4: Create a REPLACE statement.
REPLACE INTO Courses(CourseName, Cost) VALUES ('Kabasa', 20.00);
SELECT * FROM Courses;

-- Task 5: Create constraints
CREATE TABLE DeliveryAddress
(ID INT PRIMARY KEY, 
Address VARCHAR(255) NOT NULL, 
Type VARCHAR(100) DEFAULT 'Private', 
CustomerID INT NOT NULL, 
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID));

SHOW COLUMNS FROM DeliveryAddress;

-- Task 6: Alter table structure
ALTER TABLE Courses ADD Ingredients VARCHAR (255);
SHOW COLUMNS FROM Courses; 

-- Task 7: Create a subquery
SELECT FULLNAME FROM Customers WHERE (SELECT CustomerID FROM Bookings WHERE Customers.CustomerID = Bookings.CustomerID and BookingDate = '2021-11-11');

-- Task 8 solution: Create a virtual table
CREATE VIEW BookingsView AS SELECT Bookings.BookingID, Bookings.BookingDate, Bookings.NumberOfGuests FROM Bookings WHERE BookingDate < '2021-11-13' AND NumberOfGuests >= 3;
SELECT * FROM BookingsView;

-- Task 9: Create a stored procedure
CREATE PROCEDURE GetBookingsData(InputDate DATE)
SELECT * FROM Bookings WHERE BookingDate = InputDate;

CALL GetBookingsData('2021-11-13');


-- Task 10: Use the String function
-- SELECT CONCAT(LCASE(Name),'-',Quantity,'-', UCASE(OrderStatus)) 
SELECT CONCAT('ID: ', BookingID, ', Date: ', BookingDate, ', Number of guests: ', NumberOfGuests) AS `Booking Details` FROM Bookings;


-- Developing functions in MySQL
CREATE DATABASE Lucky_Shrub_db;
USE Lucky_Shrub_db;
CREATE TABLE Orders (OrderID INT NOT NULL PRIMARY KEY, ClientID VARCHAR(10), ProductID VARCHAR(10), Quantity INT, Cost DECIMAL(6,2), Date DATE);
INSERT INTO Orders(OrderID, ClientID, ProductID , Quantity, Cost, Date) VALUES
(1, "Cl1", "P1", 10, 500, "2020-09-01"),  
(2, "Cl2", "P2", 5, 100, "2020-09-05"),  
(3, "Cl3", "P3", 20, 800, "2020-09-03"),  
(4, "Cl4", "P4", 15, 150, "2020-09-07"),  
(5, "Cl3", "P3", 10, 450, "2020-09-08"),  
(6, "Cl2", "P2", 5, 800, "2020-09-09"),  
(7, "Cl1", "P4", 22, 1200, "2020-09-10"),  
(8, "Cl3", "P1", 15, 150, "2020-09-10"),  
(9, "Cl1", "P1", 10, 500, "2020-09-12"),  
(10, "Cl2", "P2", 5, 100, "2020-09-13"),  
(11, "Cl4", "P5", 5, 100, "2020-09-15"), 
(12, "Cl1", "P1", 10, 500, "2022-09-01"),  
(13, "Cl2", "P2", 5, 100, "2022-09-05"),  
(14, "Cl3", "P3", 20, 800, "2022-09-03"),  
(15, "Cl4", "P4", 15, 150, "2022-09-07"),  
(16, "Cl3", "P3", 10, 450, "2022-09-08"),  
(17, "Cl2", "P2", 5, 800, "2022-09-09"),  
(18, "Cl1", "P4", 22, 1200, "2022-09-10"),  
(19, "Cl3", "P1", 15, 150, "2022-09-10"),  
(20, "Cl1", "P1", 10, 500, "2022-09-12"),  
(21, "Cl2", "P2", 5, 100, "2022-09-13"),   
(22, "Cl2", "P1", 10, 500, "2021-09-01"),  
(23, "Cl2", "P2", 5, 100, "2021-09-05"),  
(24, "Cl3", "P3", 20, 800, "2021-09-03"),  
(25, "Cl4", "P4", 15, 150, "2021-09-07"),  
(26, "Cl1", "P3", 10, 450, "2021-09-08"),  
(27, "Cl2", "P1", 20, 1000, "2022-09-01"),  
(28, "Cl2", "P2", 10, 200, "2022-09-05"),  
(29, "Cl3", "P3", 20, 800, "2021-09-03"),  
(30, "Cl1", "P1", 10, 500, "2022-09-01");

CREATE FUNCTION FindCost(Order_id INT) RETURNS DECIMAL(6,2)
DETERMINISTIC 
RETURN (SELECT COST FROM Orders WHERE OrderID = Order_id);

SELECT FindCost(5);
DROP FUNCTION FindCost;



-- SELECT statement optimization in MySQL

CREATE DATABASE Lucky_Shrub; 
USE Lucky_Shrub;
CREATE TABLE Orders(OrderID INT NOT NULL, ClientID VARCHAR(10) DEFAULT NULL, ProductID VARCHAR(10) DEFAULT NULL, Quantity INT DEFAULT NULL, Cost DECIMAL(6,2) DEFAULT NULL, Date DATE DEFAULT NULL, PRIMARY KEY (OrderID)); 
CREATE TABLE Employees(EmployeeID INT DEFAULT NULL, FullName VARCHAR(100) DEFAULT NULL, Role VARCHAR(50) DEFAULT NULL, Department VARCHAR(255) DEFAULT NULL); 
INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date)  
VALUES  
(1, "Cl1", "P1", 10, 500, "2020-09-01"), 
(2, "Cl2", "P2", 5, 100, "2020-09-05"),  
(3, "Cl3", "P3", 20, 800, "2020-09-03"),  
(4, "Cl4", "P4", 15, 150, "2020-09-07"),  
(5, "Cl3", "P3", 10, 450, "2020-09-08"),  
(6, "Cl2", "P2", 5, 800, "2020-09-09"),  
(7, "Cl1", "P4", 22, 1200, "2020-09-10"),  
(8, "Cl3", "P1", 15, 150, "2020-09-10"),  
(9, "Cl1", "P1", 10, 500, "2020-09-12"),  
(10, "Cl2", "P2", 5, 100, "2020-09-13"),  
(11, "Cl1", "P2", 15, 80, "2020-09-12"), 
(12, "Cl1", "P1", 10, 500, "2022-09-01"),  
(13, "Cl2", "P2", 5, 100, "2022-09-05"),  
(14, "Cl3", "P3", 20, 800, "2022-09-03"),  
(15, "Cl4", "P4", 15, 150, "2022-09-07"),  
(16, "Cl3", "P3", 10, 450, "2022-09-08"),  
(17, "Cl2", "P2", 5, 800, "2022-09-09"),  
(18, "Cl1", "P4", 22, 1200, "2022-09-10"),  
(19, "Cl3", "P1", 15, 150, "2022-09-10"),  
(20, "Cl1", "P1", 10, 500, "2022-09-12"),  
(21, "Cl2", "P2", 5, 100, "2022-09-13"),   
(22, "Cl2", "P1", 10, 500, "2021-09-01"),  
(23, "Cl2", "P2", 5, 100, "2021-09-05"),  
(24, "Cl3", "P3", 20, 800, "2021-09-03"),  
(25, "Cl4", "P4", 15, 150, "2021-09-07"),  
(26, "Cl1", "P3", 10, 450, "2021-09-08"),  
(27, "Cl2", "P1", 20, 1000, "2022-09-01"),  
(28, "Cl2", "P2", 10, 200, "2022-09-05"),  
(29, "Cl3", "P3", 20, 800, "2021-09-03"); 
INSERT INTO Employees (EmployeeID, FullName,  Role, Department)  
VALUES    
(1, "Seamus Hogan", "Manager", "Management"),    
(2, "Thomas Eriksson", "Assistant ", "Sales"),   
(3, "Simon Tolo", "Executive", "Management"),   
(4, "Francesca Soffia", "Assistant  ", "Human Resources"),   
(5, "Emily Sierra", "Accountant", "Finance"),    
(6, "Greta Galkina", "Accountant", "Finance"), 
(7, "Maria Carter", "Executive", "Human Resources"), 
(8, "Rick Griffin", "Manager", "Marketing"); 

-- task 1
SELECT * FROM Orders;
SELECT OrderID, ProductID, Quantity, Date FROM Orders;
-- task 2: creating an index named IdxClientID on the required column of the Orders table. Once you have created the index, run the same SELECT statement as above with the EXPLAIN statement.
CREATE INDEX idxClientID ON Orders(ClientID);
EXPLAIN SELECT * FROM Orders WHERE ClientID = 'Cl1';

-- task 3
ALTER TABLE Employees ADD COLUMN ReverseFullName VARCHAR(255);
UPDATE Employees
SET ReverseFullName = CONCAT(
		SUBSTRING_INDEX(FullName, ' ', -1), ' ', 
        SUBSTRING_INDEX(FullName, ' ', 1)
        );
        
CREATE INDEX IdxReverseFullName ON Employees(ReverseFullName);
SELECT * FROM Employees WHERE ReverseFullName LIKE 'Tolo%';



-- MySQL optimization techniques exercise
CREATE DATABASE IF NOT EXISTS Lucky_Shrub;
USE Lucky_Shrub;
CREATE TABLE IF NOT EXISTS Orders (OrderID INT NOT NULL PRIMARY KEY, ClientID VARCHAR(10), ProductID VARCHAR(10), Quantity INT, Cost DECIMAL(6,2), Date DATE);
CREATE TABLE IF NOT EXISTS Products (ProductID VARCHAR(10), ProductName VARCHAR(100), BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT);
CREATE TABLE IF NOT EXISTS Activity (ActivityID INT PRIMARY KEY, Properties JSON );

INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date) VALUES 
(1, "Cl1", "P1", 10, 500, "2020-09-01" ), 
(2, "Cl2", "P2", 5, 100, "2020-09-05"), 
(3, "Cl3", "P3", 20, 800, "2020-09-03"), 
(4, "Cl4", "P4", 15, 150, "2020-09-07"), 
(5, "Cl3", "P3", 10, 450, "2020-09-08"), 
(6, "Cl2", "P2", 5, 800, "2020-09-09"), 
(7, "Cl1", "P4", 22, 1200, "2020-09-10"), 
(8, "Cl3", "P1", 15, 150, "2020-09-10"), 
(9, "Cl1", "P1", 10, 500, "2020-09-12"), 
(10, "Cl2", "P2", 5, 100, "2020-09-13"), 
(11, "Cl4", "P5", 5, 100, "2020-09-15"),
(12, "Cl1", "P1", 10, 500, "2022-09-01"), 
(13, "Cl2", "P2", 5, 100, "2022-09-05"), 
(14, "Cl3", "P3", 20, 800, "2022-09-03"), 
(15, "Cl4", "P4", 15, 150, "2022-09-07"), 
(16, "Cl3", "P3", 10, 450, "2022-09-08"), 
(17, "Cl2", "P2", 5, 800, "2022-09-09"), 
(18, "Cl1", "P4", 22, 1200, "2022-09-10"), 
(19, "Cl3", "P1", 15, 150, "2022-09-10"), 
(20, "Cl1", "P1", 10, 500, "2022-09-12"), 
(21, "Cl2", "P2", 5, 100, "2022-09-13"),  
(22, "Cl2", "P1", 10, 500, "2021-09-01"), 
(23, "Cl2", "P2", 5, 100, "2021-09-05"), 
(24, "Cl3", "P3", 20, 800, "2021-09-03"), 
(25, "Cl4", "P4", 15, 150, "2021-09-07"), 
(26, "Cl1", "P3", 10, 450, "2021-09-08"), 
(27, "Cl2", "P1", 20, 1000, "2022-09-01"), 
(28, "Cl2", "P2", 10, 200, "2022-09-05"), 
(29, "Cl3", "P3", 20, 800, "2021-09-03"), 
(30, "Cl1", "P1", 10, 500, "2022-09-01"); 

INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfItems) VALUES 
("P1", "Artificial grass bags ", 40, 50, 100), 
("P2", "Wood panels", 15, 20, 250), 
("P3", "Patio slates",  35, 40, 60), 
("P4", "Sycamore trees ", 7, 10, 50), 
("P5", "Trees and Shrubs", 35, 50, 75), 
("P6", "Water fountain", 65, 80, 15);

INSERT INTO Activity(ActivityID, Properties) VALUES  
(1, '{ "ClientID": "Cl1", "ProductID": "P1", "Order": "True" }' ),  
(2, '{ "ClientID": "Cl2", "ProductID": "P4", "Order": "False" }' ),  
(3, '{ "ClientID": "Cl5", "ProductID": "P5", "Order": "True" }' );


-- task 1: optimize this query by recreating it as a common table expression (CTE).

WITH
cl1 AS (SELECT CONCAT("Cl1: ", COUNT(OrderID), "orders") AS "Total number of orders" FROM Orders
WHERE YEAR(Date) = 2022),
cl2 AS (SELECT CONCAT("Cl2: ", COUNT(OrderID), "orders") FROM Orders 
WHERE YEAR(Date) = 2022),
cl3 AS (SELECT CONCAT("Cl3: ", COUNT(OrderID), "orders") FROM Orders
WHERE YEAR(DATE) = 2022)
SELECT * FROM cl1
UNION
SELECT * FROM cl2
UNION
SELECT * FROM CL3;


-- task 2: prepare statement
PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, Cost, Date FROM Orders WHERE ClientID = ? AND YEAR(Date) = ?';


-- task 3: Activity JSON Properties
SELECT Activity.Properties ->>'$.ProductID'
AS ProductID, Products.ProductName, Products.BuyPrice, Products.SellPrice
FROM Products INNER JOIN Activity
ON Products.ProductID = Activity.Properties ->>'$.ProductID'
WHERE Activity.Properties ->>'$.Order' = "True";

SELECT * FROM Activity;




-- Data analysis in MySQL
CREATE DATABASE IF NOT EXISTS Lucky_Shrub_da;
USE Lucky_Shrub_da;
CREATE TABLE Clients (ClientID VARCHAR(10), FullName VARCHAR(100), ContactNumber INT, AddressID INT);   
CREATE TABLE Orders (OrderID INT NOT NULL PRIMARY KEY, ClientID VARCHAR(10),  ProductID VARCHAR(10),  Quantity   INT, Cost DECIMAL(6,2), Date DATE); 
CREATE TABLE Products (ProductID VARCHAR(10), ProductName VARCHAR(100), BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT); 
CREATE TABLE Addresses(AddressID INT PRIMARY KEY, Street VARCHAR(255), County VARCHAR(100)); 
INSERT INTO Clients(ClientID, FullName, ContactNumber, AddressID) VALUES 
("Cl1", "Takashi Ito", 351786345, 1), 
("Cl2", "Jane Murphy", 351567243, 2), 
("Cl3", "Laurina Delgado", 351342597, 3), 
("Cl4", "Benjamin Clauss", 351342509, 4), 
("Cl5", "Altay Ayhan", 351208983, 5), 
("Cl6", "Greta Galkina", 351298755, 6); 
INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date) VALUES 
(1, "Cl1", "P1", 10, 500, "2020-09-01" ), 
(2, "Cl2", "P2", 5, 100, "2020-09-05"), 
(3, "Cl3", "P3", 20, 800, "2020-09-03"), 
(4, "Cl4", "P4", 15, 150, "2020-09-07"), 
(5, "Cl3", "P3", 10, 450, "2020-09-08"), 
(6, "Cl2", "P2", 5, 800, "2020-09-09"), 
(7, "Cl1", "P4", 22, 1200, "2020-09-10"), 
(8, "Cl3", "P1", 15, 150, "2020-09-10"), 
(9, "Cl1", "P1", 10, 500, "2020-09-12"), 
(10, "Cl2", "P2", 5, 100, "2020-09-13"), 
(11, "Cl4", "P5", 5, 100, "2020-09-15"),
(12, "Cl1", "P1", 10, 500, "2022-09-01"), 
(13, "Cl2", "P2", 5, 100, "2022-09-05"), 
(14, "Cl3", "P3", 20, 800, "2022-09-03"), 
(15, "Cl4", "P4", 15, 150, "2022-09-07"), 
(16, "Cl3", "P3", 10, 450, "2022-09-08"), 
(17, "Cl2", "P2", 5, 800, "2022-09-09"), 
(18, "Cl1", "P4", 22, 1200, "2022-09-10"), 
(19, "Cl3", "P1", 15, 150, "2022-09-10"), 
(20, "Cl1", "P1", 10, 500, "2022-09-12"), 
(21, "Cl2", "P2", 5, 100, "2022-09-13"),  
(22, "Cl2", "P1", 10, 500, "2021-09-01"), 
(23, "Cl2", "P2", 5, 100, "2021-09-05"), 
(24, "Cl3", "P3", 20, 800, "2021-09-03"), 
(25, "Cl4", "P4", 15, 150, "2021-09-07"), 
(26, "Cl1", "P3", 10, 450, "2021-09-08"), 
(27, "Cl2", "P1", 20, 1000, "2022-09-01"), 
(28, "Cl2", "P2", 10, 200, "2022-09-05"), 
(29, "Cl3", "P3", 20, 800, "2021-09-03"), 
(30, "Cl1", "P1", 10, 500, "2022-09-01"); 
INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfItems) VALUES 
("P1", "Artificial grass bags ", 40, 50, 100), 
("P2", "Wood panels", 15, 20, 250), 
("P3", "Patio slates",  35, 40, 60), 
("P4", "Sycamore trees ", 7, 10, 50), 
("P5", "Trees and Shrubs", 35, 50, 75), 
("P6", "Water fountain", 65, 80, 15); 
INSERT INTO Addresses (AddressID, Street, County) VALUES 
(1, ",291 Oak Wood Avenue", "Graham County"), 
(2, "724 Greenway Drive", "Pinal County"), 
(3, "102 Sycamore Lane", "Santa Cruz County"), 
(4, "125 Roselawn Close", "Gila County"), 
(5, "831 Beechwood Terrace", "Cochise County"),
(6, "755 Palm Tree Hills", "Mohave County"), 
(7, "751 Waterfall Hills", "Tucson County") , 
(8, "878 Riverside Lane", "Tucson County") , 
(9, "908 Seaview Hills", "Tucson County"), 
(10, "243 Waterview Terrace", "Tucson County"), 
(11, "148 Riverview Lane", "Tucson County"),  
(12, "178 Seaview Avenue", "Tucson County");


-- TASK 1:
SELECT CONCAT(SUM(Quantity), "(2020)") AS "P4 product: Quantity sold" FROM Orders WHERE YEAR(Date) = 2020 AND ProductID = 'P4'
UNION
SELECT CONCAT(SUM(Quantity), "(2021)") FROM Orders WHERE YEAR(Date) = 2021 AND ProductID = 'P4'
UNION
SELECT CONCAT(SUM(Quantity), "(2022)") FROM Orders WHERE YEAR(Date) = 2022 AND ProductID = 'P4';

-- task 2: full outer join
SELECT Clients.ClientID, Clients.ContactNumber, Addresses.Street, Addresses.County, Orders.OrderID, Orders.ProductID, Products.ProductName, Orders.Cost, Orders.Date
From Clients
INNER JOIN Addresses ON Clients.AddressID = Addresses.AddressID
INNER JOIN Orders ON Clients.ClientID = Orders.ClientID
INNER JOIN Products ON Orders.ProductID = Products.ProductID
WHERE YEAR(Orders.Date) = 2021 OR YEAR (Orders.Date) = 2022 ORDER BY Orders.Date;


-- task 3: Function
CREATE FUNCTION FindSoldQuantity (product_id VARCHAR(10), YearInput INT) returns INT DETERMINISTIC RETURN (SELECT SUM(Quantity) FROM Orders WHERE ProductID = product_id AND YEAR (Date) = YearInput);
SELECT FindSoldQuantity ("P3", 2021);


-- final lab
CREATE DATABASE IF NOT EXISTS Lucky_Shrub_final; 
USE Lucky_Shrub_final; 
CREATE TABLE Clients (ClientID VARCHAR(10) primary key, FullName VARCHAR(100), ContactNumber INT, AddressID INT); 
CREATE TABLE Products (ProductID VARCHAR(10) primary key, ProductName VARCHAR(100), BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT);  
Create table Addresses(AddressID INT PRIMARY KEY, Street VARCHAR(255), County VARCHAR(100)); 
CREATE TABLE Employees (EmployeeID INT primary key, FullName VARCHAR(100), JobTitle VARCHAR(50), Department VARCHAR(200), AddressID INT);  
CREATE TABLE Activity( ActivityID INT PRIMARY KEY, Properties JSON ); 
CREATE TABLE Audit(AuditID INT AUTO_INCREMENT PRIMARY KEY, OrderDateTime TIMESTAMP NOT NULL  );  
CREATE TABLE Orders (OrderID INT NOT NULL PRIMARY KEY,  
ClientID VARCHAR(10), ProductID VARCHAR(10), Quantity INT, Cost DECIMAL(6,2), Date DATE,  
FOREIGN KEY (ClientID) REFERENCES Clients(ClientID), 
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)); 
CREATE TABLE Notifications (NotificationID INT AUTO_INCREMENT PRIMARY KEY, Notification VARCHAR(256), DateTime TIMESTAMP NOT NULL); 


INSERT INTO Employees (EmployeeID, FullName, JobTitle, Department, AddressID) VALUES    

(1, "Seamus Hogan", "Manager", "Management", 7),    
  
(2, "Thomas Eriksson", "Assistant ", "Sales", 8),   
  
(3, "Simon Tolo", "Head Chef", "Management", 9),   
  
(4, "Francesca Soffia", "Assistant  ", "Human Resources", 10),   
  
(5, "Emily Sierra", "Accountant", "Finance", 11),    
  
(6, "Greta Galkina", "Accountant", "Finance", 12);  


INSERT INTO Activity(ActivityID, Properties) VALUES   
  
(1, '{ "ClientID": "Cl1", "ProductID": "P1", "Order": "True" }' ),   
  
(2, '{ "ClientID": "Cl2", "ProductID": "P4", "Order": "False" }' ),   
  
(3, '{ "ClientID": "Cl5", "ProductID": "P5", "Order": "True" }' ); 


INSERT INTO Clients(ClientID, FullName, ContactNumber, AddressID) VALUES   
  
("Cl1", "Takashi Ito", 351786345, 1),   
  
("Cl2", "Jane Murphy", 351567243, 2),   
  
("Cl3", "Laurina Delgado", 351342597, 3),   
  
("Cl4", "Benjamin Clauss", 351342509, 4),   
  
("Cl5", "Altay Ayhan", 351208983, 5),   
  
("Cl6", "Greta Galkina", 351298755, 6);     


INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems) VALUES   
  
("P1", "Artificial grass bags ", 40, 50, 100),   
  
("P2", "Wood panels", 15, 20, 250),   
  
("P3", "Patio slates", 35, 40, 60),   
  
("P4", "Sycamore trees ", 7, 10, 50),   
  
("P5", "Trees and Shrubs", 35, 50, 75),   
  
("P6", "Water fountain", 65, 80, 15); 


INSERT INTO Addresses(AddressID, Street, County) VALUES   
  
(1, ",291 Oak Wood Avenue", "Graham County"),   
  
(2, "724 Greenway Drive", "Pinal County"),   
  
(3, "102 Sycamore Lane", "Santa Cruz County"),   
  
(4, "125 Roselawn Close", "Gila County"),   
  
(5, "831 Beechwood Terrace", "Cochise County"),  
  
(6, "755 Palm Tree Hills", "Mohave County"),   
  
(7, "751 Waterfall Hills", "Tuscon County") ,   
  
(8, "878 Riverside Lane", "Tuscon County") ,   
  
(9, "908 Seaview Hills", "Tuscon County"),   
  
(10, "243 Waterview Terrace", "Tuscon County"),   
  
(11, "148 Riverview Lane", "Tuscon County"),    
  
(12, "178 Seaview Avenue", "Tuscon County");  


INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date) VALUES   
  
(1, "Cl1", "P1", 10, 500, "2020-09-01" ),   
  
(2, "Cl2", "P2", 5, 100, "2020-09-05"),   
  
(3, "Cl3", "P3", 20, 800, "2020-09-03"),   
  
(4, "Cl4", "P4", 15, 150, "2020-09-07"),   
  
(5, "Cl3", "P3", 10, 450, "2020-09-08"),   
  
(6, "Cl2", "P2", 5, 800, "2020-09-09"),   
  
(7, "Cl1", "P4", 22, 1200, "2020-09-10"),   
  
(8, "Cl3", "P1", 15, 150, "2020-09-10"),   
  
(9, "Cl1", "P1", 10, 500, "2020-09-12"),   
  
(10, "Cl2", "P2", 5, 100, "2020-09-13"),   
  
(11, "Cl4", "P5", 5, 100, "2020-09-15"),  
  
(12, "Cl1", "P1", 10, 500, "2022-09-01" ),   
  
(13, "Cl2", "P2", 5, 100, "2022-09-05"),   
  
(14, "Cl3", "P3", 20, 800, "2022-09-03"),   
  
(15, "Cl4", "P4", 15, 150, "2022-09-07"),   
  
(16, "Cl3", "P3", 10, 450, "2022-09-08"),   
  
(17, "Cl2", "P2", 5, 800, "2022-09-09"),   
  
(18, "Cl1", "P4", 22, 1200, "2022-09-10"),   
  
(19, "Cl3", "P1", 15, 150, "2022-09-10"),   
  
(20, "Cl1", "P1", 10, 500, "2022-09-12"),   
  
(21, "Cl2", "P2", 5, 100, "2022-09-13"),    
  
(22, "Cl2", "P1", 10, 500, "2021-09-01" ),   
  
(23, "Cl2", "P2", 5, 100, "2021-09-05"),   
  
(24, "Cl3", "P3", 20, 800, "2021-09-03"),   
  
(25, "Cl4", "P4", 15, 150, "2021-09-07"),   
  
(26, "Cl1", "P3", 10, 450, "2021-09-08"),   
  
(27, "Cl2", "P1", 20, 1000, "2022-09-01" ),   
  
(28, "Cl2", "P2", 10, 200, "2022-09-05"),   
  
(29, "Cl3", "P3", 20, 800, "2021-09-03"),   
  
(30, "Cl1", "P1", 10, 500, "2022-09-01" ); 




-- task1: Function
CREATE FUNCTION FindAverageCost(YearInput INT) 
RETURNS DECIMAL(10,2) DETERMINISTIC 
RETURN (SELECT AVG(Cost) FROM Orders WHERE YEAR(Date) = YearInput); 
SELECT FindAverageCost (2021);


-- task 2: stored procedure
DELIMITER//
CREATE PROCEDURE EvaluateProduct(IN product_id VARCHAR(10), OUT SoldItems2020 INT, OUT SoldItems2021 INT, OUT SoldItems2022 INT)
BEGIN
SELECT SUM(Quantity) INTO SoldItems2020 WHERE ProductID = product_id AND YEAR(Date) = 2020;
SELECT SUM(Quantity) INTO SoldItems2020 WHERE ProductID = product_id AND YEAR(Date) = 2021;
SELECT SUM(Quantity) INTO SoldItems2020 WHERE ProductID = product_id AND YEAR(Date) = 2022;
END //
DELIMITER;
CALL EvaluateProduct('P1', @sold_items_2020, @sold_items_2021, @sold_items_2022);


-- task 3: trigger
CREATE TRIGGER UpdateAudit AFTER INSERT ON Orders FOR EACH ROW
INSERT INTO AUDIT (OrderDateTime) VALUES (current_timestamp());


-- task 4: inner join
SELECT Employees.FullName, Addresses.Street, Addresses.County
FROM Employees INNER JOIN Addresses
ON EMPLOYEES.AddressID = Addresses.AddressID
UNION 
Select Clients.FullName, Addresses.Street, Addresses.County
FROM Clients INNER JOIN Addresses
ON Clients.AddressID = Addresses.AddressID
ORDER BY Street;

-- task 5 cte
WITH
P2_Sales_2020 AS (SELECT CONCAT(SUM(Cost), " (2020)") AS "Total sum of P2 Product" FROM Orders WHERE YEAR(Date) = 2020 AND ProductID= "P2"),
P2_Sales_2021 AS (SELECT CONCAT(SUM(Cost), " (2021)") AS "Total sum of P2 Product" FROM Orders WHERE YEAR(Date) = 2021 AND ProductID= "P2"),
P2_Sales_2022 AS (SELECT CONCAT(SUM(Cost), " (2022)") AS "Total sum of P2 Product" FROM Orders WHERE YEAR(Date) = 2022 AND ProductID= "P2")
SELECT * FROM P2_Sales_2020
UNION
SELECT * FROM P2_Sales_2021
UNION
SELECT * FROM P2_Sales_2022;


-- task 6 activity json thingy
SELECT Activity.Properties ->>'$.ClientID' 
AS ClientID, Activity.Properties ->>'$.ProductID' 
AS ProductID, Clients.FullName, Clients.ContactNumber 
FROM Clients RIGHT JOIN Activity 
ON Clients.ClientID = Activity.Properties ->>'$.ClientID';


-- task 7 procedure
DELIMITER //
CREATE PROCEDURE GetProfit(IN product_id VARCHAR(10), IN YearInput INT)
BEGIN
DECLARE profit DEC(7,2) DEFAULT 0.0; 
DECLARE sold_quantity, buy_price, sell_price INT DEFAULT 0;
SELECT SUM(Quantity) INTO sold_quantity FROM Orders WHERE ProductID = product_id AND YEAR(Date) = YearInput; 
SELECT BuyPrice INTO buy_price FROM Products WHERE ProductID = product_id; 
SELECT SellPrice INTO sell_price FROM Products WHERE ProductID = product_id;
SET profit = (sell_price * sold_quantity) - (buy_price * sold_quantity);
Select profit; 
END //
DELIMITER ;

CALL GetProfit('P1', 2020);


-- task 8 virtual table
CREATE VIEW DataSummary AS 
SELECT Clients.FullName, Clients.ContactNumber, Addresses.County, Products.ProductName, Orders.ProductID, Orders.Cost, Orders.Date 
FROM Clients INNER JOIN Addresses ON Clients.AddressID = Addresses.AddressID INNER JOIN Orders ON Clients.ClientID = Orders.ClientID 
INNER JOIN Products ON Orders.ProductID = Products.ProductID WHERE YEAR(Orders.Date) = 2022 ORDER BY Orders.Cost DESC;


