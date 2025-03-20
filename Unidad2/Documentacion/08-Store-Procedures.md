# 08 - Creación de Store Procedures

```sql
USE Northwind;
GO;
-- STORE PROCEDURES
CREATE OR ALTER PROCEDURE SPU_Mostrar_Clientes
AS
BEGIN
SELECT *
FROM Customers
END;

--EJECUTAR UN STORE EN TRANSACT
EXECUTE SPU_Mostrar_Clientes
GO



-- Crear un SP que muestre los clientes por pa�s ------------------------------------
-- Par�metros de entrada
CREATE OR ALTER PROCEDURE SPU_Customers_Country
@pais nvarchar(15)
AS
BEGIN
SELECT *
FROM Customers
WHERE Country = @pais
END;
GO

EXECUTE SPU_Customers_Country 'Germany'

GO

CREATE OR ALTER PROCEDURE SPU_Customers_Country
@pais nvarchar(15),
@pais2 nvarchar(15)
AS
BEGIN
SELECT *
FROM Customers
WHERE Country IN (@pais, @pais2)
END;
GO

--Ejecuci�n 1
EXECUTE SPU_Customers_Country 'Germany', 'Mexico'
GO

--Ejecuci�n 2
DECLARE @pais nvarchar(15) = 'Mexico';
DECLARE @pais2 nvarchar(15) = 'Spain';

EXECUTE SPU_Customers_Country @pais, @pais2
GO
------------------------------------------------------------------------------------





-- Generar un reporte de compra que permita visualizar los datos de compra de un
-- determinado cliente, en un rango de fechas, mostrando el monto total de compras
-- por producto, mediante un SP. Agrupar por producto

SELECT Customers.CustomerID, Customers.CompanyName, Products.ProductName,
SUM([Order Details].UnitPrice * [Order Details].Quantity) AS MontoT, Orders.OrderDate
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Products
ON [Order Details].ProductID = Products.ProductID
GROUP BY Customers.CustomerID, Customers.CompanyName, Products.ProductName, Orders.OrderDate;
GO

CREATE OR ALTER VIEW View_ReporteCompras
AS
SELECT Customers.CustomerID, Customers.CompanyName, Products.ProductName,
SUM([Order Details].UnitPrice * [Order Details].Quantity) AS MontoT, Orders.OrderDate
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Products
ON [Order Details].ProductID = Products.ProductID
GROUP BY Customers.CustomerID, Customers.CompanyName, Products.ProductName, Orders.OrderDate;
GO

CREATE OR ALTER PROCEDURE SPU_ReporteCompras
@customerid nchar(5),
@orderdate1 datetime,
@orderdate2 datetime
AS
BEGIN
SELECT View_ReporteCompras.ProductName, SUM(View_ReporteCompras.MontoT) AS MontoTotal
FROM View_ReporteCompras
WHERE View_ReporteCompras.CustomerID = @customerid AND (View_ReporteCompras.OrderDate BETWEEN @orderdate1 AND @orderdate2)
GROUP BY View_ReporteCompras.ProductName;
END;
GO

DECLARE @customerid nchar(5) = 'AROUT';
DECLARE @orderdate1 datetime = '15-11-1996';
DECLARE @orderdate2 datetime = '15-11-1996';
EXECUTE SPU_ReporteCompras @customerid, @orderdate1, @orderdate2;
GO


USE Northwind
GO

-- SP con par�metros de entrada
CREATE OR ALTER PROCEDURE SP_InfoVentas2
@nombre NVARCHAR(40),
@fecha1 DATETIME,
@fecha2 DATETIME
AS
BEGIN
SELECT SellsInfo.ProductName, SellsInfo.CompanyName, SUM (SellsInfo.Importe) as Monto
FROM SellsInfo
WHERE SellsInfo.CompanyName = @nombre
AND SellsInfo.RequiredDate BETWEEN @fecha1 AND @fecha2
GROUP BY SellsInfo.ProductName, SellsInfo.CompanyName
END
GO

SELECT * FROM Customers

EXECUTE SP_InfoVentas2 'Berglunds Snabbk�p', '07-04-1996', '01-01-1997'
GO


CREATE OR ALTER PROCEDURE SP_InfoVentas2
@nombre NVARCHAR(40) = 'Berglunds Snabbk�p',
@fecha1 DATETIME,
@fecha2 DATETIME
AS
BEGIN
SELECT SellsInfo.ProductName, SellsInfo.CompanyName, SUM (SellsInfo.Importe) as Monto
FROM SellsInfo
WHERE SellsInfo.CompanyName = @nombre
AND SellsInfo.RequiredDate BETWEEN @fecha1 AND @fecha2
GROUP BY SellsInfo.ProductName, SellsInfo.CompanyName
END
GO

EXECUTE SP_InfoVentas2 @fecha1 = '07-04-1996', @fecha2 = '01-01-1997'
GO




-- SP con par�metros en diferente posici�n

CREATE OR ALTER PROCEDURE SP_InfoVentas2
@nombre NVARCHAR(40),
@fecha1 DATETIME,
@fecha2 DATETIME
AS
BEGIN
SELECT SellsInfo.ProductName, SellsInfo.CompanyName, SUM (SellsInfo.Importe) as Monto
FROM SellsInfo
WHERE SellsInfo.CompanyName = @nombre
AND SellsInfo.RequiredDate BETWEEN @fecha1 AND @fecha2
GROUP BY SellsInfo.ProductName, SellsInfo.CompanyName
END
GO

SELECT * FROM Customers

EXECUTE SP_InfoVentas2 @fecha2 = '01-01-1997', @nombre = 'Berglunds Snabbk�p', @fecha1 = '07-04-1996'

-----------------------------------------------------------------
-- Store Procedure con par�metros de salida----------------------
USE Northwind
GO;

CREATE OR ALTER PROCEDURE SP_ObtenerNumeroClientes
@totalCustomers int output
AS
BEGIN
 SELECT @totalCustomers = COUNT (*) from Customers;
END;
 GO;

 DECLARE @num int;
 EXECUTE SP_ObtenerNumeroClientes @totalCustomers = @num output
 print @num;
 GO

 --------------------------------------------------------------------
 CREATE OR ALTER PROCEDURE SP_ObtenerNumeroClientes
@customerID nchar(5),
@totalCustomers int output
AS
BEGIN
 SELECT @totalCustomers = COUNT (*) from Customers
 WHERE CustomerID = @customerID
END;
 GO;

 DECLARE @num int;
 EXECUTE SP_ObtenerNumeroClientes @customerID = 'ANATR', @totalCustomers = @num output
 print @num;
 GO



--Crear un SP que permita saber si un alumno aprob� o reprob�
CREATE OR ALTER PROCEDURE SP_CompararCalificacion
@calif decimal (10,2)
AS
BEGIN
	if @calif > 0 AND @calif<=10
	BEGIN
		if @calif >= 8
		print 'La califiaci�n es aprobatoria'
		else
		print 'La calificaci�n es reprobatoria'
	END
	else print 'Calificaci�n no v�lida'
END;
GO

EXECUTE SP_CompararCalificacion @calif = 7.9
GO;

--- Crear un SP que permita verififcar si un cliente existe antes de devolver su informaci�n

CREATE OR ALTER PROCEDURE SP_ObtenerClientesExistentes
@numCliente nvarchar(5)
AS
BEGIN
 if exists (select 1 from Customers where CustomerID = @numCliente)
 select * from Customers where CustomerID = @numCliente;
 else print 'No existe el cliente'
END;
 GO;

 EXECUTE SP_ObtenerClientesExistentes @numCliente = 'AROUT'
 GO

 Select * from Customers
 select 1 from Customers where CustomerID = 'AROUT'
 GO;


 --CREAR un SP que permita insertar un cliente pero se debe verificar primero que no exista

SELECT *
FROM Customers
GO

CREATE OR ALTER PROCEDURE SP_ObtenerClientesExistentes
@numClienteE NVARCHAR(5),
@nomClienteE NVARCHAR(40)
AS
BEGIN
	IF exists (SELECT CustomerID FROM Customers WHERE CustomerID = @numClienteE)
		BEGIN
			PRINT 'Ya existe el cliente'
		END
	ELSE
		BEGIN
			INSERT INTO Customers (CustomerID, CompanyName)
			VALUES (@numClienteE, @nomClienteE);
		END
END;

GO

EXECUTE SP_ObtenerClientesExistentes @numClienteE = 'AROUT', @nomClienteE = 'ALFREDS FUTTERKISTE'
EXECUTE SP_ObtenerClientesExistentes @numClienteE = 'BRNDN', @nomClienteE = 'Brandon Corp'

EXECUTE SP_ObtenerClientesExistentes @numClienteE = 'BRNDO', @nomClienteE = 'Brando Corp'


EXECUTE SP_ObtenerClientesExistentes @numClienteE = 'AROUT', @nomClienteE = 'IIIII'
GO;
---------------------------------------------------------------------------------------------------





USE Northwind;
GO
 --CREAR un SP que permita insertar un cliente pero se debe verificar primero que no exista
 CREATE OR ALTER PROCEDURE SP_AgrgarCliente
 @clienteID NVARCHAR(5),
 @nombreCliente NVARCHAR (40),
 @city NVARCHAR (15) = 'San Miguel'
 AS
 BEGIN
 IF EXISTS (SELECT CustomerID FROM Customers WHERE CustomerID = @clienteID)
	BEGIN
		PRINT ('El cliente ya existe')
		RETURN 1
	END
	INSERT INTO Customers (CustomerID, CompanyName)
	VALUES (@clienteID, @nombreCliente)
	PRINT ('Cliente insertado exitosamente')
	RETURN 0
 END

  EXECUTE SP_AgrgarCliente 'AROUT', 'Juan Jaleas'
 EXECUTE SP_AgrgarCliente 'JUANJ', 'Juan Jaleas'
 GO
 -------------------------------------------------------------------------------------------

  CREATE OR ALTER PROCEDURE SP_AgrgarClienteTRYCATCH
 @clienteID NVARCHAR(5),
 @nombreCliente NVARCHAR (40),
 @city NVARCHAR (15) = 'San Miguel'
 AS
 BEGIN
	BEGIN TRY
			INSERT INTO Customers (CustomerID, CompanyName)
			VALUES (@clienteID, @nombreCliente)
			PRINT ('Cliente insertado exitosamente')
	END TRY
	BEGIN CATCH
			PRINT ('El cliente ya existe')
	END CATCH
 END

   EXECUTE SP_AgrgarCliente 'AROUT', 'Juan Jaleas'
   EXECUTE SP_AgrgarCliente 'PEDRO', 'Pedro Mayonesas'

GO
-----
-- Manejo de ciclos en SP
--Imprimir el n�mero de veces que indique el usuario}
CREATE OR ALTER PROCEDURE SPU_ImprimirNumeros
@num int
AS 
BEGIN
BEGIN
IF (@num <=0)
PRINT ('El numero no puede ser 0 o negativo')
RETURN
END
	DECLARE @i INT
	SET @i = 1
	WHILE (@i <= @num)
	BEGIN
		PRINT CONCAT ('El valor numero ', @i)
		SET @i = @i +1
	END
END

GO

EXECUTE SPU_ImprimirNumeros 10
GO 

CREATE OR ALTER PROCEDURE SP_ImprimirNumeros
    @num INT
AS
BEGIN
    -- Validaci�n para evitar n�meros negativos o cero
    IF (@num <= 0)
    BEGIN
        PRINT 'El n�mero no puede ser 0 o negativo'
        RETURN
    END

    DECLARE @i INT = 1

    WHILE (@i <= @num)
    BEGIN
        PRINT 'El valor n�mero ' + CAST(@i AS VARCHAR(10))
        SET @i = @i + 1
    END
END
GO

-- Ejecutar el procedimiento con un valor de 10
EXECUTE SP_ImprimirNumeros 10



```