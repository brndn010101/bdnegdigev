# Ejercicio de pedidos con Store Procedures

- Realizar un pedido, validar que el pedido no exista, validar que el cliente, el empleado y producto exista, validar que la cantidad a vender tenga suficiente stock, insertar el pedido y calcular el importe (multiplicando el precio del producto por cantidad vendida). Actualizar el stock del producto(restando el stock menos la cantidad vendida)

```sql
use BDEJEMPLO2
GO

create or alter procedure SP_Pedido
@numPedido int, @cliente int,
@repre int, @fab char(3),
@producto char(5), @cantidad int
AS
Begin
   if exists (select 1 from Pedidos where Num_Pedido = @numPedido)
   begin
      print 'El pedido ya existe'
      return
   end

   if not exists (select 1 from Clientes where Num_Cli = @cliente) or
      not exists (select 1 from Representantes where Num_Empl = @repre) or
      not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto)
   begin
      print 'Los datos no son validos'
      return
   end

   if @cantidad <= 0
   begin
     print 'La cantidad no puede ser 0 o negativo'
     return;
   end

   declare @stockValido int
   select @stockValido = Stock from Productos where Id_fab = @fab and Id_producto =@producto

   if @cantidad > @stockValido
   begin
      print 'No hay suficiente stock'
      return;
   end

   declare @precio money
   declare @importe money

   select @precio=Precio from Productos where Id_fab = @fab and Id_producto = @producto
   set @importe = @cantidad * @precio
   


   BEGIN TRY

   --Se insert� un pedido
   insert into Pedidos
   values(@numPedido, getDate(), @cliente, @repre, @fab, @producto, @cantidad,@importe)
	UPDATE Productos
	set Stock = Stock - @cantidad
	where Id_fab = @fab AND Id_producto = @producto
   END TRY


   BEGIN CATCH
   print 'Error al actualizar datos'
   return
   END CATCH
   
end;
```

## Pruebas

```sql
SELECT * FROM Productos
WHERE Id_fab = 'ACI' and Id_producto = '4100X'

EXEC SP_Pedido @numPedido = 113070, @cliente = 2117, @repre = 101, @fab = 'ACI', @producto = '4100X', @cantidad = 20
```