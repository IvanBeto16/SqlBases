CREATE DATABASE IvBetoKrafir

USE IvBetoKrafir


CREATE TABLE CatalogoArticulo(
CodigoArt VARCHAR(5) PRIMARY KEY,
NombreArt VARCHAR(20)
)

INSERT INTO CatalogoArticulo VALUES('A001','Nueces de la India')
INSERT INTO CatalogoArticulo VALUES('A002','Chile de Árbol chino')
INSERT INTO CatalogoArticulo VALUES('A003','Pistaches Salados')
INSERT INTO CatalogoArticulo VALUES('A004','Maíz en polvo')

SELECT * FROM CatalogoArticulo

CREATE TABLE ArticulosAlmacenes(
CodigoArt VARCHAR(5) FOREIGN KEY REFERENCES CatalogoArticulo(CodigoArt),
CodigoAlmacen INT,
NombreAlmacen VARCHAR(50),
Existencia INT,
ExistenciaMinima INT
)

TRUNCATE TABLE ArticulosAlmacenes

INSERT INTO ArticulosAlmacenes VALUES('A001',101,'Matriz',547,400)
INSERT INTO ArticulosAlmacenes VALUES('A002',101,'Matriz',829,750)
INSERT INTO ArticulosAlmacenes VALUES('A003',101,'Matriz',231,330)
INSERT INTO ArticulosAlmacenes VALUES('A004',101,'Matriz',995,775)
INSERT INTO ArticulosAlmacenes VALUES('A001',201,'Guadalajara',121,100)
INSERT INTO ArticulosAlmacenes VALUES('A002',201,'Guadalajara',204,250)
INSERT INTO ArticulosAlmacenes VALUES('A003',201,'Guadalajara',338,350)
INSERT INTO ArticulosAlmacenes VALUES('A004',201,'Guadalajara',322,300)
INSERT INTO ArticulosAlmacenes VALUES('A001',301,'Monterrey',54,50)
INSERT INTO ArticulosAlmacenes VALUES('A002',301,'Monterrey',33,30)
INSERT INTO ArticulosAlmacenes VALUES('A003',301,'Monterrey',87,95)
INSERT INTO ArticulosAlmacenes VALUES('A004',301,'Monterrey',112,125)

SELECT * FROM ArticulosAlmacenes

/*Query para punto 2*/
SELECT CatalogoArticulo.CodigoArt,
		CatalogoArticulo.NombreArt,
		ArticulosAlmacenes.NombreAlmacen,
		ArticulosAlmacenes.Existencia,
		ArticulosAlmacenes.ExistenciaMinima
FROM CatalogoArticulo INNER JOIN ArticulosAlmacenes
ON CatalogoArticulo.CodigoArt = ArticulosAlmacenes.CodigoArt
WHERE ArticulosAlmacenes.NombreAlmacen LIKE 'Guadalajara'
AND ArticulosAlmacenes.Existencia < ArticulosAlmacenes.ExistenciaMinima

SELECT DISTINCT CatalogoArticulo.CodigoArt,
		CatalogoArticulo.NombreArt	
FROM CatalogoArticulo INNER JOIN ArticulosAlmacenes
ON CatalogoArticulo.CodigoArt = ArticulosAlmacenes.CodigoArt

/*Consulta Punto 3*/
SELECT DISTINCT CatalogoArticulo.CodigoArt,
		CatalogoArticulo.NombreArt AS Articulo,
		 (SELECT SUM(Existencia) 
		 FROM ArticulosAlmacenes 
		 WHERE ArticulosAlmacenes.CodigoArt = CatalogoArticulo.CodigoArt) AS ExistenciaGlobal
FROM ArticulosAlmacenes
JOIN CatalogoArticulo ON ArticulosAlmacenes.CodigoArt = CatalogoArticulo.CodigoArt
ORDER BY CatalogoArticulo.CodigoArt


SELECT DISTINCT CatalogoArticulo.NombreArt, 
				ArticulosAlmacenes.Existencia
FROM CatalogoArticulo INNER JOIN ArticulosAlmacenes
ON CatalogoArticulo.CodigoArt = ArticulosAlmacenes.CodigoArt



CREATE TABLE Clientes(
CodigoCliente VARCHAR(5) PRIMARY KEY,
NombreCliente VARCHAR(30)
)

INSERT INTO Clientes VALUES('C001','Bruno Diaz')
INSERT INTO Clientes VALUES('C002','Clack Kent')
INSERT INTO Clientes VALUES('C003','Ricardo Tapia')

SELECT * FROM Clientes

CREATE TABLE Facturas(
NumFactura INT PRIMARY KEY IDENTITY(1,1),
CodigoCliente VARCHAR(5) FOREIGN KEY REFERENCES Clientes(CodigoCliente),
MontoTotal INT
)

TRUNCATE TABLE Facturas

INSERT INTO Facturas VALUES('C001',5201)
INSERT INTO Facturas VALUES('C001',4498)
INSERT INTO Facturas VALUES('C003',7629)
INSERT INTO Facturas VALUES('C002',1200)
INSERT INTO Facturas VALUES('C002',1459)
INSERT INTO Facturas VALUES('C001',6341)


SELECT * FROM Facturas

CREATE TABLE Pagos(
NumPago INT PRIMARY KEY IDENTITY(1,1),
CodigoCliente VARCHAR(5) FOREIGN KEY REFERENCES Clientes(CodigoCliente),
MontoTotal INT
)

INSERT INTO Pagos VALUES('C001',3500)
INSERT INTO Pagos VALUES('C003',7629)
INSERT INTO Pagos VALUES('C001',2000)
INSERT INTO Pagos VALUES('C002',1200)

SELECT * FROM Pagos


/*Consulta Punto 4*/
SELECT DISTINCT Clientes.CodigoCliente,Clientes.NombreCliente,
		(SELECT SUM(MontoTotal) FROM Facturas WHERE Facturas.CodigoCliente = Clientes.CodigoCliente) AS Cargos,
		(SELECT SUM(MontoTotal) FROM Pagos WHERE Pagos.CodigoCliente = Clientes.CodigoCliente) AS Abono,
		(SELECT (SELECT SUM(MontoTotal) 
				FROM Facturas 
				WHERE Facturas.CodigoCliente = Clientes.CodigoCliente) - (SELECT SUM(MontoTotal) 
																			FROM Pagos 
																			WHERE Pagos.CodigoCliente = Clientes.CodigoCliente)) AS Saldo
FROM Clientes INNER JOIN Facturas
ON Facturas.CodigoCliente = Clientes.CodigoCliente
INNER JOIN Pagos ON Pagos.CodigoCliente = Clientes.CodigoCliente



CREATE TABLE Pedidos(
NumPedido INT PRIMARY KEY IDENTITY(1,1),
CodigoCliente VARCHAR(5) FOREIGN KEY REFERENCES Clientes(CodigoCliente),
MontoTotal INT
)

INSERT INTO Pedidos VALUES('C001',5201)
INSERT INTO Pedidos VALUES('C001',4498)
INSERT INTO Pedidos VALUES('C001',7629)
INSERT INTO Pedidos VALUES('C002',1200)
INSERT INTO Pedidos VALUES('C002',1459)
INSERT INTO Pedidos VALUES('C001',6341)

TRUNCATE TABLE Pedidos

SELECT * FROM Facturas
SELECT * FROM Pedidos
SELECT * FROM Pagos
SELECT * FROM Clientes

SELECT SUM(MontoTotal) AS 'Total en Pedidos'
FROM Pedidos JOIN Clientes ON Pedidos.CodigoCliente = Clientes.CodigoCliente
WHERE Pedidos.CodigoCliente = 'C001'


/*Consulta punto 5*/
SELECT DISTINCT Clientes.CodigoCliente,
			Clientes.NombreCliente,
		(SELECT SUM(MontoTotal) FROM Pedidos WHERE Pedidos.CodigoCliente = Clientes.CodigoCliente) AS 'Total en Pedidos'
FROM Clientes INNER JOIN Pedidos
ON Clientes.CodigoCliente = Pedidos.CodigoCliente
ORDER BY Clientes.NombreCliente



CREATE TABLE ArticulosFactura(
NumFactura INT FOREIGN KEY REFERENCES Facturas(NumFactura),
CodigoArt VARCHAR(5) FOREIGN KEY REFERENCES CatalogoArticulo(CodigoArt),
Cantidad INT
)


INSERT INTO ArticulosFactura VALUES('1','A001',5)
INSERT INTO ArticulosFactura VALUES('1','A003',2)
INSERT INTO ArticulosFactura VALUES('2','A001',7)
INSERT INTO ArticulosFactura VALUES('3','A003',9)
INSERT INTO ArticulosFactura VALUES('3','A004',8)
INSERT INTO ArticulosFactura VALUES('3','A001',2)
INSERT INTO ArticulosFactura VALUES('4','A004',12)
INSERT INTO ArticulosFactura VALUES('5','A004',4)
INSERT INTO ArticulosFactura VALUES('6','A001',3)
INSERT INTO ArticulosFactura VALUES('6','A003',5)

SELECT * FROM ArticulosFactura

/*Consulta punto 6*/
SELECT DISTINCT CatalogoArticulo.CodigoArt,
		CatalogoArticulo.NombreArt,
		(SELECT AVG(DISTINCT Cantidad) 
		FROM ArticulosFactura 
		WHERE ArticulosFactura.CodigoArt = CatalogoArticulo.CodigoArt) AS 'Promedio Cantidad Ventas'
FROM CatalogoArticulo
INNER JOIN ArticulosFactura ON ArticulosFactura.CodigoArt = CatalogoArticulo.CodigoArt
ORDER BY CatalogoArticulo.CodigoArt


SELECT * FROM Facturas
SELECT * FROM Pagos


CREATE TABLE PagosDos(
NumPago INT PRIMARY KEY IDENTITY(1,1),
CodigoCliente VARCHAR(5) FOREIGN KEY REFERENCES Clientes(CodigoCliente),
MontoTotal INT,
NumFactura INT FOREIGN KEY REFERENCES Facturas(NumFactura)
)

TRUNCATE TABLE PagosDos

INSERT INTO PagosDos VALUES('C001',5201,1)
INSERT INTO PagosDos VALUES('C003',7629,3)
INSERT INTO PagosDos VALUES('C001',6341,6)
INSERT INTO PagosDos VALUES('C002',1459,5)

SELECT * FROM Facturas
SELECT * FROM PagosDos

/*Consulta Punto 7*/
SELECT Facturas.NumFactura,
		Facturas.CodigoCliente,
		Facturas.MontoTotal AS MontoFactura
FROM Facturas 
WHERE NOT EXISTS (SELECT * 
					FROM PagosDos 
					WHERE PagosDos.NumFactura = Facturas.NumFactura)
ORDER BY Facturas.NumFactura