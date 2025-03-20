# 01 - Tarea Consultas Simples

```sql
USE Northwind

-- Tareas de Consultas Simples
--1.    Productos con categor�a 1, 3 o 5

SELECT ProductID, ProductName, CategoryID, UnitPrice
FROM Products
WHERE CategoryID IN (1,3,5);

--2.    Clientes de M�xico, Brasil o Argentina

SELECT CustomerID, CompanyName, Country
FROM Customers
WHERE Country IN ('Mexico', 'Brazil', 'Argentina');

--3.    Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50

SELECT OrderID, ShipVia, Freight, ShipName
FROM Orders
WHERE ShipVia IN (1, 2, 3) AND Freight > 50;

--4.    Empleados que trabajan en Londres, Seattle o Buenos Aires
SELECT * FROM Employees -- No hay empleados de Argentina
SELECT EmployeeID, (FirstName + ' ' + LastName) as Name, City
FROM Employees
WHERE City IN ('London', 'Seattle', 'Buenos Aires');

--5.    Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100

SELECT OrderID, ShipCountry, Freight
FROM Orders
WHERE ShipCountry IN ('France', 'Germany') AND Freight < 100;

--6.    Productos con categor�a 2, 4 o 6 y que NO est�n descontinuados

SELECT ProductID, ProductName, CategoryID, Discontinued
FROM Products
WHERE CategoryID IN (2, 4, 6) AND Discontinued = 0;

--7.    Clientes que NO son de Alemania, Reino Unido ni Canad�
SELECT DISTINCT Country FROM Customers; -- Para Conocer todos los pa�ses

SELECT CustomerID, CompanyName, Country
FROM Customers
WHERE NOT Country IN ('Germany', 'UK', 'Canada');

--8.    Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canad�

SELECT OrderID, ShipCountry, ShipVia
FROM Orders
WHERE ShipVia IN (2, 3) AND NOT ShipCountry IN ('USA', 'Canada');

--9.    Empleados que trabajan en 'London' o 'Seattle' y fueron contratados despu�s de 1995

SELECT EmployeeID, FirstName, City, HireDate
FROM Employees
WHERE City IN ('London', 'Seattle') AND year(HireDate) > 1992; --Reduje la fecha ya que no mostraba
--ning�n registro con 1995

--10.    Productos de categor�as 1, 3 o 5 con stock mayor a 50 y que NO est�n descontinuados

SELECT ProductID, ProductName, CategoryID, UnitsInStock, Discontinued
FROM Products
WHERE CategoryID IN (1, 3, 5) AND UnitsInStock > 50 AND Discontinued IN (0);
```