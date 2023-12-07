CREATE DATABASE IvBetoMarzam
USE IvBetoMarzam


CREATE TABLE Medicamento(
IdMedicamento INT PRIMARY KEY IDENTITY(1,1),
NombreMedicina VARCHAR(100),
Precio MONEY
)


INSERT INTO Medicamento VALUES('Paracetamol',33.99)
INSERT INTO Medicamento VALUES('Ibuprofeno',54.99)
INSERT INTO Medicamento VALUES('Omeprazol',493.99)
INSERT INTO Medicamento VALUES('Amoxicilina',63.99)
INSERT INTO Medicamento VALUES('Salbutamol',69.99)
INSERT INTO Medicamento VALUES('Ivermectina',89.99)
INSERT INTO Medicamento VALUES('Aspirina',44.99)
INSERT INTO Medicamento VALUES('Dexametasona',24.99)


CREATE TABLE Usuario(
IdUsuario INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50),
Apellidos VARCHAR(60),
Username VARCHAR(50),
Password VARCHAR(50)
)


CREATE TABLE Pedido(
IdPedido INT PRIMARY KEY IDENTITY(1,1),
IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
IdMedicamento INT FOREIGN KEY REFERENCES Medicamento(IdMedicamento),
Cantidad INT,
Total INT
)


SELECT * FROM Medicamento

INSERT INTO Usuario VALUES('Ivan','Beto','ivanbeto16','contraseña')
INSERT INTO Usuario VALUES('Cristina','Ramirez','kristinichu','axloha')
INSERT INTO Usuario VALUES('Roberto','Mosqueda','andremosqueda','pumas')


DECLARE @total INT
SET @total =  (SELECT Medicamento.Precio*3 FROM Medicamento INNER JOIN Pedido
					ON Pedido.IdMedicamento = Medicamento.IdMedicamento WHERE Medicamento.IdMedicamento = 1)

--INSERT INTO Pedido VALUES('1','1',3,)
TRUNCATE TABLE Pedido

SELECT * FROM Pedido