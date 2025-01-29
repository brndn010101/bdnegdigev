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