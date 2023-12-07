CREATE DATABASE IvBetoExamenBlazor

USE IvBetoExamenBlazor


CREATE TABLE Categoria(
IdCategoria INT PRIMARY KEY IDENTITY(1,1),
NombreCategoria VARCHAR(50)
)

CREATE TABLE Producto(
IdProducto INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(20),
Precio FLOAT,
IdCategoria INT FOREIGN KEY REFERENCES Categoria(IdCategoria)
)

INSERT INTO Categoria VALUES('Abarrotes')
INSERT INTO Categoria VALUES('Carnes y Pescados')
INSERT INTO Categoria VALUES('Bebidas y Licores')
INSERT INTO Categoria VALUES('Lacteos')
INSERT INTO Categoria VALUES('Panaderia')
INSERT INTO Categoria VALUES('Frutas y Verduras')

SELECT * 
FROM Producto 
JOIN Categoria
ON Producto.IdCategoria = Categoria.IdCategoria
WHERE Nombre LIKE '%e%'

SELECT * FROM Categoria