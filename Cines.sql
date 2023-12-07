CREATE DATABASE IvBetoCine

USE IvBetoCine


CREATE TABLE Zona(
IdZona INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(10)
)

CREATE PROCEDURE ZonaGetAll
AS
	SELECT IdZona, Nombre
	FROM Zona

CREATE TABLE Cine(
IdCine INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(30) NOT NULL,
Direccion VARCHAR(50),
IdZona INT FOREIGN KEY REFERENCES Zona(IdZona),
Ventas INT
)

ALTER TABLE Cine
ALTER COLUMN Nombre VARCHAR(150)

ALTER TABLE Cine
ALTER COLUMN Direccion VARCHAR(550)

INSERT INTO Zona VALUES('Norte')
INSERT INTO Zona VALUES('Sur')
INSERT INTO Zona VALUES('Este')
INSERT INTO Zona VALUES('Oeste')

INSERT INTO Cine VALUES ('Cinemex Galerias Coapa','Coapa',4,250124980)
INSERT INTO Cine VALUES ('Cinepolis Oasis Coyoacan','Coyoacan',2,194382980)

ALTER PROCEDURE CineGetAll
AS
	SELECT Cine.IdCine,
			Cine.Nombre,
			Cine.Direccion,
			Cine.Ventas,
			Zona.IdZona,
			Zona.Nombre AS NombreZona
	FROM Cine 
	INNER JOIN Zona ON Cine.IdZona = Zona.IdZona

CineGetAll
SELECT ROUND(SUM(Ventas),2) FROM Cine  --1,087,811,461 Ventas Totales de las tiendas
SELECT SUM(Ventas) FROM Cine WHERE Cine.IdZona = 3 --571,279,333 (52%)   194,382,980 (5.5%)  14,237,534

ALTER PROCEDURE CineAdd
@Nombre VARCHAR(30),
@Direccion VARCHAR(550),
@IdZona INT,
@Ventas INT
AS
	INSERT INTO Cine
	VALUES(@Nombre,@Direccion,@IdZona,@Ventas)


ALTER PROCEDURE CineUpdate
@IdCine INT,
@Nombre VARCHAR(30),
@Direccion VARCHAR(550),
@IdZona INT,
@Ventas INT
AS
	UPDATE Cine SET
	Nombre = @Nombre, Direccion = @Direccion,
	IdZona = @IdZona, Ventas = @Ventas
	WHERE IdCine = @IdCine


CREATE PROCEDURE CineDelete 4
@IdCine INT
AS
	DELETE FROM Cine
	WHERE IdCine = @IdCine

CREATE PROCEDURE CineGetById
@IdCine INT
AS
	SELECT Cine.IdCine,
			Cine.Nombre,
			Cine.Direccion,
			Cine.Ventas,
			Zona.IdZona,
			Zona.Nombre AS NombreZona
	FROM Cine 
	INNER JOIN Zona ON Cine.IdZona = Zona.IdZona
	WHERE Cine.IdCine = @IdCine

	--Tabla para la dulceria

	CREATE TABLE Producto(
	IdProducto INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(70),
	Descripcion VARCHAR(200),
	Precio MONEY,
	Imagen VARCHAR
	)

	DROP TABLE Producto


INSERT INTO Producto VALUES('Palomitas','Palomitas Clásicas de tamaño variable, puedes escoger entre los sabores disponibles',60.00,NULL)
INSERT INTO Producto VALUES('Refresco','Bebida de sabor Coca-Cola, puedes elegir el tamaño de tu bebido y de demás sabores-', 20.00,NULL)
INSERT INTO Producto VALUES('Chocolates','Dulces variables y chocolates para acompañar tu visita en el cine', 20.00,NULL)
INSERT INTO Producto VALUES('Nachos','Nachos de Fritura Tostitos con queso líquido y chiles o no al gusto.',25.00,NULL)
INSERT INTO Producto VALUES('Helados ICE','Raspados frescos de marca ICE, puedes elegir su sabor, son de tamaño grande todos.', 60.00,NULL)
INSERT INTO Producto VALUES('Combo Amigos','Combo de Palomitas Grandes de Mantequilla más un par de Bebidas Coca-cola, unos nachos y un HotDog', 95.00,NULL)
INSERT INTO Producto VALUES('Combo Pareja','Combo de una Palomitas Grandes de Mantequilla más un par de Bebidas Grandes Coca-cola y dulces', 85.00,NULL)
INSERT INTO Producto VALUES('Combo con Nachos','Combo de Palomitas Grandes de Mantequilla con un par de Nachos con chile y queso.', 90.00,NULL)
INSERT INTO Producto VALUES('Combo Chill','Combo de Palomitas Grandes de Mantequilla con Bebida Coca-Cola y un chocolate al gusto.', 70.00,NULL)


CREATE PROCEDURE ProductoGetAll
AS
	SELECT IdProducto,
			Nombre,
			Descripcion,
			Precio,
			Imagen
	FROM Producto 

CREATE PROCEDURE ProductoGetById 2
@IdProducto INT
AS
	SELECT IdProducto,
			Nombre,
			Descripcion,
			Precio,
			Imagen
	FROM Producto
	WHERE IdProducto = @IdProducto

ALTER TABLE Producto
ALTER COLUMN Imagen VARCHAR(MAX)


INSERT INTO Producto VALUES('Combo Amigos','Combo de Palomitas Grandes de Mantequilla más un par de Bebidas Coca-cola, unos nachos y un HotDog', 95.00,NULL)

ProductoGetAll

UPDATE Producto SET Imagen = 'https://images-na.ssl-images-amazon.com/images/I/41C5IDA0kbL._AC_UL210_SR210,210_.jpg'
WHERE IdProducto = 3


CREATE TABLE Usuario(
Username VARCHAR(20),
Nombre VARCHAR(70),
Email VARCHAR(30),
Password VARBINARY(20)
)

--DROP TABLE Usuario

CREATE PROCEDURE UsuarioGetByEmail 'betoivan16p@yahoo.com.mx'
@Email VARCHAR(30)
AS
	SELECT Usuario.Username,
			Usuario.Nombre,
			Usuario.Email,
			Usuario.Password
	FROM Usuario WHERE Usuario.Email = @Email


ALTER PROCEDURE UsuarioUpdatePassword
@Email VARCHAR(30),
@Password VARCHAR(MAX)
AS
	UPDATE Usuario SET Password = @Password
	WHERE Email = @Email


ALTER PROCEDURE UsuarioAdd
@Username VARCHAR(20),
@Nombre VARCHAR(70),
@Email VARCHAR(30),
@Password VARCHAR(MAX)
AS
	INSERT INTO Usuario
	VALUES(@Username,@Nombre,@Email,@Password)


SELECT * FROM Usuario

ALTER TABLE Usuario
ALTER COLUMN Password VARCHAR(MAX)

