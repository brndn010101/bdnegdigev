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

```
db.Empleado.insertOne(
    {
        nombre: 'Soila',
        apellido: 'Vaca',
        edad: 32,
        ciudad: 'San Miguel de las Piedras'
    }
)
```