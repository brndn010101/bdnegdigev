USE BDEJEMPLO2;

--1
SELECT Clientes.Limite_Credito, Clientes.Empresa, Representantes.Nombre as [Nombre Representante]
FROM Clientes
INNER JOIN Representantes
ON Clientes.Rep_Cli = Representantes.Num_Empl
WHERE Limite_Credito > 5000
ORDER BY Limite_Credito DESC;

--2
SELECT Pedidos.Cantidad, Pedidos.Importe, Clientes.Empresa
FROM Pedidos
INNER JOIN Clientes
ON Clientes.Num_Cli = Pedidos.Cliente
WHERE Pedidos.Cantidad > 100 OR Pedidos.Importe > 5000;

--3
SELECT Oficinas.Region, Oficinas.Ciudad, Representantes.Nombre
FROM Oficinas
INNER JOIN Representantes
ON Representantes.Num_Empl = Oficinas.Jef
WHERE Region IN ('Este', 'Oeste');

--4
SELECT Oficinas.Ciudad, Representantes.Nombre, Clientes.Empresa
FROM Clientes 
INNER JOIN Representantes
ON Clientes.Rep_Cli = Representantes.Num_Empl
INNER JOIN Oficinas
ON Oficinas.Oficina = Representantes.Oficina_Rep
WHERE Oficinas.Ciudad IN ('Navarra', 'Castellón', 'Daimiel');

--5
SELECT Clientes.Limite_Credito, Clientes.Empresa, Representantes.Nombre as [Nombre Representante]
FROM Clientes
INNER JOIN Representantes
ON Clientes.Rep_Cli = Representantes.Num_Empl
ORDER BY Clientes.Limite_Credito DESC;

--6
SELECT Pedidos.Cantidad, Clientes.Empresa, Representantes.Nombre as [Nombre Representante]
FROM Clientes
INNER JOIN Pedidos
ON Clientes.Num_Cli = Pedidos.Cliente
INNER JOIN Representantes
ON Clientes.Rep_Cli = Representantes.Num_Empl
WHERE Pedidos.Cantidad > 3;

--7
SELECT Representantes.Nombre, Oficinas.Ciudad, SUM (Pedidos.Importe) as 'Ventas Totales'
FROM Representantes
INNER JOIN Oficinas
ON Representantes.Oficina_Rep = Oficinas.Oficina
INNER JOIN Pedidos
ON Pedidos.Rep = Representantes.Num_Empl
GROUP BY Representantes.Nombre, Oficinas.Ciudad
HAVING SUM (Pedidos.Importe) > 10000;

--8
SELECT COUNT (Representantes.Oficina_Rep) as [Número de Representantes], Oficinas.Region
FROM Representantes
INNER JOIN Oficinas
ON Oficinas.Oficina = Representantes.Oficina_Rep
GROUP BY (Oficinas.Region)
HAVING COUNT (Representantes.Oficina_Rep) > 3;

--9
SELECT Productos.Stock, Pedidos.Fab, Productos.Descripcion
FROM Productos
INNER JOIN Pedidos
ON Productos.Id_producto = Pedidos.Producto
WHERE Productos.Stock < 50
ORDER BY Productos.Stock DESC;

--10
SELECT Clientes.Empresa, Representantes.Nombre, Oficinas.Ciudad, SUM (Pedidos.Cantidad) as [Número de Pedidos]
FROM Clientes
INNER JOIN Pedidos
ON Clientes.Num_Cli = Pedidos.Cliente
INNER JOIN Representantes
ON Representantes.Num_Empl = Clientes.Rep_Cli
INNER JOIN Oficinas
ON Oficinas.Oficina = Representantes.Oficina_Rep
GROUP BY Clientes.Empresa, Representantes.Nombre, Oficinas.Ciudad
HAVING SUM (Pedidos.Cantidad) > 3;