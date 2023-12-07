CREATE DATABASE IvBetoAlfaSolutions

USE IvBetoAlfaSolutions

CREATE TABLE Alumno(
IdAlumno INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50),
Genero BIT,
Edad INT,
IdBeca INT FOREIGN KEY REFERENCES Becas(IdBeca)
)

CREATE TABLE Becas(
IdBeca INT PRIMARY KEY IDENTITY(1,1),
NombreBeca VARCHAR(40)
)

INSERT INTO Becas VALUES('Cultural')
INSERT INTO Becas VALUES('Deportiva')
INSERT INTO Becas VALUES('Ninguna')

SELECT * FROM Becas

INSERT INTO Alumno VALUES('Ivan Beto',1,18,2)

SELECT Alumno.IdAlumno,
		Alumno.Nombre,
		Alumno.Edad,
		Alumno.Genero,
		Becas.IdBeca,
		Becas.NombreBeca
FROM Alumno INNER JOIN Becas
ON Alumno.IdBeca = Becas.IdBeca

/*
CREATE TABLE AlumnoBeca(
IdAlumno INT FOREIGN KEY REFERENCES Alumno(IdAlumno),
IdBeca INT FOREIGN KEY REFERENCES Becas(IdBeca)
)

DROP TABLE AlumnoBeca
DROP TABLE Alumno
*/