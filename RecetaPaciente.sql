CREATE DATABASE IvbetoNetCore

USE IvbetoNetCore

CREATE TABLE Paciente(
IdPaciente INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50) NOT NULL ,
ApellidoPaterno VARCHAR(50) NOT NULL,
ApellidoMaterno VARCHAR(50)
)



CREATE TABLE Receta(
IdReceta INT PRIMARY KEY IDENTITY(1,1),
IdPaciente INT FOREIGN KEY REFERENCES Paciente(IdPaciente),
FechaConsulta DATE NOT NULL,
Diagnostico VARCHAR(100) NOT NULL,
NombreMedico VARCHAR(50) NOT NULL,
NotasAdicionales VARCHAR(250)
)

CREATE PROCEDURE PacienteAdd
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50)
AS
INSERT INTO Paciente 
VALUES (@Nombre,@ApellidoPaterno,@ApellidoMaterno)


CREATE PROCEDURE PacienteUpdate '2','Mayra','Cruz','Bravo'
@IdPaciente INT,
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50)
AS
	UPDATE Paciente
	SET Nombre = @Nombre, ApellidoPaterno = @ApellidoPaterno,
	ApellidoMaterno = @ApellidoMaterno
	WHERE IdPaciente = @IdPaciente



CREATE PROCEDURE PacienteDelete
@IdPaciente INT
AS
	DELETE FROM Paciente
	WHERE IdPaciente = @IdPaciente


CREATE PROCEDURE PacienteGetAll
AS
	SELECT Paciente.IdPaciente,
			Paciente.Nombre,
			Paciente.ApellidoPaterno,
			Paciente.ApellidoMaterno
	 FROM Paciente


CREATE PROCEDURE PacienteGetById
@IdPaciente INT
AS
	SELECT Paciente.IdPaciente,
			Paciente.Nombre,
			Paciente.ApellidoPaterno,
			Paciente.ApellidoMaterno
	 FROM Paciente
	 WHERE IdPaciente = @IdPaciente


ALTER PROCEDURE RecetaAdd
@IdPaciente INT,
@FechaConsulta VARCHAR(12),
@Diagnostico VARCHAR(100),
@NombreMedico VARCHAR(50),
@NotasAdicionales VARCHAR(250)
AS
INSERT INTO Receta 
VALUES (@IdPaciente,CONVERT(DATE,@FechaConsulta,23),@Diagnostico,
@NombreMedico, @NotasAdicionales)

CREATE PROCEDURE RecetaDelete
@IdReceta INT
AS
DELETE FROM Receta
WHERE IdReceta = @IdReceta

ALTER PROCEDURE RecetaUpdate
@IdReceta INT,
@IdPaciente INT,
@FechaConsulta VARCHAR(12),
@Diagnostico VARCHAR(100),
@NombreMedico VARCHAR(50),
@NotasAdicionales VARCHAR(250)
AS
	UPDATE Receta SET
	IdPaciente = @IdPaciente,
	FechaConsulta = CONVERT(DATE,@FechaConsulta,23),
	Diagnostico = @Diagnostico,
	NombreMedico = @NombreMedico,
	@NotasAdicionales = @NotasAdicionales
	WHERE IdReceta = @IdReceta

ALTER PROCEDURE RecetaGetAll
AS
	SELECT Receta.IdReceta,
			Receta.IdPaciente,
			Receta.FechaConsulta,
			Receta.Diagnostico,
			Receta.NombreMedico,
			Receta.NotasAdicionales,
			Paciente.Nombre AS NombrePaciente,
			Paciente.ApellidoPaterno AS ApellidoPaternoPaciente,
			Paciente.ApellidoMaterno AS ApellidoMaternoPaciente
	FROM Receta
	INNER JOIN Paciente 
	ON Receta.IdPaciente = Paciente.IdPaciente


ALTER PROCEDURE RecetaGetById
@IdReceta INT
AS
	SELECT Receta.IdReceta,
			Receta.IdPaciente,
			Receta.FechaConsulta,
			Receta.Diagnostico,
			Receta.NombreMedico,
			Receta.NotasAdicionales,
			Paciente.Nombre AS NombrePaciente,
			Paciente.ApellidoPaterno AS ApellidoPaternoPaciente,
			Paciente.ApellidoMaterno AS ApellidoMaternoPaciente
	FROM Receta
	INNER JOIN Paciente 
	ON Receta.IdPaciente = Paciente.IdPaciente
	WHERE IdReceta = @IdReceta


CREATE PROCEDURE RecetaGetByPaciente
@IdPaciente INT
AS
	SELECT Receta.IdReceta,
			Receta.IdPaciente,
			Receta.FechaConsulta,
			Receta.Diagnostico,
			Receta.NombreMedico,
			Receta.NotasAdicionales,
			Paciente.Nombre AS NombrePaciente,
			Paciente.ApellidoPaterno AS ApellidoPaternoPaciente,
			Paciente.ApellidoMaterno AS ApellidoMaternoPaciente
	FROM Receta
	INNER JOIN Paciente 
	ON Receta.IdPaciente = Paciente.IdPaciente
	WHERE Receta.IdPaciente = @IdPaciente


