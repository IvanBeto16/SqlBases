CREATE DATABASE JBLeenkenGroup

USE JBLeenkenGroup

CREATE TABLE CatEntidadFederativa(
IdEntidad INT PRIMARY KEY IDENTITY(1,1),
Estado VARCHAR(100) 
);

CREATE TABLE Empleado(
IdEmpleado INT PRIMARY KEY IDENTITY(1,1),
NumeroNomina VARCHAR(10) NOT NULL,
Nombre VARCHAR(100) NOT NULL,
ApellidoPaterno VARCHAR(100) NOT NULL,
ApellidoMaterno VARCHAR(100) NOT NULL,
IdEntidad INT NOT NULL,
FOREIGN KEY (IdEntidad) REFERENCES CatEntidadFederativa(IdEntidad)
);

INSERT INTO CatEntidadFederativa(Estado) VALUES('Veracruz')
INSERT INTO CatEntidadFederativa(Estado) VALUES('CDMX')
INSERT INTO CatEntidadFederativa(Estado) VALUES('Aguascalientes')
INSERT INTO CatEntidadFederativa(Estado) VALUES('Monterrey')
INSERT INTO CatEntidadFederativa(Estado) VALUES('Oaxaca')


INSERT INTO Empleado(NumeroNomina, Nombre, ApellidoPaterno, ApellidoMaterno, IdEntidad) VALUES('12345','Justino', 'Alarcon', 'De la Torre', '1')
INSERT INTO Empleado(NumeroNomina, Nombre, ApellidoPaterno, ApellidoMaterno, IdEntidad) VALUES('54321','Ivan', 'Beto', 'Perez', '1')


SELECT * FROM Empleado JOIN CatEntidadFederativa
ON Empleado.IdEntidad = CatEntidadFederativa.IdEntidad

SELECT * FROM CatEntidadFederativa

UPDATE Empleado SET IdEntidad = 2 WHERE IdEmpleado = 3

DELETE FROM Empleado WHERE IdEmpleado = 5
DELETE FROM CatEntidadFederativa WHERE IdEntidad = 8