--TRIGGERS

-- DELETE, PUDATE, INSERT

-- Aplicable en Tablas y Vistas

----- Sintáxis -----
--CREATE OR ALTER TRIGGER nom_Trigger
--ON nom_Tabla
--AFTER | FROM   INSERT | UPDATE | DELETE
--AS
--BEGIN
--END

USE BDEJEMPLO2
GO
-- Realizar un trigger que se dispare cuando se inserte un pedido y
-- modifique el stock del prodcuto vendido, verificar si hay sificiente
-- stock, si no se cancela el pedido.

CREATE OR ALTER TRIGGER TG_PedidosInsertar
ON Pedidos
AFTER INSERT
AS
BEGIN
	DECLARE @existencia INT
	DECLARE @fab CHAR(3)
	DECLARE @prod CHAR(5)
	DECLARE @cantidad INT

	SELECT @fab = fab, @prod = producto, @cantidad = cantidad
	FROM INSERTED

	SELECT @existencia = Stock
	FROM Productos
	WHERE Id_fab = @fab AND Id_producto = @prod

	IF @existencia > (SELECT Cantidad FROM INSERTED)
	BEGIN
		UPDATE Productos
		SET Stock = Stock - @cantidad
		WHERE Id_fab = @fab AND Id_producto = @prod
	END

	ELSE
	BEGIN
		RAISERROR ('No hay suficiente stock para el pedido', 16, 1)
		ROLLBACK
	END
END



SELECT *
FROM Pedidos

SELECT MAX (Num_Pedido)
FROM Pedidos

SELECT *
FROM Productos

DECLARE @importe MONEY
SELECT @importe = (Pedidos.Cantidad * Productos.Precio)
FROM Pedidos
INNER JOIN Productos
ON Pedidos.Fab = Productos.Id_fab
AND Pedidos.Producto = Productos.Id_producto


INSERT INTO Pedidos (Num_Pedido, Fecha_Pedido, Cliente, Rep, Fab, Producto, Cantidad, Importe)
VALUES (113071, GETDATE(), 2103, 106, 'ACI', '41001', 77, @importe)

SELECT *
FROM Productos
WHERE Id_fab = 'ACI' AND Id_producto = '41001'

SELECT *
FROM Pedidos
WHERE Num_Pedido = 113071

GO
--Crear un trigger que cada vez que se elimine un pedido se debe actualizar el stock
-- de los productos con la cantidad eliminada

CREATE OR ALTER TRIGGER TG_PedidosEliminar
ON Pedidos
AFTER DELETE
AS
BEGIN
	DECLARE @existencia INT
	DECLARE @fab CHAR(3)
	DECLARE @prod CHAR(5)
	DECLARE @cantidad INT

	SELECT @fab = fab, @prod = producto, @cantidad = cantidad
	FROM DELETED

	SELECT @existencia = Stock
	FROM Productos
	WHERE Id_fab = @fab AND Id_producto = @prod

	IF @existencia > (SELECT Cantidad FROM DELETED)
	BEGIN
		UPDATE Productos
		SET Stock = Stock + @cantidad
		WHERE Id_fab = @fab AND Id_producto = @prod
	END

	ELSE
	BEGIN
		RAISERROR ('No se ha efectuado la actualización', 16, 1)
		ROLLBACK
	END
END



DELETE FROM Pedidos
WHERE Num_Pedido = 113071

SELECT *
FROM Pedidos
WHERE Num_Pedido = 113071

SELECT *
FROM Productos
WHERE Id_fab = 'ACI' AND Id_producto = '41001'