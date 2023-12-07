Use IvbetoProgramacionNCapas

UsuarioGetAll
UsuarioGetById 1

CREATE TABLE Aseguradora(
IdAseguradora INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50) NOT NULL,
FechaCreacion DATE,
FechaModificacion DATE,
IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario)
)

SELECT * FROM Aseguradora

ALTER PROCEDURE AseguradoraAdd
@Nombre VARCHAR(50),
@FechaCreacion DATE,
@IdUsuario INT,
@filasAlteradas INT OUTPUT
AS
	INSERT INTO Aseguradora(Nombre,FechaCreacion,FechaModificacion,
	IdUsuario) VALUES(@Nombre,@FechaCreacion,GETDATE(),@IdUsuario)
	SET @filasAlteradas = @@ROWCOUNT



ALTER PROCEDURE AseguradoraDelete
@IdAseguradora INT,
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Aseguradora
	WHERE Aseguradora.IdAseguradora = @IdAseguradora
	SET @filasEliminadas = @@ROWCOUNT


ALTER PROCEDURE AseguradoraUpdate '14', 'Balkin Seguros', '27',  null
@IdAseguradora INT,
@Nombre VARCHAR(50),
@IdUsuario INT,
@filasActualizadas INT OUTPUT
AS
	UPDATE Aseguradora 
	SET Nombre=@Nombre,
	FechaModificacion = GETDATE(), IdUsuario = @IdUsuario
	WHERE IdAseguradora = @IdAseguradora


CREATE PROCEDURE AseguradoraGetAll
AS
	SELECT Aseguradora.IdAseguradora,
	Aseguradora.Nombre,
	Aseguradora.FechaCreacion,
	Aseguradora.FechaModificacion,
	Usuario.IdUsuario,
	Usuario.Nombre,
	Usuario.ApellidoPaterno,
	Usuario.ApellidoMaterno,
	Usuario.Email
	FROM Aseguradora
	INNER JOIN Usuario ON Aseguradora.IdUsuario = Usuario.IdUsuario

ALTER PROCEDURE AseguradoraGetAll
AS
	SELECT Aseguradora.IdAseguradora,
	Aseguradora.Nombre,
	Aseguradora.FechaCreacion,
	Aseguradora.FechaModificacion,
	Usuario.IdUsuario,
	Usuario.Nombre AS NombreUsuario,
	Usuario.ApellidoPaterno
	FROM Aseguradora
	INNER JOIN Usuario ON Aseguradora.IdUsuario = Usuario.IdUsuario


ALTER PROCEDURE AseguradoraGetById
@IdAseguradora INT
AS
	SELECT Aseguradora.IdAseguradora,
	Aseguradora.Nombre,
	Aseguradora.FechaCreacion,
	Aseguradora.FechaModificacion,
	Usuario.IdUsuario,
	Usuario.Nombre AS NombreUsuario,
	Usuario.ApellidoPaterno
	FROM Aseguradora
	INNER JOIN Usuario ON Aseguradora.IdUsuario = Usuario.IdUsuario
	WHERE Aseguradora.IdAseguradora = @IdAseguradora

TRUNCATE TABLE Aseguradora

AseguradoraAdd 'El Aguila', '2006-04-18','1',null
AseguradoraAdd 'Qualitas', '2004-06-15','2',null
AseguradoraAdd 'AXA Seguros', '1985-09-10','3',null
AseguradoraAdd 'MAPFRE', '2002-02-11','4',null
AseguradoraAdd 'GNP Seguros', '1990-08-18','5',null
AseguradoraAdd 'Sura Seguros', '2005-03-10','7',null
AseguradoraAdd 'Inbursa', '2002-04-10','8',null


AseguradoraAdd 'Atlas Seguros', '2006-04-18','10',null


UsuarioGetAll '',''
SELECT * FROM Aseguradora
AseguradoraGetAll
AseguradoraGetById 3
AseguradoraDelete 8,null

SELECT * FROM Empleado