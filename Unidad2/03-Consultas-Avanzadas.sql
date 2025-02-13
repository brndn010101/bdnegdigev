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