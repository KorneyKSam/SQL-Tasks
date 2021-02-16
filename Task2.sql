--Задание 2.1. Использование агрегатных функций (SUM, COUNT)
--Задание 2.1.1
SELECT SUM(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) AS Totals 
FROM [Order Details]

--Задание 2.1.2
SELECT SUM(CASE WHEN ShippedDate IS NULL THEN 1 else 0 END) count_nulls
FROM Orders

--Задание 2.1.3
SELECT COUNT(DISTINCT CustomerID) AS NumberOfCustomers
FROM Orders


--Задание 2.2. Соединение таблиц, использование агрегатных функций и предложений GROUP BY и HAVING 
--Задание 2.2.1
SELECT YEAR(OrderDate) AS [Year], COUNT(OrderID) AS [Total]
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY Total DESC

--Задание 2.2.2
SELECT Employees.LastName +' ' + Employees.FirstName AS Seller,
		Count(Orders.EmployeeID) AS Amount
FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.LastName +' ' + Employees.FirstName

--Задание 2.2.3
SELECT EmployeeID, CustomerID , Count(OrderID) AS NumberOfOrders
FROM Orders
WHERE YEAR(OrderDate)=1998
GROUP BY EmployeeID, CustomerID

--Задание 2.2.3 Проверочный запрос
SELECT EmployeeID, CustomerID , OrderDate
FROM Orders
WHERE YEAR(OrderDate)=1998
ORDER BY EmployeeID, CustomerID


--Задание 2.2.4 Условия задачи расплывчаты по этому два варианта решения.
--Вариант 1
SELECT Customers.City, Customers.ContactName, CONCAT(Employees.FirstName,' ', Employees.LastName) AS FullName
FROM Customers
JOIN Employees ON Customers.City = Employees.City
WHERE Customers.City in
(
	SELECT C2.City FROM Customers c2
	GROUP BY c2.City
	HAVING COUNT(*)>1
)

-- Вариант 2
SELECT c1.City, ContactName
FROM Customers c1
WHERE City IN
(
SELECT c2.City FROM Customers c2
GROUP BY c2.City
HAVING count(*) > 1
)
ORDER BY c1.City

--Задание 2.2.5
SELECT City, ContactName
FROM Customers
WHERE City IN
(
	SELECT c2.City FROM Customers c2
	GROUP BY c2.City
	HAVING COUNT(CustomerID) > 1
)
ORDER BY City

--Задание 2.2.6
SELECT CONCAT(Emp1.FirstName, ' ', Emp1.LastName) AS FullName, ISNULL(CASE WHEN emp1.ReportsTo IS NULL THEN 'No Manager' ELSE CONCAT(Emp2.FirstName, ' ', Emp2.LastName) END,'') AS [MangerName]
FROM Employees emp1
LEFT JOIN Employees emp2 ON emp1.ReportsTo = emp2.EmployeeID


--Задание 2.3. Использование JOIN
--Задание 2.3.1
SELECT Region.RegionDescription, Territories.TerritoryDescription, CONCAT(Employees.FirstName, ' ', Employees.LastName) AS Emlpoye
FROM Region
LEFT JOIN Territories ON Region.RegionID = Territories.RegionID
INNER JOIN  EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
INNER JOIN  Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
WHERE Region.RegionDescription = 'Western'

--Задание 2.3.2
SELECT ContactName, COUNT(OrderID) AS NumberOfOrders
FROM Customers
LEFT JOIN Orders ON Orders.CustomerID = Customers.CustomerID
GROUP BY ContactName
ORDER BY NumberOfOrders



--Задание 2.4. Использование подзапросов
--Задание 2.4.1
SELECT Suppliers.CompanyName
FROM Suppliers
WHERE SupplierID IN
(
	SELECT SupplierID
	FROM Products
	WHERE UnitsInStock <= 0
)


--Задание 2.4.2
SELECT CONCAT(FirstName, ' ', LastName), EmployeeID
FROM Employees
WHERE EmployeeID IN
(
	SELECT DISTINCT EmployeeID
	FROM Orders
	GROUP BY EmployeeID
	HAVING COUNT(OrderID) > 150
)


--Задание 2.4.3
SELECT ContactName, CompanyName
FROM Customers
WHERE NOT EXISTS
(
	SELECT *
	FROM Orders
	WHERE Orders.CustomerID = Customers.CustomerID
)