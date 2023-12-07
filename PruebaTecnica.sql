CREATE DATABASE IvbetoPruebaTecnica

USE IvbetoPruebaTecnica


CREATE TABLE Artista(
IdArtista INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(30) NOT NULL,
AnioDebut INT,
Nacionalidad VARCHAR(50) NOT NULL
)

INSERT INTO Artista VALUES ('INNA', '2009', 'Rumana')
INSERT INTO Artista VALUES ('David Guetta', '1996', 'Francés')
INSERT INTO Artista VALUES ('Sofia Reyes', '2015', 'Mexicana')

CREATE TABLE Distribuidora(
IdDistribuidora INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50)
)

CREATE TABLE Disco(
IdDisco INT PRIMARY KEY IDENTITY(1,1),
Titulo VARCHAR(70) NOT NULL,
Duracion FLOAT NOT NULL,
Anio INT NOT NULL,
GeneroMusical VARCHAR(20),
IdDistribuidora INT FOREIGN KEY REFERENCES Distribuidora(IdDistribuidora),
IdArtista INT FOREIGN KEY REFERENCES Artista(IdArtista),
Disponibilidad INT,
Ventas INT
)

CREATE PROCEDURE DistribuidoraGetAll
AS
	SELECT IdDistribuidora,Nombre
	FROM Distribuidora

INSERT INTO Distribuidora VALUES('Youtube Music')
INSERT INTO Distribuidora VALUES('Spotify')
INSERT INTO Distribuidora VALUES('Deezer')
INSERT INTO Distribuidora VALUES('Amazon Music')
INSERT INTO Distribuidora VALUES('TikTok')
INSERT INTO Distribuidora VALUES('Pandora')
INSERT INTO Distribuidora VALUES('Youtube Music')

SELECT * FROM Distribuidora

SELECT * FROM Artista

CREATE PROCEDURE ArtistaAdd
@Nombre VARCHAR(30),
@AnioDebut INT,
@Nacionalidad VARCHAR(50),
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Artista (Nombre,AnioDebut,Nacionalidad)
	VALUES(@Nombre,@AnioDebut,@Nacionalidad)
	SET @filasInsertadas = @@ROWCOUNT


ALTER PROCEDURE ArtistaUpdate
@IdArtista INT,
@Nombre	VARCHAR(30),
@AnioDebut INT,
@Nacionalidad VARCHAR(50),
@filasActualizadas INT OUTPUT
AS
	UPDATE Artista SET
	Nombre=@Nombre, AnioDebut=@AnioDebut,
	Nacionalidad=@Nacionalidad
	WHERE IdArtista = @IdArtista
	SET @filasActualizadas = @@ROWCOUNT



CREATE PROCEDURE ArtistaDelete
@IdArtista INT,
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Artista
	WHERE IdArtista = @IdArtista
	SET @filasEliminadas = @@ROWCOUNT


CREATE PROCEDURE ArtistaGetAll
AS
	SELECT IdArtista,Nombre,AnioDebut,Nacionalidad
	FROM Artista


CREATE PROCEDURE ArtistaGetById '2'
@IdArtista INT
AS
	SELECT IdArtista,Nombre,AnioDebut,Nacionalidad
	FROM Artista WHERE IdArtista = @IdArtista


CREATE PROCEDURE DiscoAdd
@Titulo VARCHAR(70),
@Duracion FLOAT,
@Anio INT,
@GeneroMusical VARCHAR(20),
@IdDistribuidora INT,
@IdArtista INT,
@Disponibilidad INT,
@Ventas INT,
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Disco (Titulo,Duracion,Anio,GeneroMusical,IdDistribuidora,
	IdArtista,Disponibilidad,Ventas) VALUES (@Titulo,@Duracion,@Anio,@GeneroMusical,
	@IdDistribuidora,@IdArtista,@Disponibilidad,@Ventas)
	SET @filasInsertadas = @@ROWCOUNT


CREATE PROCEDURE DiscoUpdate
@IdDisco INT,
@Titulo VARCHAR(70),
@Duracion FLOAT,
@Anio INT,
@GeneroMusical VARCHAR(20),
@IdDistribuidora INT,
@IdArtista INT,
@Disponibilidad INT,
@Ventas INT,
@filasActualizadas INT OUTPUT
AS
	UPDATE Disco SET
	Titulo=@Titulo, Duracion=@Duracion, Anio=@Anio, GeneroMusical=@GeneroMusical,
	IdDistribuidora=@IdDistribuidora, IdArtista=@IdArtista, Disponibilidad= @Disponibilidad,
	Ventas=@Ventas WHERE IdDisco=@IdDisco
	SET @filasActualizadas = @@ROWCOUNT


CREATE PROCEDURE DiscoDelete
@IdDisco INT,
@filasElimindas INT OUTPUT
AS
	DELETE FROM Disco
	WHERE IdDisco = @IdDisco
	SET @filasElimindas = @@ROWCOUNT


ALTER PROCEDURE DiscoGetAll
AS
	SELECT Disco.IdDisco,
			Disco.Titulo,
			Disco.Anio,
			Disco.GeneroMusical,
			Disco.Duracion,
			Disco.Ventas,
			Disco.Disponibilidad,
			Artista.IdArtista,
			Artista.Nombre AS NombreArtista,
			Distribuidora.IdDistribuidora,
			Distribuidora.Nombre AS NombreDistribuidora
	FROM Disco 
	INNER JOIN Artista ON Disco.IdArtista = Artista.IdArtista
	INNER JOIN Distribuidora ON Disco.IdDistribuidora = Distribuidora.IdDistribuidora


ALTER PROCEDURE DiscoGetById
@IdDisco INT
AS
	SELECT Disco.IdDisco,
			Disco.Titulo,
			Disco.Anio,
			Disco.GeneroMusical,
			Disco.Duracion,
			Disco.Ventas,
			Disco.Disponibilidad,
			Artista.IdArtista,
			Artista.Nombre AS NombreArtista,
			Distribuidora.IdDistribuidora,
			Distribuidora.Nombre AS NombreDistribuidora
	FROM Disco 
	INNER JOIN Artista ON Disco.IdArtista = Artista.IdArtista
	INNER JOIN Distribuidora ON Disco.IdDistribuidora = Distribuidora.IdDistribuidora
	WHERE DIsco.IdDisco = @IdDisco