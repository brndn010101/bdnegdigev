# 07 - Vistas

```sql
-- VIEWS

--SINTAXIS
/*
CREATE VIEW nombreVista
AS
SELECT Columnas
FROM TABLA
WHERE CONDICCI�N
*/

USE Northwind
SELECT CategoryID, CategoryName, [Description], Picture
FROM Categories
GO;

CREATE VIEW AllCategoriesView
AS
SELECT CategoryID, CategoryName, [Description], Picture
FROM Categories
GO;

SELECT *
FROM AllCategoriesView
WHERE CategoryName = 'Beverages';

DROP VIEW AllCategoriesView;
GO;

CREATE OR ALTER VIEW AllCategoriesView
AS
SELECT CategoryID, CategoryName, [Description], Picture
FROM Categories
WHERE CategoryName = 'Beverages'
GO;

--CREAR UNA VISTA QUE PERMITA VISUALIZAR LOS CLIENTE S�LO DE M�XICO Y BRAZIL
CREATE VIEW ClientesLatinos
AS
SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('Brazil', 'Mexico')
GO;

SELECT *
FROM ClientesLatinos
GO;

-- ALTER -------------------------------------------------------------------
ALTER VIEW ClientesLatinos
AS
SELECT *
FROM Customers
WHERE Country IN ('Brazil', 'Mexico')
GO;

CREATE OR ALTER VIEW ClientesLatinos
AS
SELECT *
FROM Customers
WHERE Country IN ('Brazil', 'Mexico')
GO;

SELECT *
FROM ClientesLatinos
GO;

SELECT CompanyName, City
FROM ClientesLatinos
WHERE City = 'Sao Paulo'
ORDER BY 2 DESC;
----------------------------------------------------------------------------

SELECT DISTINCT ClientesLatinos.Country
FROM Orders
INNER JOIN ClientesLatinos
ON Orders.CustomerID = ClientesLatinos.CustomerID

SELECT DISTINCT ClientesLatinos.Country
FROM Orders
LEFT JOIN ClientesLatinos
ON Orders.CustomerID = ClientesLatinos.CustomerID

SELECT DISTINCT *
FROM Orders
INNER JOIN ClientesLatinos
ON Orders.CustomerID = ClientesLatinos.CustomerID

SELECT DISTINCT *
FROM Orders
LEFT JOIN ClientesLatinos
ON Orders.CustomerID = ClientesLatinos.CustomerID

SELECT DISTINCT *
FROM Orders
RIGHT JOIN ClientesLatinos
ON Orders.CustomerID = ClientesLatinos.CustomerID

-- Crear una vista que tenga los datos de todas las �rdenes, los productos, categor�as de productos
-- en la orden calcular el importe
USE Northwind;

SELECT Orders.OrderID, Orders.OrderDate, Orders.RequiredDate,
CONCAT (Employees.FirstName, ' ', Employees.LastName) as NombreEmpleado, Customers.CompanyName,
Categories.CategoryName, [Order Details].UnitPrice, [Order Details].Quantity,
([Order Details].Quantity * [Order Details].UnitPrice) as Importe
FROM [Order Details]
INNER JOIN Products
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID
INNER JOIN Orders
ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Customers
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Employees
ON Employees.EmployeeID = Orders.EmployeeID
GO;

CREATE VIEW SellsInfo
AS
SELECT Orders.OrderID, Orders.OrderDate, Orders.RequiredDate,
CONCAT (Employees.FirstName, ' ', Employees.LastName) as NombreEmpleado, Customers.CompanyName,
Categories.CategoryName, [Order Details].UnitPrice, [Order Details].Quantity,
([Order Details].Quantity * [Order Details].UnitPrice) as Importe
FROM [Order Details]
INNER JOIN Products
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID
INNER JOIN Orders
ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Customers
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Employees
ON Employees.EmployeeID = Orders.EmployeeID

USE Northwind

SELECT *
FROM SellsInfo

SELECT COUNT(DISTINCT [OrderID])
FROM SellsInfo;

SELECT SUM (Importe)
FROM SellsInfo;

SELECT SUM (Importe)
FROM SellsInfo
WHERE YEAR(OrderDate) BETWEEN '1995' AND  '1996';

SELECT CompanyName, SUM (Importe)
FROM SellsInfo
WHERE YEAR(OrderDate) BETWEEN '1995' AND  '1996'
GROUP BY CompanyName
HAVING COUNT(*)>2;
GO;

CREATE VIEW OrdersView_95_96
AS
SELECT CompanyName, SUM (Importe) as Importe
FROM SellsInfo
WHERE YEAR(OrderDate) BETWEEN '1995' AND  '1996'
GROUP BY CompanyName
HAVING COUNT(*)>2;

GO;

CREATE SCHEMA RH
CREATE TABLE RH.TablaRH(
	id int primary key,
	nombre nvarchar(50)
)

--Vista Horizontal-----------------------------------------------------------------------------
SELECT Categories.CategoryID, Categories.CategoryName, Products.ProductID, Products.ProductName
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID;
GO;

CREATE VIEW RH.ViewCategoriesProducts
AS
SELECT Categories.CategoryID, Categories.CategoryName, Products.ProductID, Products.ProductName
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID;
--Consulta con SCHEMA
SELECT *
FROM [RH].ViewCategoriesProducts
-----------------------------------------------------------------------------------------------

```