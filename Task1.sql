/* Задание №1.1 Простая фильтрация данных*/

--Задание 1.1.1
SELECT OrderID, ShippedDate, ShipVia
FROM Orders
WHERE ShippedDate >= '19980506' and ShipVia >= '2'

--Задание 1.1.2
SELECT OrderID,
ISNULL(CASE WHEN CONVERT(DATE,ShippedDate) IS NULL THEN 'Not Shipped' ELSE CONVERT(varchar(10),ShippedDate,111)END,'') AS [SippedDate]
FROM Orders
WHERE ShippedDate IS NULL

--Задание 1.1.3
SELECT OrderID AS [Order Number], ShippedDate AS [Shipped Date]
FROM Orders
WHERE ShippedDate > '19980506' OR ShippedDate IS NULL

/* Задание №1.2 Исползование операторов IN, DISTINCT, ORDER BY, NOT*/
--Задание №1.2.1
SELECT ContactName, Country
FROM Customers
WHERE Country IN('USA', 'Canada')
ORDER BY ContactName, [Address]

--Задание №1.2.2
SELECT ContactName, Country
FROM Customers
WHERE Country NOT IN('USA', 'Canada')
ORDER BY ContactName

--Задание №1.2.3
SELECT DISTINCT Country
FROM Customers


--Задание 1.3. Использование оператора BETWEEN, DISTINCT

--Задание №1.3.1
SELECT DISTINCT OrderID, Quantity
FROM [Order Details]
WHERE Quantity BETWEEN 3 AND 10

--Задание №1.3.2
SELECT CustomerID, Country
FROM Customers
WHERE LEFT(Country,1) BETWEEN 'b%' AND 'g%'
ORDER BY Country

--Задание №1.3.3
SELECT CustomerID, Country
FROM Customers
WHERE LEFT(Country, 1) >= 'b' and LEFT(Country, 1)<= 'g'
ORDER BY Country


--Задание 1.4. Использование оператора LIKE

--Задание 1.4.1
SELECT ProductName
FROM Products
WHERE ProductName Like '%cho_olade%'