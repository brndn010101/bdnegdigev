USE Northwind;

-- Seleccionar todas la categorías y productos
SELECT *
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID;

SELECT Categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID;

SELECT C.CategoryID as [Numero de Categorias], CategoryName as 'Nombre Categoria',
ProductName as 'Nombre del Producto', UnitsInStock as Existencia, UnitPrice as Precio
FROM Categories as C
INNER JOIN Products as P
ON C.CategoryID = P.CategoryID;

-- Seleccionar los productos de la categoría Beverage y Condiments donde
-- la existencia esté entre 18 y 30

SELECT C.CategoryID as [Numero de Categorias], CategoryName as 'Nombre Categoria',
ProductName as 'Nombre del Producto', UnitsInStock as Existencia, UnitPrice as Precio
FROM Categories as C
INNER JOIN Products as P
ON C.CategoryID = P.CategoryID
WHERE (CategoryName IN ('Condiments','Beverages')) AND (UnitsInStock BETWEEN 18 AND 30);

SELECT *
FROM Products as P
JOIN Categories as C
ON P.CategoryID = C.CategoryID
WHERE (C.CategoryName = 'Beverages' OR CategoryName = 'Condiments')
AND P.UnitsInStock>18 AND P.UnitsInStock<=30;

-- Seleccionar los productos y sus importes realizados de marzo
-- a junio de 1996, mostrando la fecha dde la orden, el id del producto
-- y el importe

SELECT [Order Details].ProductID, ([Order Details].UnitPrice*[Order Details].Quantity) as Importe, Orders.OrderDate 
FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
WHERE OrderDate BETWEEN '01-07-1996' AND'30-10-1996';

-- Mostrar el importe total de ventas de la consulta anterior
SELECT SUM ([Order Details].UnitPrice*[Order Details].Quantity) as ImporteTotal
FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
WHERE OrderDate BETWEEN '01-07-1996' AND'30-10-1996';

SELECT CONCAT ('$', ' ', SUM([Order Details].UnitPrice*[Order Details].Quantity)) as ImporteTotal
FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
WHERE OrderDate BETWEEN '01-07-1996' AND'30-10-1996';


-- CONSULTAS BÁSICAS CON INNER JOIN
-- Obtener los nombres de los clientes y los paises a los que se
-- enviaron sus pedidos

SELECT Customers.CompanyName, Orders.CustomerID,Orders.ShipCountry
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
ORDER BY Orders.ShipCountry asc;

--Obtener los productos y sus respectivos proveedores
SELECT  Products.ProductName, Suppliers.CompanyName
FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID;


--Obtener los pedidos y los empleados que los gestionaron
SELECT Orders.OrderID, FirstName, LastName
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID;

-- Listar los productos junto con sus precios y la categoría a la
-- que pertenecen

SELECT Products.ProductName, Categories.CategoryID, Categories.CategoryName
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID;

-- Obtener el nombre del cliente, el número de orden y la fecha de orden
SELECT Customers.CompanyName, Orders.OrderID, Orders.OrderDate
FROM Customers
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID;

-- Listar las ordenes mostrando el numero de orden, el nombre del producto
-- y la cantidad que se vendio
SELECT [Order Details].OrderID, Products.ProductName, (([Order Details].UnitPrice*UnitsInStock)-([Order Details].UnitPrice*UnitsInStock*Discount)) as Importe
FROM Products
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID;

SELECT [Order Details].OrderID, Products.ProductName, [Order Details].Quantity
FROM Products
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID;

SELECT [Order Details].OrderID, Products.ProductName, [Order Details].Quantity
FROM Products
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
WHERE [Order Details].OrderID = 11031;

SELECT [Order Details].OrderID, COUNT (*) as Quantity
FROM Products
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
WHERE [Order Details].OrderID = 11031
GROUP BY [Order Details].OrderID;

SELECT [Order Details].OrderID, Products.ProductName, ([Order Details].UnitPrice*Quantity) as Importe
FROM Products
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID;

-- Obtener los Empleados y sus Respectivos Jefes
SELECT CONCAT ((E1.FirstName), ' ',(E1.LastName)) as Nombre, E2.ReportsTo
FROM Employees as E1
INNER JOIN Employees as E2
ON E1.EmployeeID = E2.EmployeeID;

SELECT CONCAT ((E1.FirstName), ' ',(E1.LastName)) as Nombre, CONCAT ((E2.FirstName), ' ',(E2.LastName)) as Nombre
FROM Employees as E1
INNER JOIN Employees as E2
ON E1.ReportsTo = E2.EmployeeID;

SELECT CONCAT ((Employees.FirstName), ' ',(Employees.LastName)) as Nombre, Employees.ReportsTo
FROM Employees;

-- Listar los pedidos y el nombre de la empresa de transporte utilizada

SELECT Shippers.CompanyName, Orders.OrderID
FROM Orders
INNER JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia;

-- Obetener la canditdad total de productos vendidos por categoria
SELECT SUM (Quantity) as Cantidad
FROM [Order Details];

SELECT Categories.CategoryName, SUM (Quantity) as [Productos Vendidos]
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY Categories.CategoryName;

-- Obtener el total de ventas por empleado

SELECT Employees.EmployeeID, CONCAT (Employees.FirstName,' ',Employees.LastName) as Empleado, ([Order Details].UnitPrice*Quantity) as [Total Vendido]
FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Employees
ON Employees.EmployeeID = Orders.EmployeeID;

SELECT Employees.FirstName, SUM (([Order Details].UnitPrice*[Order Details].Quantity)-([Order Details].UnitPrice*[Order Details].Quantity*[Order Details].Discount)) as Total
FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Employees
ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.FirstName;

-- Listar los clientes y la cantidad de pedidos que han realiado
SELECT Customers.CompanyName, SUM ([Order Details].Quantity) as Quantity
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
GROUP BY Customers.CompanyName
ORDER BY Customers.CompanyName asc;

SELECT Customers.CompanyName, COUNT (*) as Quantity
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CompanyName
ORDER BY Customers.CompanyName asc;

-- Obtener los empleados que han gestionado pedidos enviados a Alemania
SELECT CONCAT (Employees.FirstName, ' ', Employees.LastName) as Name, Orders.ShipCountry, Orders.OrderID
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShipCountry = 'Germany';

SELECT DISTINCT CONCAT (Employees.FirstName, ' ', Employees.LastName) as Name, Orders.ShipCountry
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShipCountry = 'Germany';

-- Listar los prouctos junto con el nombre del proveedor y el país de origen

SELECT Products.ProductName, Suppliers.CompanyName, Suppliers.Country
FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID;

-- Obtener los pedidos agrupados por pais de envio
SELECT Orders.ShipCountry, SUM([Order Details].Quantity) as Quantity
FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
GROUP BY Orders.ShipCountry;

SELECT ShipCountry, COUNT (OrderID) as Orders
FROM Orders
GROUP BY ShipCountry;

-- Obtener los empleados y la cantidad de territorios en los que trabaja
SELECT Employees.FirstName, Territories.TerritoryDescription
FROM Employees
INNER JOIN EmployeeTerritories
ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
INNER JOIN Territories 
ON EmployeeTerritories.TerritoryID = Territories.TerritoryID;

SELECT CONCAT (Employees.FirstName, ' ', Employees.LastName) as [Name], COUNT (Territories.TerritoryID) as Territories
FROM Employees
INNER JOIN EmployeeTerritories
ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
INNER JOIN Territories 
ON EmployeeTerritories.TerritoryID = Territories.TerritoryID
GROUP BY CONCAT (Employees.FirstName, ' ', Employees.LastName);

SELECT CONCAT (Employees.FirstName, ' ', Employees.LastName) as [Name], Territories.TerritoryDescription,
COUNT (Territories.TerritoryID) as Territories
FROM Employees
INNER JOIN EmployeeTerritories
ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
INNER JOIN Territories 
ON EmployeeTerritories.TerritoryID = Territories.TerritoryID
GROUP BY CONCAT (Employees.FirstName, ' ', Employees.LastName), Territories.TerritoryDescription;

-- Listar las categorias y la cantidad de productos que contienen
SELECT Categories.CategoryName, SUM (Products.UnitsInStock) as Quantity
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName;

SELECT Categories.CategoryName, COUNT (Products.ProductID) as Quantity
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName
ORDER BY 1 asc;

-- Obtener la cantidad total de productos vendidos por proveedor
SELECT Suppliers.CompanyName, SUM ([Order Details].Quantity*[Order Details].UnitPrice) as [Cantidad Vendida]
FROM Products
INNER JOIN Suppliers
ON Suppliers.SupplierID = Products.SupplierID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY Suppliers.CompanyName;

SELECT Suppliers.CompanyName, SUM ([Order Details].Quantity) as [Cantidad Vendida]
FROM Products
INNER JOIN Suppliers
ON Suppliers.SupplierID = Products.SupplierID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY Suppliers.CompanyName;

SELECT Suppliers.CompanyName, COUNT (Orders.OrderID) as [Cantidad Vendida]
FROM Products
INNER JOIN Suppliers
ON Suppliers.SupplierID = Products.SupplierID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON Orders.OrderID = [Order Details].OrderID
GROUP BY Suppliers.CompanyName;

-- Obtener la cantidad de pedidos enviados por cada empresa de transporte
SELECT Shippers.CompanyName, COUNT (Orders.OrderID) as [Cantidad Pedidos Enviados]
FROM Orders
INNER JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia
GROUP BY Shippers.CompanyName;

-- Consultas avanzadas