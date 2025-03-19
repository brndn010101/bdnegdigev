-- Funciones de cadena
-- Permite maipular tipos de datos como varchar, nvarchar, char, nchar



-- Función LEN -> Devuelve la longitud de una cadena
-- Declaración de una variables

-- Primera forma de declarar variables
DECLARE @texto varchar(50) = 'Hola Mundo!';
-- Obtener el tamaño de la cadena almacenada en la variable texto
SELECT LEN(@texto) as Lenght;

-- Segunda forma de declarar variabes
DECLARE @numero int;
SET @numero = 10;
PRINT @numero;

USE Northwind;
SELECT CompanyName, LEN(CompanyName) as LenghtCompanyName
FROM Customers



-- Funcion LEFT
-- Extrae un número específico de caracteres desde el incio de la cadena
SELECT LEFT(@texto, 4) as Inicio
-- Función RIGHT
-- Extrae un número determinado de caracteres del final de la cadena
SELECT RIGHT(@texto, 6) as Final

SELECT CompanyName, LEN(CompanyName) as LengthCompanyName,
LEFT(CompanyName, 4) as Inicio,
RIGHT(CompanyName, 6) as Final
FROM Customers

-- SUBSTRING -> Extrae una parte de la cadena, donde el segundo parametro es la posición inicial
-- y el tercer parámetro el recorrido
DECLARE @texto2 varchar(50) = 'Hola Mundo!';
SELECT SUBSTRING (@texto2, 6, 5) as LengthMundo;

SELECT CompanyName, LEN(CompanyName) as LengthCompanyName,
LEFT(CompanyName, 4) as Inicio,
RIGHT(CompanyName, 6) as Final,
SUBSTRING (CompanyName, 7, 4)
FROM Customers

-- REPLACE -> Reemplaza una subcadena por otra
DECLARE @texto3 varchar(50) = 'Hola Mundo!';
SELECT REPLACE (@texto3, 'Mundo', 'Amigo') as ReemplazoMundo;

-- CHARINEX
DECLARE @texto4 varchar(50) = 'Hola Mundo!';
SELECT CHARINDEX ('Mundo', @texto4) as Position;

-- UPPER -> Convierte una cadena en mayúsculas
SELECT UPPER (@texto4) as Mayusculas

DECLARE @texto5 varchar(50) = 'Hola Mundo!';
SELECT CONCAT (LEFT(@texto5, 5),' ',UPPER (SUBSTRING(@texto5, 6, 5)), RIGHT(@texto5, 1)) as TextoNuevo

UPDATE Customers
SET CompanyName = UPPER(CompanyName)
WHERE Country IN ('Mexico', 'Germany')

SELECT CompanyName
FROM Customers

-- TRIM -> Quita espacios en blanco de una cadena
SELECT TRIM ('    test    ') AS Result;
DECLARE @texto6 varchar(50) = '   Hola Mundo!  ';
SELECT TRIM (@texto6) AS Result
SELECT LTRIM (@texto6) AS Result
SELECT RTRIM (@texto6) AS Result
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