# MongoDB CRUD

## Crear una Base de Datos

**Solo se crea si contiene por lo menos una colección**

```json
use basededatos
```

## Crear una colección

```
use db1
db.createCollection('Empleado')
```

## Mostrar Colecciones

```
show collections
```

## Inserción de un documento

```json
db.Empleado.insertOne(
    {
        nombre: 'Soila',
        apellido: 'Vaca',
        edad: 32,
        ciudad: 'San Miguel de las Piedras'
    }
)
```

## Inserción de un documento más complejo con Array ##

```json
db.Empleado.insertOne(
    {
        nombre: 'Ivan',
        apellido: 'Baltazar',
        apellido2: 'Rodriguez',
        aficiones: ['Cerveza', 'Canabis', 'Crico', 'Mentir']
    }
)
```

**Eliminar una colección**
```json
db.coleccion.drop()
```

 __Ejemplo__
 ```json
 db.empleado.drop()
```

## Inserción de documentos más complejos con anidados, Arrays y ID ##

```json
db.Alumnos.insertOne(
    {
        nombre: 'Jose Luis',
        apellido1: 'Herrera',
        apellido2: 'Gallardo',
        edad: 41,
        estudios: [
            'Ing. Sistemas Computacionales',
            'Maestría en Administración de TI'
        ],
        experiencia:{
                        lenguaje: 'SQL',
                        sgb: 'SQL Server',
                        aniosExperiencia: 20
                    }
    }
)
```

```json
db.Alumnos.insertOne(
    {
        _id: 3,
        nombre: 'Sergio',
        apellido: 'Ramos',
        equipo: 'Monterrey',
        aficiones:[
            'Dinero', 'Hombres', 'Fiesta'
        ],
        talentos:{
            futbol: true,
            bañarse: false
        }        
    }
)
```

## Insertar Múltiples Documentos ##
```json
db.Alumnos.insertMany(
    [
        {
            _id: 12,
            nombre: 'Oswaldo',
            apellido: 'Benavides',
            edad: 20,
            descripcion: 'Quejumbroso'
        },
        {
            nombre: 'Maritza',
            apellido: 'Rechicken',
            edad: 20,
            habilidades: ['Ser víbora', 'Ilusionar', 'Caguamear'],
            direccion: {
                calle: 'Del infierno',
                numero: 666
            },
            esposos:[
                {
                    nombre: 'Joshua X',
                    edad: 20,
                    pension: -34,
                    hijos: ['Ivan', 'Jose']
                },
                {
                    nombre: 'Leo',
                    edad: 15,
                    pension: 70,
                    complaciente: true
                }
            ]
        }        
    ]
)
```

# Busquedas. Condiciones Simpres de Igualdad Método find #

1. Seleccionar todos los documentos de la coleccion libros

```json
db.libros.find({})
```

2. Seleccionar todos los documentos que sean de la editorial  "Biblio"

```json
db.libros.find({editorial: 'Biblio'})
```

3. Mostrar todos los documentos que el precio sea 25

```json
db.libros.find({precio: 25})
```

4. Seleccionar todos los documentos donde el título sea "JSON para todos"

```json
db.libros.find({titulo: 'JSON para todos'})
```

# Operadodes de Comparación #

[Operadores de comparación](https://www.mongodb.com/docs/manual/reference/operator/query/)

![Operadores de comparación](./img/operadores-Relacionales.png)

1. Mostrar todos los documentos con el precio mayor a 25

```json
db.libros.find({precio: {$gt: 25}})
```

2. Mostrar los documentos donde el precio sea 25

```json
db.libros.find({precio: {$eq: 25}})
db.libros.find({precio: 25})

```

3. Mostrar los documentos cuya cantidad sea menor a 5

```json
db.libros.find({cantidad: {$lt: 5}})
```

4. Mostrar los documentos que pertenecen a la editorial "Biblio" o "Planeta"

```json
db.libros.find({editorial: {$in: ['Biblio', 'Planeta']}})
```
```json
db.libros.find({
    editorial: {$in: ['Biblio', 'Planeta']}
    })
```

5. Mostrar todos los documentos de libros que cuesten 20 o 25

```json
db.libros.find({
    precio: {$in: [20, 25]}
    })
```

6. Recuperar todos los documentos que no cuesten 20 o 25

```json
db.libros.find({
    precio: {$nin: [20, 25]}
    })
```

## Instrución FindOne ##

7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condición)

```json
db.libros.findOne({
    precio: {$in: [20, 25]}
    })
```

## Operadores Lógicos ##

[Operadores Lógicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

### Operador AND ($and) ##
- Dos posibles opciones

1. Forma Simple, mediante condiciones separadas por comas

```json
db.libros.find({
    condicion1, condicion2
})
```
Asume que es una AND

2. Usando el operador AND

```json
db.libros.find({
    $and: [{condicion1}, {condicion2}]
})
```

1. Mostrar todos aquellos libros que cuesten más de 25 y cuya cantidad sea menor que 15

```json
db.libros.find({
    precio: {$gt: 25},
    cantidad: {$lt: 15}
})
```

```json
db.libros.find({
    $and: [{precio: {$gt: 25}},
    {cantidad: {$lt: 15}}]
})
```

### Operador OR ($or) ##

1. Mostrar todos aquellos libros que cuesten más de 25 o cuya cantidad sea inferior a 15

```json
db.libros.find({
    $or: [{precio: {$gt: 25}},
    {cantidad: {$lt: 15}}]
})
```
### Ejemplo con AND y OR combinados

1. Mostrar todos los libros de la editorial Biblio con precio mayor a 40
o libros de la editorial Planeta con precio mayor a 30

```json
db.libros.find({
    $and: [
        {$or:[{editorial: 'Biblio'}, {precio: {$gt: 40}}]},
        {$or:[{editorial: {$eq: 'Planeta'}}, {precio: {$gt: 30}}]}
    ]
})
```

2. Mostrar todos los libros de la editorial Biblio con precio mayor a 30
o libros de la editorial Planeta con precio mayor a 20

```json
db.libros.find({
    $and: [
        {$or:[{editorial: 'Biblio'}, {precio: {$gt: 30}}]},
        {$or:[{editorial: {$eq: 'Planeta'}}, {precio: {$gt: 20}}]}
    ]
})
```

### Proyección (Ver ciertas columnas) ##

**Sintaxis**
 ```json
db.coleccion.find(filtro, columnas)
```

1. Seleccionar todos los libros solo mostrando el título

```json
db.libros.find({}, {titulo: 1})
```

```json
db.libros.find({}, {titulo: 1, _id: 0})
```

```json
db.libros.find({}, {_id: 0, titulo: 1, editorial: 1, precio: 1})
```

### Operador Exists (Permite saber si un campo se encutra dentro de un documento) ##

[Operador Exists](https://www.mongodb.com/docs/manual/reference/operator/query/exists/)

```json
db.libros.find({editorial: {$exists: true}})
```

```json
db.libros.insertOne({
    _id: 10,
    titulo: 'Mongo en Negocios Digitales',
    editorial: 'Terra',
    precio: 125
})
 ```

- Buscar todos los documentos que no tengan cantidad

```json
db.libros.find({cantidad: {$exists: true}})
```

```json
db.libros.find({cantidad: {$exists: false}})
```

### Operador Type (Permite solicitar a MongoDB si un campo corresponde a un tipo) ##

[Operador Type](https://www.mongodb.com/docs/manual/reference/operator/query/type/)

-- Mostrar todos los documentos donde el precio sea double o int o cualquier tipo de dato

```json
db.libros.find({precio: {$type: 1}})
```

```json
db.libros.find({precio: {$type: 16}})
```

```json
db.libros.find({precio: {$type: 'int'}})
```

```json
db.libros.insertMany([   
    {
        _id: 12,
        titulo: 'IA',
        editorial: 'Terra',
        precio: 125,
        cantidad: 20
    },
    {
        _id: 13,
        tutorial: 'Python para todos',
        editorial: 2001, 
        precio: 200,
        cantidad: 30
    }
    ])
```

-- Seleccionar todos los documentos de libros donde la editorial sean string

```json
db.libros.find({editorial: {$type: 2}})
```

```json
db.libros.find({editorial: {$type: 'string'}})
```

```json
db.libros.find({editorial: {$type: 'int'}})
```

# Modificando Documentos #
## Comandos importantes ##

1. updateOne -> Modifica un solo documento
2. updateMany -> Modifica múltiples documentos
3. replaceOne -> Sustituye el contenido completo de un documento

```json
db.collection.updateOne({filtro}, {operador:})
```

[Operadores Update](https://www.mongodb.com/docs/manual/reference/operator/update/)

## Operador $set ##

1. Modificsr un documento

```json
db.libros.updateOne({tutorial: 'Python para todos'}, {$set: {tutorial: 'Java para todos'}})
```

-- Modificar el documento con _id: 10 estableciendo el precio en 100 y la cantidad en 50

```json
db.libros.updateOne({_id: 10}, {$set: {precio: 100}})
db.libros.updateOne({_id: 10}, {$set: {cantidad: 50}})
```

```json
db.libros.updateOne({_id: 10}, {$set: {precio: 100, cantidad: 50}})
```

```json
db.libros.deleteOne({ catidad: 50 });
```

-- Usando updateMany modificar todos los libros donde el precio sea mayor a 100 y cambiarlo por 150

```json
db.libros.updateOne({}, {$set: {precio: 100, cantidad: 50}})
```

```json
db.libros.updateMany(
   {precio: {$gt: 100}},
   {$set: {precio: 150}},
)
```

## Operadores $inc y $mul

--Incrementar todos los precios de los libros en 5

```json
db.libros.updateMany({editorial: 'Terra'}, {$inc: {precio: 5}})
```

-- Multiplicar todos los libros donde la cantidad sea mayor a 20 en su cantidad por 2

```json
db.libros.updateMany({cantidad: {$gt: 20}}, {$mul: {cantidad: 2}})
```

```json
db.libros.find({$in: {[1, 7, 10, 13]}})
```

-- Actualizar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos donde el precio sea mayor a 20

```json
db.libros.updateMany({precio: {$gt: 20}}, {$mul: {cantidad: 2, precio: 2}})
```

## Reemplazar documentos (replaceOne)

-- Actualizar todo el documento del _id: 2 por el titulo: 'De la tierra a la luna', autor: 'Julio Verne', editorial: 'Terra', precio: 100

```json
db.libros.replaceOne({_id: 2}, {titulo: 'De la Tierra a la Luna', autor: 'Julio Verne', editorial: 'Terra', precio: 100})
```

## Borrar documentos
1. deleteOne -> Elimina un solo documento
2. deleteMany -> Elimina múltiples documentos

-- Eliminar un documento con el _id: 2

```json
db.libros.deleteOne({_id: 2})
```

-- Eliminar todos los libros donde la cantidad es mayor a 150

```json
db.libros.deleteMany({cantidad: {$gt: 150}})
```

## Expresiones Regulares

-- Seleccionar todos los libros que contengan una t minúscula en el titulo

```json
db.libros.find({titulo: /t/})
```

-- Seleccionar todos los libros que en el titulo contenga la palabra JSON

```json
db.libros.find({titulo: /JSON/})
```

--Seleccionar todos los libros que en el título terminen con tos

```json
db.libros.find({titulo: /tos$/})
```

-- Seleccionar todos los documentos que en el título comiencen con J

```json
db.libros.find({titulo: /^J/})
```

## Operador $regex

[Operador $regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

-- Seleccionar los libros que contengan la palabra 'para' en el título

```json
db.libros.find({
    titulo: {$regex: 'para'}
})
```

```json
db.libros.find({
    titulo: {$regex: /para/}
})
```

--Seleccionar todos los títulos que contengan la palabra JSON
```json
db.libros.find({
    titulo: {$regex: 'JSON'}
})
```

```json
db.libros.find({
    titulo: {$regex: /JSON/}
})
```

--Distinguir entre mayúsculas y minúsculas

```json
db.libros.find({
    titulo: {$regex: /json/i}
})
```

```json
db.libros.find({
    titulo: {$regex: /json/, $options: 'i'}
})
```

-- Seleccionar todos los documentos de libros donde el titulo inicie con j y no distinga entre mayusculas y minusculas
```json
db.libros.find({
    titulo: {$regex: /^j/, $options: 'i'}
})
```

-- Seleccionar todos los documentos de libros donde el titulo termine con es y no distinga entre mayusculas y minusculas
```json
db.libros.find({
    titulo: {$regex: /es$/, $options: 'i'}
})
```

## Metodo sort (Ordenar documentos)
--Ordenar los libros de manera ascendente por el precio
```json
db.libros.find(
    {}, {_id: 0, titulo: 1, precio: 1}
).sort({precio: 1})
```

--Ordenar los libros de manera descendente por el precio
```json
db.libros.find(
    {}, {_id: 0, titulo: 1, precio: 1}
).sort({precio: -1})
```

--Ordenar los libros de manera ascendente por la editorial y de manera descendente por el precio mostrando el titulo, precio y editorial

```json
db.libros.find(
    {}, {_id: 0, titulo: 1, editorial: 1, precio: 1}
).sort({editorial: 1, precio: -1})
```

## Skip, Limit, Size
```json
db.libros.find({}).size()
```

-- Seleccionar todos los documentos de libros donde el titulo inicie con j y no distinga entre mayusculas y minusculas
```json
db.libros.find({
    titulo: {$regex: /^j/, $options: 'i'}
}).size()
```

--Buscar todos los libros pero mostrar los dos primeros

```json
db.libros.find({}).limit(2)
```

--Skip los primeros 2
```json
db.libros.find({}).skip(2)
```

## Borrar colecciones y BD

```json
db.libros.drop()
```

```json
db.dropDatabase()
```