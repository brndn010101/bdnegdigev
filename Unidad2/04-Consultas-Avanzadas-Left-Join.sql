USE Northwind;

SELECT * FROM Categories;
SELECT * FROM Products;

SELECT Categories.CategoryName, Categories.CategoryID, Products.CategoryID, Products.ProductName
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID
WHERE Categories.CategoryName = 'Fast Food';

SELECT Categories.CategoryName, Categories.CategoryID, Products.CategoryID, Products.ProductName
FROM Products
LEFT JOIN Categories
ON Categories.CategoryID = Products.CategoryID
WHERE Products.CategoryID is null;

INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
VALUES ('Hamburguesa', 1, 9, 'XYZ', 68.7, 45, 12, 2, 0);

INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
VALUES ('Guaracha', 1, Null, 'XYZ', 68.7, 45, 12, 2, 0);

DELETE Products
WHERE CategoryID = 9;

-- Listar los empleados y los pedidos que han gestionado incluyendo los empleados que no han hecho pedido

SELECT Employees.FirstName, Orders.OrderID, Orders.EmployeeID
FROM Orders
LEFT JOIN Employees
ON Employees.EmployeeID = Orders.EmployeeID;

-- Mostrar los productos que no tienen categoría
SELECT Products.ProductName, Categories.CategoryName
FROM Products
LEFT JOIN Categories
ON Categories.CategoryID = Products.CategoryID;

--Utilización de Left Join
-- Seleccionar los datos que se van a utilizar para insertar en la tabla
-- New Products
-- ProductID, ProductName, Customer, Category, UnitPrice, Discontinued, InsertDate

SELECT *
FROM [New Products];