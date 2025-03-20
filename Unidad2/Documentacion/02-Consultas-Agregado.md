# Consultas de Agregado

```sql
USE Northwind;

-- Consulas de agregado
-- Solo devuelven un solo registro
-- sum, avg, count(*), max, min

-- Cu�ntos clientes tengo

SELECT COUNT (*) as 'N�mero de clientes'
FROM Customers;

SELECT COUNT (*) as Region
FROM Customers
WHERE Region is null;

SELECT Region
FROM Customers
WHERE Region is not null
ORDER BY Region asc;

SELECT DISTINCT Region
FROM Customers
WHERE Region is not null
ORDER BY Region asc;

SELECT COUNT (DISTINCT Region) as Region
FROM Customers
WHERE Region is not null;

SELECT *
FROM Orders;

SELECT COUNT (*)
FROM Orders;

SELECT COUNT (ShipRegion)
FROM Orders;

-- Selecciona el precio m�s bajo de los productos
SELECT MIN(UnitPrice) as Precio
FROM Products;

SELECT MAX(UnitPrice) as Precio
FROM Products;

SELECT MIN(UnitPrice) as Precio, MAX(UnitPrice) as Precio
FROM Products;

SELECT AVG(UnitsInStock) as Precio
FROM Products;

-- Selecciona cu�ntos pedidos existen
SELECT OrderID as [Pedidos Existentes]
FROM [Order Details];

SELECT COUNT (OrderID) as [Pedidos Existentes]
FROM [Order Details];

SELECT COUNT (OrderID) as [Pedidos Existentes]
FROM Orders;

-- Calcula el total del dinero vendido
SELECT (UnitPrice * Quantity) as [Total Ventas]
FROM [Order Details];

SELECT SUM (UnitPrice * Quantity) as [Total Ventas]
FROM [Order Details];

SELECT SUM ((UnitPrice * Quantity)-(UnitPrice * Quantity * Discount)) as [Total Ventas]
FROM [Order Details];

-- Calcula el total de unidades en stock de todos los productos
SELECT SUM(UnitsInStock) as [Unidades Existentes]
FROM Products;

-- GROUP BY

-- Seleccionar el n�mero de productos por categor�a
SELECT Count (CategoryID), COUNT (*)
FROM Products;

SELECT CategoryID, COUNT (*) as [N�mero de Productos]
FROM Products
GROUP BY CategoryID;


-- JOIN
SELECT *
FROM Categories;
SELECT *
FROM Products;

SELECT *
FROM Categories as C INNER JOIN Products as P
ON C.CategoryID = P.CategoryID;

SELECT *
FROM Categories INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID;

SELECT C.CategoryName, COUNT (*) as [N�mero de Productos]
FROM Categories as C INNER JOIN Products as P
ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName;

SELECT Categories.CategoryName, COUNT (*) as [N�mero de Productos]
FROM Categories INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName;

-- Calcular el precio promedio de los productos por categoria
SELECT CategoryID, AVG (UnitPrice) as [Promedio]
FROM Products
GROUP BY CategoryID;

-- Seleccionar el n�mero de pedidos realizados por cada empleado
-- en el �ltimo trimestre de 1996
SELECT EmployeeID, COUNT (OrderDate) as [N�mero de Pedidos]
FROM Orders
GROUP BY EmployeeID;

SELECT EmployeeID, COUNT (OrderDate) as [N�mero de Pedidos]
FROM Orders
WHERE OrderDate BETWEEN '01-10-1996' AND '31-12-1996'
GROUP BY EmployeeID
ORDER BY EmployeeID asc;

-- Seleccionar la suma total de unidades vendidas por cada
-- producto
SELECT ProductID, SUM (Quantity) as [Unidades Vendidas]
FROM [Order Details]
GROUP BY ProductID
ORDER BY 1 desc;

SELECT OrderId, ProductID, SUM (Quantity) as [Unidades Vendidas]
FROM [Order Details]
GROUP BY OrderID, ProductID
ORDER BY 2 desc;

-- Seleccionar el numero de productos por categoria pero solo 
-- aquellos que tengan mas de 10 productos

SELECT CategoryID, COUNT (UnitsInStock) as [Unidades en Stock]
FROM Products
GROUP BY CategoryID
HAVING COUNT(UnitsInStock)>10;

SELECT CategoryID, COUNT (*) as [Unidades en Stock]
FROM Products
GROUP BY CategoryID
HAVING COUNT(*)>10;

-- Ejemplo
SELECT CategoryID, SUM (UnitsInStock) as [Unidades en Stock]
FROM Products
WHERE CategoryID IN (2,4,8)
GROUP BY CategoryID
HAVING COUNT(*)>10
ORDER BY CategoryID asc;

-- Listar las ordenes agrupadas por empleado, pero que solo muestre aquellos
-- que hayan gestionado mas de 10 pedidos

SELECT EmployeeID, COUNT (OrderDate) as [Numero de Pedidos]
FROM Orders
GROUP BY EmployeeID
HAVING COUNT (OrderDate) > 10
ORDER BY EmployeeID asc;
```