-- Lenguaje SQL LMD (Insert, Uodate, Delete, Select - CRUD)
-- Consultas Simples

USE Northwind;

-- Mostrar todos los clientes de la empresa con todas las columnas de datos
SELECT * FROM Customers;

-- Mostrar todos los proveedores, categorías, productos, ordenes, detalles de la orden
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


-- Seleccionar o mostrar el número de empleado, su primer nombre
-- su cargo, ciudad y país
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

-- Seleccionar las fechas de orden, año, mes y dia, cliente que ordenó
-- y el empleado que la realizó

SELECT OrderDate as [Fecha de Orden], year (OrderDate) as Año, month (OrderDate) as Mes,
day (OrderDate) as Dia, CustomerID as [ID Cliente], EmployeeID as [ID Empleado] FROM Orders;

-- Cláusula WHERE
-- Operadores relacionales (>, <, =, <=, >=, != o <>) 
SELECT * FROM Customers;

-- FILAS DUPLICADAS
SELECT * FROM Customers;

-- Mostrar los paises donde se tienen clientes, mostrando el pais solamente
SELECT distinct Country
FROM Customers as Pais
order by Country;

-- Seleccionar el cliente BOLID

SELECT CustomerID as [ID Cliente], CompanyName as [Nombre Compañia], City as Ciudad, Country as Pais FROM Customers
WHERE CustomerID = 'Bolid';

-- Seleccionar los clientes mostrando su ID, Nombre de la Empresa, Contacto, Ciudad y Pais de Alemania

SELECT CustomerID as [Cliente ID],
CompanyName as [Nombre Compañia],
ContactName as [Contacto],
City as Ciudad,
Country as Pais
FROM Customers
WHERE Country = 'Germany';

-- Seleccionar todos los clientes que no sean de Alemania

SELECT CustomerID as [Cliente ID],
CompanyName as [Nombre Compañia],
ContactName as [Contacto],
City as Ciudad,
Country as Pais
FROM Customers
WHERE Country != 'Germany';

SELECT CustomerID as [Cliente ID],
CompanyName as [Nombre Compañia],
ContactName as [Contacto],
City as Ciudad,
Country as Pais
FROM Customers
WHERE Country <> 'Germany';

-- Seleccionar todos los productos mostrando su nombre, categoría, existencia, precio pero
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


-- Mostrar todas las órdenes de compra donde la cantidad de productos comprados
-- Sea mayor a 5
SELECT OrderID
FROM [Order Details]
WHERE Quantity >= 40;

-- Mostrar el nombre completo del emleado, su número de empleado, fecha de nacimiento
-- ciudad y fecha de contratación que fueron contratados después de 1993
SELECT EmployeeID as ID, FirstName as Nombre, LastName as Apellido, EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contratación]
FROM Employees
WHERE year (HireDate) > 1993;

-- CONCATENACIÓN CALCULADA
-- Mostrar el nombre completo del emleado, su número de empleado, fecha de nacimiento
-- ciudad y fecha de contratación que fueron contratados después de 1993
SELECT EmployeeID as ID, (FirstName + ' ' + LastName) as [Nombre Completo], EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contratación]
FROM Employees
WHERE year (HireDate) > 1993;

-- CONCATENACIÓN TRANSACT 
-- Mostrar el nombre completo del emleado, su número de empleado, fecha de nacimiento
-- ciudad y fecha de contratación que fueron contratados después de 1993
SELECT EmployeeID as ID, Concat (FirstName, ' ', LastName, ' - ', Title) as [Nombre Completo - Cargo], EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contratación]
FROM Employees
WHERE year (HireDate) > 1993;

-- Mostrar los empleados que no son dirigidos por el empleado o jefe 2
SELECT EmployeeID as ID, Concat (FirstName, ' ', LastName, ' - ', Title) as [Nombre Completo - Cargo], EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contratación], ReportsTo as Jefe
FROM Employees
WHERE ReportsTo != 2;

-- Mostrar los empleados que no tengan jefe
SELECT EmployeeID as ID, Concat (FirstName, ' ', LastName, ' - ', Title) as [Nombre Completo - Cargo], EmployeeID as ID, BirthDate as 'Fecha de Nacimiento', HireDate as [Fecha de Contratación], ReportsTo as Jefe
FROM Employees
WHERE ReportsTo is null;


-- Operadores Lógicos (or, and, not)
-- Seleccionar los productos que tengan un precio de entre 10 y 50 dólares

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

-- Seleccionar Clientes de México o USA

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

-- Pedidos de Flete mayor a 100 en peso y enviados a Francia o España
SELECT OrderID, OrderDate, Freight, ShipCountry
FROM Orders
WHERE (ShipCountry = 'Spain' OR ShipCountry = 'France') AND Freight >= 100;

-- Seleccionar las primeras 5 órdenes de compra
SELECT TOP 5 *
FROM Orders;

-- Seleccionar productos con precio entre $10 y $50, que no estén descontinuados
-- y tengan más de 20 unidades en stock

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
-- Seleccionar Prodcutos con categría 1,3 o 5
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
WHERE ShipRegion IN ('RJ', 'Táchira') OR ShipRegion is null;

-- Seleccionar ordenes con cantidades de 12, 9 y 40 y descuento de 0.15 y 0.50
SELECT OrderID, Quantity, Discount
FROM [Order Details]
WHERE Quantity IN (9, 12,40) AND Discount IN (0.15, 0.05);

-- CLAUSULA BETWEEN (Siempre va en el WHERE)
-- BETWEEN (Valor inicial) (Valor final)

-- Mostrar los productos con precio entre 10 y 50

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 10 AND 50;

-- Seleccionar todos los pedidos realizados entre el 01 de Enero y el 30 de Junio de 1997

SELECT CustomerID, OrderDate
FROM Orders
WHERE OrderDate BETWEEN ('01-01-1997') AND ('30-06-1997');

-- Seleccionar todos los empleados contratados entre 1990 y 1995 que trabajan en Londres
SELECT FirstName, HireDate, City
FROM Employees
WHERE HireDate BETWEEN ('01-01-1990') AND ('31-12-1995') AND City = 'London';

SELECT FirstName, HireDate, City
FROM Employees
WHERE year(HireDate) BETWEEN 1992 AND 1994 AND City = 'London';

SELECT FirstName, HireDate, City
FROM Employees
WHERE year(HireDate) >= 1992 AND YEAR(HireDate)<=1994 AND City = 'London';

-- Pedidos con flete entre 50 y 200 enviados a alemania y a francia
SELECT OrderID as ID, OrderDate as 'Fecha de Orden', RequiredDate as [Fecha de Entrega], Freight as Peso, ShipCountry as [Pais de Entrega]
FROM Orders
WHERE Freight BETWEEN 50 AND 200 AND ShipCountry IN ('France', 'Germany');

SELECT OrderID as ID, OrderDate as 'Fecha de Orden', RequiredDate as [Fecha de Entrega], Freight as Peso, ShipCountry as [Pais de Entrega]
FROM Orders
WHERE Freight > 50 AND Freight < 200 AND (ShipCountry = 'France' or ShipCountry = 'Germany');

-- Seleccionar todos los produtos que tengan un precio entre 5 y 20
-- y que sean de la categoría 1,2,3
SELECT ProductName, UnitPrice, CategoryID
FROM Products
WHERE UnitPrice BETWEEN 5 AND 20 AND (CategoryID IN (1, 2, 3));

SELECT ProductName, UnitPrice, CategoryID
FROM Products
WHERE UnitPrice >= 5 AND UnitPrice <= 20 AND (CategoryID = 1 OR CategoryID = 2 OR CategoryID = 3);

-- Seleccionar todos los produtos que tengan un precio entre 5 y 20
-- o que sean de la categoría 1,2,3

SELECT ProductName, UnitPrice, CategoryID
FROM Products
WHERE UnitPrice BETWEEN 5 AND 20 OR (CategoryID IN (1, 2, 3));

SELECT ProductName, UnitPrice, CategoryID
FROM Products
WHERE UnitPrice >= 5 AND UnitPrice <= 20 OR (CategoryID = 1 OR CategoryID = 2 OR CategoryID = 3);

-- Seleccionar los empleados con numero de trabajador entre 3 y 7
-- y que no trabajan en londres y seattle
SELECT * FROM Employees

SELECT (FirstName + ' ' + LastName) as [Nombre Completo], EmployeeID as [Numero de Empleado], City as [Ciudad]
FROM Employees
WHERE EmployeeID BETWEEN 3 AND 7 AND NOT City IN ('London', 'Seattle');

SELECT (FirstName + ' ' + LastName) as [Nombre Completo], EmployeeID as [Numero de Empleado], City as [Ciudad]
FROM Employees
WHERE EmployeeID >= 3 AND EmployeeID <=7 AND (City <> 'Seattle' AND City <> 'London');

-- CLAUSULA LIKE
-- Patrones
-- 1) % (porcentaje) - representa 0 o más caracteres en el patrón de búsqueda
-- 2) _ (guion bajo) - representa exactamente un caracter en el patrón de búsqueda
-- 3) [] (corchetes) - se utiliza para definir un conjunto de caracteres buscando cualquiera de ellos en la posición específica
-- 4) [^] (Asento circunflejo) - Se utiliza para buscar caracteres que no están dentro del conjunto específico

-- Buscar los productos que comienzan con "Cha"

SELECT ProductName, UnitPrice
FROM Products
WHERE ProductName LIKE 'Cha%' AND UnitPrice = 18;

-- Buscar todos los productos que terminen con E
SELECT ProductName, UnitPrice
FROM Products
WHERE ProductName LIKE '%E';

-- Seleccionar todos los clientes cuyo nombre, empresa contiene la palabra "co" en cualquier posición

SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%co%';

-- Seleccionar los empleados cuyo nombre comience con "A" y tenga exactamente 5 caracteres
SELECT FirstName
FROM Employees
WHERE FirstName LIKE 'A%____';