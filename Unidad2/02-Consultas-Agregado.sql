USE Northwind;

-- Consulas de agregado
-- Solo devuelven un solo registro
-- sum, avg, count(*), max, min

-- Cuántos clientes tengo

SELECT COUNT (*) as 'Número de clientes'
FROM Customers;

SELECT COUNT (*) as Region
FROM Customers
WHERE Region is null;

SELECT Region
FROM Customers
WHERE Region is not null
ORDER BY Region asc;

SELECT DISTINCT Region
FROM Customers
WHERE Region is not null
ORDER BY Region asc;

SELECT COUNT (DISTINCT Region) as Region
FROM Customers
WHERE Region is not null;