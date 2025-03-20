# Ejemplo Inner Join Left Join

```sql
USE PruebaJoins;
--INNER JOIN
SELECT Categorias.categoriaid, Categorias.nombre, Productos.categoriaid, Productos.productoid, Productos.nombre
FROM Categorias
INNER JOIN Productos
ON Categorias.categoriaid = Productos.categoriaid;

--LEFT JOIN
SELECT Categorias.categoriaid, Categorias.nombre, Productos.categoriaid, Productos.productoid, Productos.nombre
FROM Categorias
LEFT JOIN Productos
ON Categorias.categoriaid = Productos.categoriaid;

--LEFT JOIN Invertida
SELECT Categorias.categoriaid, Categorias.nombre, Productos.categoriaid, Productos.productoid, Productos.nombre
FROM Productos
LEFT JOIN Categorias
ON Categorias.categoriaid = Productos.categoriaid;


```