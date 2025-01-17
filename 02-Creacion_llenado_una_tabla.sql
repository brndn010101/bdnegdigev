--Creación de la BD de tienda1

--Crea la BD de tienda1

CREATE DATABASE tienda1;

--Utilizar una BD

USE tienda1;

--SQL LDD
--Crear tabla categoría

CREATE TABLE categoria(
categoriaid int not null,
nombre varchar (20) not null,
constraint pk_categoria
primary key (categoriaid),
constraint unico_nombre
unique (nombre)
);

--SQL LMD
--Agregar registros a la tabla categoría

INSERT INTO categoria
VALUES (1, 'Carnes Frias');

INSERT INTO categoria(categoriaid, nombre)
VALUES (2, 'Linea Blanca');

INSERT INTO categoria(nombre, categoriaid)
VALUES ('Vinos y Licores', 3);

INSERT INTO categoria
VALUES (4, 'Ropa'),
       (5, 'Dulces'),
	   (6, 'Lacteos');

INSERT INTO categoria(nombre, categoriaid)
VALUES ('Panaderia', 7),
       ('Zapateria', 8),
	   ('Jugueteria',9);

INSERT INTO categoria
values (10, 'Panaderia');

SELECT * FROM categoria;