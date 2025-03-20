# 06 - Query Ejemplo Left Join

```sql
-- Ejemplo de Left JOIN Aplicado
SELECT *
FROM [New Products]

-- Carga Full
SELECT Products.ProductID, Products.ProductName, Customers.CompanyName,Categories.CategoryName,
[Order Details].UnitPrice, Products.Discontinued, GETDATE()
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

INSERT INTO [New Products]
SELECT Products.ProductID, Products.ProductName, Customers.CompanyName,Categories.CategoryName,
[Order Details].UnitPrice, Products.Discontinued, GETDATE()
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

SELECT *
FROM [New Products]

DROP TABLE [New Products]

--Crear una tabla a partir de una consulta
SELECT Products.ProductID, Products.ProductName, Customers.CompanyName,Categories.CategoryName,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
INTO [New Products]
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

SELECT *
FROM [New Products]

-- Crear la tabla con solo la estructura
SELECT TOP 0 Products.ProductID, Products.ProductName, Customers.CompanyName,Categories.CategoryName,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
INTO [New Products]
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

SELECT *
FROM [New Products]

--Nombres de Columna
SELECT TOP 0 Products.ProductID as [ProductID], Products.ProductName as [Product],
Customers.CompanyName as Customer ,Categories.CategoryName as Category,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
INTO [New Products]
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

SELECT *
FROM [New Products]

DROP TABLE [New Products]


SELECT TOP 0 0 as [ProductBK], Products.ProductID as [ProductID], Products.ProductName as [Product],
Customers.CompanyName as Customer ,Categories.CategoryName as Category,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
INTO [New Products]
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

SELECT *
FROM [New Products]

USE Northwind;

DROP TABLE [New Products]

SELECT TOP 0 0 as [ProductBK], Products.ProductID as [ProductID], Products.ProductName as [Product],
Customers.CompanyName as Customer ,Categories.CategoryName as Category,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
INTO [New Products]
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

SELECT * FROM [New Products]

ALTER TABLE [New Products]
ADD CONSTRAINT PK_NewProdcuts
PRIMARY KEY (ProductBK)

DROP TABLE [New Products]

SELECT TOP 0 Products.ProductID as [ProductID], Products.ProductName as [Product],
Customers.CompanyName as Customer ,Categories.CategoryName as Category,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
INTO [New Products]
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

ALTER TABLE [New Products]
ADD ProductoBK int not null

ALTER TABLE [New Products]
ADD CONSTRAINT PK_NewProducts
PRIMARY KEY (ProductoBK)

INSERT INTO [New Products] (ProductID, [Product], Customer, Category, UnitPrice, Discontinued, InsertedDate)
SELECT Products.ProductID as [ProductID], Products.ProductName as [Product],
Customers.CompanyName as Customer ,Categories.CategoryName as Category,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

SELECT * FROM [New Products]





-- CREACI�N FINAL

DROP TABLE [New Products]

SELECT TOP 0 Products.ProductID as [ProductID], Products.ProductName as [Product],
Customers.CompanyName as Customer ,Categories.CategoryName as Category,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
INTO [New Products]
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

ALTER TABLE [New Products]
ADD ProductBK int not null IDENTITY (1,1)

ALTER TABLE [New Products]
ADD CONSTRAINT PK_NewProducts
PRIMARY KEY (ProductBK)

INSERT INTO [New Products] (ProductID, [Product], Customer, Category, UnitPrice, Discontinued, InsertedDate)
SELECT Products.ProductID as [ProductID], Products.ProductName as [Product],
Customers.CompanyName as Customer ,Categories.CategoryName as Category,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

SELECT * FROM [New Products]



SELECT [New Products].ProductID, [New Products].[Product], [New Products].Customer, [New Products].Category,
[New Products].UnitPrice, [New Products].Discontinued, [New Products].InsertedDate, Products.ProductID, Products.ProductName
FROM Products
INNER JOIN [New Products]
ON Products.ProductID = [New Products].ProductID
WHERE ProductName = 'Elote Feliz'

SELECT [New Products].ProductID, [New Products].[Product], [New Products].Customer, [New Products].Category,
[New Products].UnitPrice, [New Products].Discontinued, [New Products].InsertedDate, Products.ProductID, Products.ProductName
FROM Products
INNER JOIN [New Products]
ON Products.ProductID = [New Products].ProductID

SELECT [New Products].ProductID, [New Products].[Product], [New Products].Customer, [New Products].Category,
[New Products].UnitPrice, [New Products].Discontinued, [New Products].InsertedDate, Products.ProductID, Products.ProductName
FROM Products
LEFT JOIN [New Products]
ON Products.ProductID = [New Products].ProductID
WHERE ProductName = 'Elote Feliz'

SELECT [New Products].ProductID, [New Products].[Product], [New Products].Customer, [New Products].Category,
[New Products].UnitPrice, [New Products].Discontinued, [New Products].InsertedDate, Products.ProductID, Products.ProductName
FROM Products
LEFT JOIN [New Products]
ON Products.ProductID = [New Products].ProductID
WHERE [New Products].ProductID is null


--Carga Delta
INSERT INTO [New Products] (ProductID, [Product], Customer, Category, UnitPrice, Discontinued, InsertedDate)
SELECT Products.ProductID as [ProductID], Products.ProductName as [Product],
Customers.CompanyName as Customer ,Categories.CategoryName as Category,
[Order Details].UnitPrice, Products.Discontinued, GETDATE() as 'InsertedDate'
FROM Products
LEFT JOIN Categories
ON Products.CategoryID = Categories.CategoryID
LEFT JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
LEFT JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
LEFT JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
LEFT JOIN [New Products]
ON [New Products].ProductID = Products.ProductID
WHERE [New Products].ProductID is null;

SELECT * FROM [New Products]


-- Ejemplos
SELECT TOP 10 *
INTO Products2
FROM Products

SELECT * FROM Products
SELECT * FROM Products2

SELECT *
FROM Products
INNER JOIN Products2
ON Products.ProductID = Products2.ProductID

SELECT *
FROM Products
LEFT JOIN Products2
ON Products.ProductID = Products2.ProductID

SELECT *
FROM Products
RIGHT JOIN Products2
ON Products.ProductID = Products2.ProductID
```