USE Northwind
--Ejercicio 1
CREATE OR ALTER VIEW V_pedidosCE
AS
SELECT Customers.CompanyName, CONCAT (Employees.FirstName, ' ' ,Employees.LastName) as EmployeeName, Orders.OrderDate,
Orders.RequiredDate, Orders.Freight
FROM Orders
INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN Customers
ON Customers.CustomerID = Orders.CustomerID

SELECT *
FROM V_pedidosCE

GO
--Ejercicio 2
CREATE OR ALTER VIEW V_detallesPC
AS
SELECT DISTINCT Categories.CategoryName, Products.ProductName, [Order Details].Quantity, [Order Details].UnitPrice,
SUM ([Order Details].Quantity * [Order Details].UnitPrice) as Importe
FROM [Order Details]
INNER JOIN Products
ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName, Products.ProductName, [Order Details].Quantity, [Order Details].UnitPrice

SELECT *
FROM V_detallesPC



--3
CREATE OR ALTER PROCEDURE SP_RegistrarNuevoPedido
@customerID NCHAR(5),
@employeeID INT,
@orderDate DATETIME,
@requiredDate DATETIME,
@ship INT,
@freight MONEY

AS
BEGIN

	IF NOT EXISTS (SELECT 1
			       FROM Customers
			       WHERE CustomerID = @customerID)
	BEGIN
		PRINT 'El cliente no existe'
		RETURN -1;
	END

	IF NOT EXISTS (SELECT 1
			       FROM Employees
			       WHERE EmployeeID = @employeeID)
	BEGIN
		PRINT 'El empleado no existe'
		RETURN -2
	END

	IF @orderDate > @requiredDate
	BEGIN
		PRINT 'Fecha de entrega no v�lida'
		RETURN -3;
	END

	BEGIN TRY
		INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShipVia, Freight)
		VALUES (@customerID, @employeeID, @orderDate, @requiredDate, @ship, @freight)
	END TRY


	BEGIN CATCH
		PRINT 'Error al ingresar pedido'
		RETURN -4;
	END CATCH

END

SELECT *
FROM Customers

SELECT *
FROM Employees

EXECUTE SP_RegistrarNuevoPedido @customerID = 'ALFKI', @employeeID = 1, @orderDate = '2025-03-20', @requiredDate = '23-01-2014', @ship = 1, @freight = 40


SELECT GETDATE()