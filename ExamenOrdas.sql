CREATE DATABASE IvbetoExamenOrdas

USE IvbetoExamenOrdas

CREATE TABLE Producto(
IdProducto INT PRIMARY KEY IDENTITY(1,1),
DescripcionProducto VARCHAR(100) NOT NULL,
Precio MONEY NOT NULL,
Cantidad INT,
Activo INT
)

CREATE TABLE Departamento(
IdDepartamento INT PRIMARY KEY IDENTITY(1,1),
DescripcionDepartamento VARCHAR(100) NOT NULL,
Activo INT
)

CREATE TABLE ProductoDepartamento(
IdProducto INT FOREIGN KEY REFERENCES Producto(IdProducto),
IdDepartamento INT FOREIGN KEY REFERENCES Departamento(IdDepartamento)
)

ALTER TABLE Producto
ALTER COLUMN Activo INT NOT NULL

ALTER TABLE Departamento
ALTER COLUMN Activo INT NOT NULL

INSERT INTO Departamento VALUES('Lacteos','1')
INSERT INTO Departamento VALUES('Sopas','1')
INSERT INTO Departamento VALUES('Carnes','1')
INSERT INTO Departamento VALUES('Panaderia','1')
INSERT INTO Departamento VALUES('Higiene','1')
INSERT INTO Departamento VALUES('Automoviles','0')
INSERT INTO Departamento VALUES('Botanas','1')
INSERT INTO Departamento VALUES('Bebidas','1')
INSERT INTO Departamento VALUES('Frutas','1')

INSERT INTO Producto VALUES('Papel Higienico 40Rollos','125','26','1') --Higiene
INSERT INTO Producto VALUES('Coca Cola 3L','38','250','1') --Bebidas
INSERT INTO Producto VALUES('Maruchan Camaron','12','50','1') --Sopas
INSERT INTO Producto VALUES('Palomitas ACT II','11','160','1') -- Botanas
INSERT INTO Producto VALUES('Jamon Serrano','65','12','1') --Carnes
INSERT INTO Producto VALUES('Mortadela','39','120','1') --Carnes
INSERT INTO Producto VALUES('Cubilete','6','38','1') --Panaderia
INSERT INTO Producto VALUES('Tarta Zarzamora','6','23','1') --Panaderia
INSERT INTO Producto VALUES('Aceite Castrol','50','15','0') --Automoviles
INSERT INTO Producto VALUES('Guayaba','16','67','1') --Frutas
INSERT INTO Producto VALUES('Uva Verde','45','84','1') --Frutas
INSERT INTO Producto VALUES('Aguacate','26','90','1') --Frutas
INSERT INTO Producto VALUES('Mora Azul','16','134','1') --Frutas
INSERT INTO Producto VALUES('Frambuesa','23','0','0') --Frutas

INSERT INTO ProductoDepartamento VALUES('1','5')
INSERT INTO ProductoDepartamento VALUES('2','8')
INSERT INTO ProductoDepartamento VALUES('3','2')
INSERT INTO ProductoDepartamento VALUES('4','7')
INSERT INTO ProductoDepartamento VALUES('5','3')
INSERT INTO ProductoDepartamento VALUES('6','3')
INSERT INTO ProductoDepartamento VALUES('7','4')
INSERT INTO ProductoDepartamento VALUES('8','4')
INSERT INTO ProductoDepartamento VALUES('9','6')
INSERT INTO ProductoDepartamento VALUES('10','9')
INSERT INTO ProductoDepartamento VALUES('11','9')
INSERT INTO ProductoDepartamento VALUES('12','9')
INSERT INTO ProductoDepartamento VALUES('13','9')
INSERT INTO ProductoDepartamento VALUES('14','9')


SELECT * FROM Producto

SELECT * FROM Departamento

SELECT * FROM ProductoDepartamento


--Pregunta 1
SELECT d.DescripcionDepartamento,p.DescripcionProducto,p.Activo,p.Cantidad
FROM ProductoDepartamento pd
JOIN Producto p
ON pd.IdProducto = p.IdProducto
JOIN Departamento d
ON pd.IdDepartamento = d.IdDepartamento
WHERE d.DescripcionDepartamento = 'Frutas'
AND p.Activo = 1
AND P.Cantidad > 0
ORDER BY p.Cantidad DESC

--Pregunta 2
INSERT INTO Producto VALUES('Naranja','3','100','1') --Frutas
INSERT INTO ProductoDepartamento VALUES('15','9')

INSERT INTO Producto VALUES('Granada','9','0','1') --Frutas
INSERT INTO Producto VALUES('Platano','15','0','1') --Frutas


--Pregunta 3
UPDATE Producto SET Activo=1 WHERE Cantidad=0

--Metodo sin subconsultas
UPDATE p SET p.Activo= 0
FROM Producto AS p
JOIN ProductoDepartamento pd
ON p.IdProducto = pd.IdProducto
JOIN Departamento d
ON pd.IdDepartamento = d.IdDepartamento
AND d.DescripcionDepartamento = 'Frutas'
AND p.Cantidad = 0

--Metodo con subconsultas
UPDATE Producto SET Producto.Activo = 0
WHERE Producto.Cantidad = 0 
AND Producto.IdProducto IN (SELECT ProductoDepartamento.IdProducto 
						   FROM ProductoDepartamento 
						   WHERE ProductoDepartamento.IdDepartamento IN (SELECT Departamento.IdDepartamento
																		FROM Departamento
																		WHERE Departamento.DescripcionDepartamento = 'Frutas'))


SELECT d.DescripcionDepartamento,p.DescripcionProducto,p.Activo,p.Cantidad,p.Precio
FROM ProductoDepartamento pd
JOIN Producto p
ON pd.IdProducto = p.IdProducto
JOIN Departamento d
ON pd.IdDepartamento = d.IdDepartamento
WHERE d.DescripcionDepartamento = 'Frutas'
AND p.Cantidad = 0


--Haciendo que frutas valgan mas de 50
UPDATE Producto SET Precio=90 WHERE IdProducto=12
UPDATE Producto SET Precio=90 WHERE IdProducto=14
INSERT INTO Producto VALUES('Maracuya','99','6','1')
INSERT INTO ProductoDepartamento VALUES('16','9')
INSERT INTO ProductoDepartamento VALUES('17','9')
INSERT INTO ProductoDepartamento VALUES('18','9')
INSERT INTO ProductoDepartamento VALUES('19','9')
SELECT * FROM ProductoDepartamento

--Pregunta 4 T-SQL
SELECT d.DescripcionDepartamento,p.DescripcionProducto,p.Activo,p.Cantidad,p.Precio
FROM ProductoDepartamento pd
JOIN Producto p
ON pd.IdProducto = p.IdProducto
JOIN Departamento d
ON pd.IdDepartamento = d.IdDepartamento
WHERE d.DescripcionDepartamento = 'Frutas'
AND p.Precio > 50
AND p.Cantidad = 0


--Metodo sin subconsultas
DELETE FROM ProductoDepartamento
FROM ProductoDepartamento AS dp
JOIN Producto p
ON p.IdProducto = dp.IdProducto
JOIN Departamento d
ON dp.IdDepartamento = d.IdDepartamento
WHERE d.DescripcionDepartamento = 'Frutas'
AND p.Cantidad = 0
AND p.Precio > 50

--Metodo con subconsultas
DELETE FROM ProductoDepartamento
WHERE ProductoDepartamento.IdDepartamento IN (SELECT Departamento.IdDepartamento
											  FROM Departamento
											  WHERE Departamento.DescripcionDepartamento = 'Frutas')

AND ProductoDepartamento.IdProducto IN (SELECT Producto.IdProducto
										FROM Producto
										WHERE Producto.Precio > 50
										AND Producto.Cantidad = 0)
										


--3. Procedure para insertar en una tabla temporal

--Tabla Temporal
CREATE TABLE #Temporal(
Valor INT
);

SELECT * FROM #Temporal

TRUNCATE TABLE #Temporal

CREATE PROCEDURE TemporalInsert 
AS
	BEGIN TRY
		DECLARE @Inicio INT = 1500001;
		DECLARE @Fin INT = 1600000;
		WHILE(@Inicio <= @Fin)
		BEGIN
			INSERT INTO #Temporal(Valor) VALUES(@Inicio)
			SET @Inicio = @Inicio + 1
		END
	END TRY		
	BEGIN CATCH
		SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
	END CATCH

TemporalInsert

