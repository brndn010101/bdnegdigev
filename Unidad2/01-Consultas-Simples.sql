-- Lenguaje SQL LMD (Insert, Uodate, Delete, Select - CRUD)
-- Consultas Simples

USE Northwind;

-- Mostrar todos los clientes de la empresa con todas las columnas de datos
SELECT * FROM Customers;

-- Mostrar todos los proveedores, categor�as, productos, ordenes, detalles de la orden
-- empleados de la empresa con todas las columnas de datos
SELECT * FROM Employees;
SELECT * FROM Orders;
SELECT * FROM Suppliers;
--Cuando tiene espacios el nombre de una tabla se colocan corchetes
SELECT * FROM [Order Details];
SELECT * FROM Categories;
SELECT * FROM Shippers;
SELECT * FROM Products;

-- Proyeccion
SELECT * FROM Products;
SELECT ProductID, ProductName, UnitPrice, UnitsInStock FROM Products;


-- Seleccionar o mostrar el n�mero de empleado, su primer nombre
-- su cargo, ciudad y pa�s
SELECT * FROM Employees;
SELECT EmployeeID, FirstName, Title, City, Country FROM Employees;

-- Alias de columna
-- En base a la consulta anterior, visualizar el employeeID como
-- numero Empleado, first name como primerNombre, title como cargo,
-- city como ciudad, country como pais

SELECT EmployeeID as [Numero Empleado], FirstName as PrimerNombre,
Title 'Cargo', City as Ciudad, Country as Pais FROM Employees;

SELECT EmployeeID as 'Numero Empleado', FirstName as PrimerNombre,
Title 'Cargo', City as Ciudad, Country as Pais FROM Employees;

-- Campos calculados
-- Seleccionar el importe de cada uno de los productos vendidos en una orden

SELECT *, (UnitPrice*Quantity) as Importe FROM [Order Details];

-- Seleccionar las fechas de orden, a�o, mes y dia, cliente que orden�
-- y el empleado que la realiz�

SELECT OrderDate as [Fecha de Orden], year (OrderDate) as A�o, month (OrderDate) as Mes,
day (OrderDate) as Dia, CustomerID as [ID Cliente], EmployeeID as [ID Empleado] FROM Orders;

-- Cl�usula WHERE
-- Operadores relacionales (>, <, =, <=, >=, != o <>) 
SELECT * FROM Customers;

-- FILAS DUPLICADAS
SELECT * FROM Customers;

-- Mostrar los paises donde se tienen clientes, mostrando el pais solamente
SELECT distinct Country
FROM Customers as Pais
order by Country;

-- Seleccionar el cliente BOLID

SELECT CustomerID as [ID Cliente], CompanyName as [Nombre Compa�ia], City as Ciudad, Country as Pais FROM Customers
WHERE CustomerID = 'Bolid';

-- Seleccionar los clientes mostrando su ID, Nombre de la Empresa, Contacto, Ciudad y Pais de Alemania

SELECT CustomerID as [Cliente ID],
CompanyName as [Nombre Compa�ia],
ContactName as [Contacto],
City as Ciudad,
Country as Pais
FROM Customers
WHERE Country = 'Germany';

-- Seleccionar todos los clientes que no sean de Alemania

SELECT CustomerID as [Cliente ID],
CompanyName as [Nombre Compa�ia],
ContactName as [Contacto],
City as Ciudad,
Country as Pais
FROM Customers
WHERE Country != 'Germany';

SELECT CustomerID as [Cliente ID],
CompanyName as [Nombre Compa�ia],
ContactName as [Contacto],
City as Ciudad,
Country as Pais
FROM Customers
WHERE Country <> 'Germany';

-- Seleccionar todos los productos mostrando su nombre, categor�a, existencia, precio pero
-- solamente donde su precio sea mayor a 100

SELECT ProductName as [Nombre Producto],
CategoryID as Categoria,
UnitsInStock as [Unidades Existentes],
UnitPrice as [Precio Unitario],
(UnitPrice * UnitsInStock) as [Costo Inventario]
FROM Products
WHERE UnitPrice >= 100.0;


-- Seleccionar las ordenes de compra mostrando la fecha de orden, de entrega, de envio
-- el cliente a quien se vendio de 1996
SELECT * FROM Orders;

SELECT OrderDate as FechaOrden,
RequiredDate as FechaSolicitud,
ShippedDate as FechaEntrega,
CustomerID as [Entregado a] FROM Orders
WHERE year(OrderDate) = 1996;


-- Mostrar todas las �rdenes de compra donde la cantidad de productos comprados
-- Sea mayor a 5
SELECT OrderID
FROM [Order Details]
WHERE Quantity >= 40;

-- Mostrar el nombre completo del emleado, su n�mero de empleado, fecha de nacimiento
-- ciudad y fecha de contrataci�n que fueron contratados despu�s de 1993
SELECT EmployeeID as ID, FirstName as Nombre, LastName as Apellido, EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contrataci�n]
FROM Employees
WHERE year (HireDate) > 1993;

-- CONCATENACI�N CALCULADA
-- Mostrar el nombre completo del emleado, su n�mero de empleado, fecha de nacimiento
-- ciudad y fecha de contrataci�n que fueron contratados despu�s de 1993
SELECT EmployeeID as ID, (FirstName + ' ' + LastName) as [Nombre Completo], EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contrataci�n]
FROM Employees
WHERE year (HireDate) > 1993;

-- CONCATENACI�N TRANSACT 
-- Mostrar el nombre completo del emleado, su n�mero de empleado, fecha de nacimiento
-- ciudad y fecha de contrataci�n que fueron contratados despu�s de 1993
SELECT EmployeeID as ID, Concat (FirstName, ' ', LastName, ' - ', Title) as [Nombre Completo - Cargo], EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contrataci�n]
FROM Employees
WHERE year (HireDate) > 1993;

-- Mostrar los empleados que no son dirigidos por el empleado o jefe 2
SELECT EmployeeID as ID, Concat (FirstName, ' ', LastName, ' - ', Title) as [Nombre Completo - Cargo], EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contrataci�n], ReportsTo as Jefe
FROM Employees
WHERE ReportsTo != 2;

-- Mostrar los empleados que no tengan jefe
SELECT EmployeeID as ID, Concat (FirstName, ' ', LastName, ' - ', Title) as [Nombre Completo - Cargo], EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contrataci�n], ReportsTo as Jefe
FROM Employees
WHERE ReportsTo is null;


-- Operadores L�gicos (or, and, not)
-- Seleccionar los productos que tengan un precio de entre 10 y 50 d�lares

SELECT * FROM Products;

SELECT ProductName as Prodcuto, UnitPrice as [Precio Unitario], UnitsInStock as Stock
FROM Products
WHERE UnitPrice >= 10 AND UnitPrice <= 50;

-- Mostrar todos los pedidos realizados por clientes que no son enviados a Alemania

SELECT OrderID, ShipCountry
FROM Orders
WHERE ShipCountry != 'Germany';

SELECT OrderID, ShipCountry
FROM Orders
WHERE NOT ShipCountry = 'Germany';

-- Seleccionar Clientes de M�xico o USA

SELECT CompanyName ,Country
FROM Customers
WHERE Country = 'Mexico' or Country = 'USA';

-- Seleccionar empleados que nacieron entre 1955 y 1958 y viven en Londres
SELECT * FROM Employees;

SELECT (FirstName + ' ' + LastName) as Name, BirthDate, City
FROM Employees
WHERE year(BirthDate) >= 1955 AND year(BirthDate) <= 1958 AND City = 'London';

SELECT (FirstName + ' ' + LastName) as Name, BirthDate, City
FROM Employees
WHERE (year(BirthDate) >= 1955 OR year(BirthDate) <= 1958) AND City = 'London';

-- Pedidos de Flete mayor a 100 en peso y enviados a Francia o Espa�a
SELECT OrderID, OrderDate, Freight, ShipCountry
FROM Orders
WHERE (ShipCountry = 'Spain' OR ShipCountry = 'France') AND Freight >= 100;

-- Seleccionar las primeras 5 �rdenes de compra
SELECT TOP 5 *
FROM Orders;

-- Seleccionar productos con precio entre $10 y $50, que no est�n descontinuados
-- y tengan m�s de 20 unidades en stock

SELECT ProductName, UnitPrice, UnitsInStock, Discontinued
FROM Products
WHERE (UnitPrice >= 10 AND UnitPrice <= 50) AND Discontinued = 0 AND UnitsInStock >= 20;

SELECT ProductName, UnitPrice, UnitsInStock, Discontinued
FROM Products
WHERE (UnitPrice >= 10 AND UnitPrice <= 50) AND NOT Discontinued = 1 AND UnitsInStock >= 20;

-- Pedidos menores en Flete a 50 y enviados a Francia y Alemana
SELECT OrderID, Freight, ShipCountry
FROM Orders
WHERE (ShipCountry = 'France' OR ShipCountry = 'Germany') AND Freight < 50;

-- Clientes que no sean Mexico y USA y tengan fax registrado
SELECT CompanyName, Country, Fax
FROM Customers
WHERE NOT (Country = 'Mexico' OR  Country = 'USA') AND Fax IS NOT NULL;

SELECT CompanyName, Country, Fax
FROM Customers
WHERE Country != 'Mexico' AND  Country != 'USA' AND Fax IS NOT NULL;

-- Seleccionar fletes mayores a 100 enviados a Brasil pero no enviados por el transportista 1
SELECT * FROM Orders;

SELECT ShipVia, Freight, ShipCountry
FROM Orders
WHERE ShipCountry = 'Brazil' AND Freight >=100 and ShipVia != 1;

-- Seleccionar Empleados que No viven en Londes o Seattle
-- Y que fueron contratados despues de 1995

SELECT (FirstName + ' ' + LastName) as Nombre, City, HireDate
FROM Employees
WHERE City != 'London' AND City != 'Seattle' AND YEAR(HireDate) >= 1992;

-- CLAUSULA IN (OR)
-- Seleccionar Prodcutos con categr�a 1,3 o 5
SELECT ProductName, CategoryID, UnitPrice
FROM Products
WHERE CategoryID = 1 OR CategoryID = 3 OR CategoryID = 5;

SELECT ProductName, CategoryID, UnitPrice
FROM Products
WHERE CategoryID IN (1, 3, 5);

-- Seleccionar todas las ordenes dela region RJ, Tachira y que no
-- tengan region asignada
SELECT OrderID, OrderDate ,ShipRegion
FROM Orders
WHERE ShipRegion IN ('RJ', 'T�chira') OR ShipRegion is null;

-- Seleccionar ordenes con cantidades de 12, 9 y 40 y descuento de 0.15 y 0.50
SELECT OrderID, Quantity, Discount
FROM [Order Details]
WHERE Quantity IN (9, 12,40) AND Discount IN (0.15, 0.05);

-- CLAUSULA BETWEEN
