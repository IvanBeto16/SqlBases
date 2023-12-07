CREATE DATABASE IvBetoPruebaTecnicaDos

USE IvBetoPruebaTecnicaDos


CREATE TABLE Confederacion(
IdConfederacion INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(30)
)

INSERT INTO Confederacion VALUES('CONCACAF') --America del Norte
INSERT INTO Confederacion VALUES('UEFA') --Europa
INSERT INTO Confederacion VALUES('CONMEBOL') --America del Sur
INSERT INTO Confederacion VALUES('CAF') --Africa
INSERT INTO Confederacion VALUES('AFC') --Asia
INSERT INTO Confederacion VALUES('OFC') --Oceania

CREATE PROCEDURE ConfedGetAll
AS
	SELECT Confederacion.IdConfederacion,
			Confederacion.Nombre
	FROM Confederacion


CREATE TABLE Liga(
IdLiga INT PRIMARY KEY IDENTITY(1,1),
NombreLiga VARCHAR(60),
Pais VARCHAR(30),
IdConfederacion INT FOREIGN KEY REFERENCES Confederacion(IdConfederacion),
)

CREATE PROCEDURE LigaAdd
@NombreLiga VARCHAR(60),
@Pais VARCHAR(30),
@IdConfederacion INT,
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Liga VALUES(@NombreLiga,@Pais,@IdConfederacion)
	SET @filasInsertadas = @@ROWCOUNT



CREATE PROCEDURE LigaUpdate
@IdLiga INT,
@NombreLiga VARCHAR(60),
@Pais VARCHAR(30),
@IdConfederacion INT,
@filasActualizadas INT OUTPUT
AS
	UPDATE Liga SET NombreLiga=@NombreLiga,
	Pais=@Pais,IdConfederacion=@IdConfederacion
	WHERE IdLiga=@IdLiga
	SET @filasActualizadas = @@ROWCOUNT


CREATE PROCEDURE LigaDelete
@IdLiga INT,
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Liga
	WHERE IdLiga=@IdLiga
	SET @filasEliminadas = @@ROWCOUNT


CREATE PROCEDURE LigaGetAll
AS
	SELECT Liga.IdLiga,
			Liga.NombreLiga,
			Liga.Pais,
			Confederacion.IdConfederacion,
			Confederacion.Nombre
	FROM Liga INNER JOIN Confederacion
	ON Liga.IdConfederacion = Confederacion.IdConfederacion

CREATE PROCEDURE LigaGetByConfed 3
@IdConfederacion INT
AS
	SELECT Liga.IdLiga,
			Liga.NombreLiga,
			Liga.Pais,
			Confederacion.IdConfederacion,
			Confederacion.Nombre
	FROM Liga INNER JOIN Confederacion
	ON Liga.IdConfederacion = Confederacion.IdConfederacion
	WHERE Liga.IdConfederacion = @IdConfederacion


CREATE PROCEDURE LigaGetById
@IdLiga INT
AS
	SELECT Liga.IdLiga,
			Liga.NombreLiga,
			Liga.Pais,
			Confederacion.IdConfederacion,
			Confederacion.Nombre
	FROM Liga INNER JOIN Confederacion
	ON Liga.IdConfederacion = Confederacion.IdConfederacion
	WHERE Liga.IdLiga = @IdLiga


CREATE TABLE Equipo(
IdEquipo INT PRIMARY KEY IDENTITY(1,1),
NombreEquipo VARCHAR(60),
AnioFundacion INT,
CiudadSede VARCHAR(50),
Estadio VARCHAR(50),
TitulosNacionales INT,
TitulosInternacionales INT,
IdLiga INT FOREIGN KEY REFERENCES Liga(IdLiga)
)

CREATE PROCEDURE EquipoAdd
@NombreEquipo VARCHAR(60),
@AnioFundacion INT,
@CiudadSede VARCHAR(50),
@Estadio VARCHAR(50),
@TitulosNacionales INT,
@TitulosInternacionales INT,
@IdLiga INT,
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Equipo VALUES(@NombreEquipo,@AnioFundacion,
	@CiudadSede,@Estadio,@TitulosNacionales,@TitulosInternacionales,
	@IdLiga)
	SET @filasInsertadas = @@ROWCOUNT


CREATE PROCEDURE EquipoUpdate
@IdEquipo INT,
@NombreEquipo VARCHAR(60),
@AnioFundacion INT,
@CiudadSede VARCHAR(50),
@Estadio VARCHAR(50),
@TitulosNacionales INT,
@TitulosInternacionales INT,
@IdLiga INT,
@filasActualizadas INT OUTPUT
AS
	UPDATE Equipo SET
	NombreEquipo=@NombreEquipo,AnioFundacion=@AnioFundacion,
	CiudadSede=@CiudadSede,Estadio=@Estadio,TitulosNacionales=@TitulosNacionales,
	TitulosInternacionales=@TitulosInternacionales,IdLiga=@IdLiga
	WHERE IdEquipo = @IdEquipo
	SET @filasActualizadas = @@ROWCOUNT


CREATE PROCEDURE EquipoDelete
@IdEquipo INT,
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Equipo 
	WHERE IdEquipo = @IdEquipo
	SET @filasEliminadas = @@ROWCOUNT

CREATE PROCEDURE EquipoGetAll
AS
	SELECT Equipo.IdEquipo,
			Equipo.NombreEquipo,
			Equipo.AnioFundacion,
			Equipo.CiudadSede,
			Equipo.Estadio,
			Equipo.TitulosNacionales,
			Equipo.TitulosInternacionales,
			Liga.IdLiga,
			Liga.NombreLiga
	FROM Equipo INNER JOIN Liga
	ON Equipo.IdLiga = Liga.IdLiga


CREATE PROCEDURE EquipoGetById
@IdEquipo INT
AS
	SELECT Equipo.IdEquipo,
			Equipo.NombreEquipo,
			Equipo.AnioFundacion,
			Equipo.CiudadSede,
			Equipo.Estadio,
			Equipo.TitulosNacionales,
			Equipo.TitulosInternacionales,
			Liga.IdLiga,
			Liga.NombreLiga
	FROM Equipo INNER JOIN Liga
	ON Equipo.IdLiga = Liga.IdLiga
	WHERE IdEquipo = @IdEquipo