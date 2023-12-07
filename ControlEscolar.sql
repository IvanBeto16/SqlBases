CREATE DATABASE IvbetoControlEscolar

USE IvbetoControlEscolar


CREATE TABLE Alumno(
IdAlumno INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50),
ApellidoPaterno VARCHAR(50),
ApellidoMaterno VARCHAR(50)
)


CREATE TABLE Materia(
IdMateria INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50),
Costo FLOAT
)

INSERT INTO Materia VALUES('Computacion Grafica', '250.00')
INSERT INTO Materia VALUES('Matematicas Avanzadas', '40.00')
INSERT INTO Materia VALUES('Estructuras de Datos y Algoritmos', '40.00')
INSERT INTO Materia VALUES('Quimica Organica', '80.00')
INSERT INTO Materia VALUES('Bases de Datos Avanzadas', '130.00')
INSERT INTO Materia VALUES('Inteligencia Artificial', '450.00')
INSERT INTO Materia VALUES('Desarrollo Web', '160.00')
INSERT INTO Materia VALUES('Teoria de la Historia', '30.00')
INSERT INTO Materia VALUES('Calculo Vectorial', '50.00')

CREATE PROCEDURE MateriaGetAll
AS
	SELECT IdMateria,Nombre,Costo
	FROM Materia


ALTER PROCEDURE MateriaGetById
@IdMateria INT
AS
	SELECT IdMateria, Nombre, Costo
	FROM Materia
	WHERE IdMateria = @IdMateria



ALTER PROCEDURE MateriaAdd
@Nombre VARCHAR(50),
@Costo FLOAT,
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Materia
	VALUES (@Nombre,@Costo)
	SET @filasInsertadas = @@ROWCOUNT


ALTER PROCEDURE MateriaUpdate
@IdMateria INT,
@Nombre VARCHAR(50),
@Costo FLOAT,
@filasActualizadas INT OUTPUT
AS
	UPDATE Materia SET
	Nombre = @Nombre, Costo = @Costo
	WHERE IdMateria = @IdMateria  
	SET @filasActualizadas = @@ROWCOUNT


ALTER PROCEDURE MateriaDelete
@IdMateria INT,
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Materia
	WHERE IdMateria = @IdMateria
	SET @filasEliminadas = @@ROWCOUNT


INSERT INTO Alumno VALUES('Scarlet','Garcia','Sanchez')
INSERT INTO Alumno VALUES('Ivan','Beto','Perez')
INSERT INTO Alumno VALUES('Eduardo','Moreno','Callejas')
INSERT INTO Alumno VALUES('Veronica','Zamora','Perez')
INSERT INTO Alumno VALUES('Josue','Gomez','Gonzalez')
INSERT INTO Alumno VALUES('Christian','Aguillon','Castellanos')
INSERT INTO Alumno VALUES('Roberto Carlos','Mosqueda','Angulo')
INSERT INTO Alumno VALUES('Hector','Ruiz','Terron')
INSERT INTO Alumno VALUES('Violeta','Aviles','Rivera')

CREATE PROCEDURE AlumnoGetAll
AS
	SELECT Alumno.IdAlumno,
			Alumno.Nombre,
			Alumno.ApellidoPaterno,
			Alumno.ApellidoMaterno
	FROM Alumno

CREATE PROCEDURE AlumnoAdd
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50)
AS
	INSERT INTO Alumno
	(Nombre, ApellidoPaterno, ApellidoMaterno)
	VALUES (@Nombre, @ApellidoPaterno, @ApellidoMaterno)


CREATE PROCEDURE AlumnoUpdate
@IdAlumno INT,
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50)
AS
	UPDATE Alumno SET
	Nombre = @Nombre, ApellidoPaterno = @ApellidoPaterno,
	ApellidoMaterno = @ApellidoMaterno
	WHERE IdAlumno = @IdAlumno

CREATE PROCEDURE AlumnoDelete '13'
@IdAlumno INT
AS
	DELETE FROM Alumno
	WHERE IdAlumno = @IdAlumno


CREATE PROCEDURE AlumnoGetById
@IdAlumno INT
AS
	SELECT Alumno.IdAlumno,
			Alumno.Nombre,
			Alumno.ApellidoPaterno,
			Alumno.ApellidoMaterno
	FROM Alumno
	WHERE IdAlumno = @IdAlumno


CREATE TABLE AlumnoMateria(
IdAlumno INT NOT NULL FOREIGN KEY REFERENCES Alumno(IdAlumno),
IdMateria INT NOT NULL FOREIGN KEY REFERENCES Materia(IdMateria),
PRIMARY KEY(IdAlumno,IdMateria)
)

CREATE PROCEDURE AlumnoMateriaAdd
@IdAlumno INT,
@IdMateria INT,
@filasInsertadas INT OUTPUT
AS
	INSERT INTO AlumnoMateria
	VALUES(@IdAlumno,@IdMateria)
	SET @filasInsertadas = @@ROWCOUNT



CREATE PROCEDURE AlumnoMateriaDelete '3','7',null
@IdAlumno INT,
@IdMateria INT,
@filasInsertadas INT OUTPUT
AS
	DELETE FROM AlumnoMateria
	WHERE IdMateria = @IdMateria AND
	IdAlumno = @IdAlumno


CREATE PROCEDURE AlumnoMateriaUpdate
@IdAlumno INT,
@IdMateria INT,
@filasActualizadas INT OUTPUT
AS
	UPDATE AlumnoMateria
	SET IdMateria = @IdMateria
	WHERE IdAlumno = @IdAlumno


ALTER PROCEDURE GetMateriaAsignada '2'
@IdAlumno INT
AS
	SELECT Materia.IdMateria,
			Materia.Nombre,
			Materia.Costo
	FROM Materia 
	INNER JOIN AlumnoMateria 
	ON AlumnoMateria.IdMateria = Materia.IdMateria
	WHERE AlumnoMateria.IdAlumno = @IdAlumno
	


AlumnoMateriaAdd '1','4',null
AlumnoMateriaAdd '2','4',null
AlumnoMateriaAdd '1','2',null
AlumnoMateriaAdd '3','7',null
AlumnoMateriaAdd '4','5',null
AlumnoMateriaAdd '2','1',null

--------------------------------------PENDIENTE----------------------------------
SELECT Alumno.IdAlumno,
			Alumno.Nombre,
			Alumno.ApellidoPaterno,
			Alumno.ApellidoMaterno,
			Materia.IdMateria,
			Materia.Nombre,
			Materia.Costo
	FROM Alumno
	INNER JOIN AlumnoMateria
	ON Alumno.IdAlumno = AlumnoMateria.IdAlumno
	INNER JOIN Materia
	ON AlumnoMateria.IdMateria = Materia.IdMateria
	WHERE AlumnoMateria.IdAlumno = '1' 
	AND AlumnoMateria.IdMateria NOT IN (SELECT IdMateria FROM Materia)




CREATE PROCEDURE GetMateriaNoAsignada '1'
@IdAlumno INT
AS
	SELECT Alumno.IdAlumno,
			Alumno.Nombre,
			Alumno.ApellidoPaterno,
			Alumno.ApellidoMaterno,
			Materia.IdMateria,
			Materia.Nombre,
			Materia.Costo
	FROM Alumno
	INNER JOIN AlumnoMateria
	ON Alumno.IdAlumno = AlumnoMateria.IdAlumno
	INNER JOIN Materia
	ON AlumnoMateria.IdMateria = Materia.IdMateria
	WHERE Alumno.IdAlumno = @IdAlumno
	AND AlumnoMateria.IdMateria NOT IN (SELECT IdMateria FROM Materia)
	
--------------------------------------PENDIENTE----------------------------------

SELECT * FROM AlumnoMateria
SELECT * FROM Materia


CREATE PROCEDURE GetMateriaNoAsignada '3'
@IdAlumno INT
AS
SELECT Materia.IdMateria,
		Materia.Nombre,
		Materia.Costo
FROM Materia
WHERE IdMateria NOT IN (SELECT IdMateria
						FROM AlumnoMateria 
						WHERE IdAlumno = @IdAlumno)