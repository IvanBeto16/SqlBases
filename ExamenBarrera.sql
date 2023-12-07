CREATE DATABASE IvBetoExamenBarrera

USE IvBetoExamenBarrera


CREATE TABLE Rol(
IdRol INT PRIMARY KEY IDENTITY(1,1),
NombreRol VARCHAR(60)
)

INSERT INTO Rol VALUES('Administrador')
INSERT INTO Rol VALUES('Alumno')
INSERT INTO Rol VALUES('Profesor')


SELECT * FROM Rol


CREATE TABLE Usuario(
IdUsuario INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(60),
ApellidoPaterno VARCHAR(60),
ApellidoMaterno VARCHAR(60),
Username VARCHAR(60),
Password VARCHAR(70),
IdRol INT FOREIGN KEY REFERENCES Rol(IdRol)
)

INSERT INTO Usuario VALUES('Ivan','Beto','Perez','ivanbeto','password1','1')
INSERT INTO Usuario VALUES('Veronica','Zamora','Perez','ronizamora','password1','3')
INSERT INTO Usuario VALUES('Karla','Beto','Perez','ivonnebp','password1','2')


ALTER PROCEDURE UsuarioLogin
@Username VARCHAR(60),
@Password VARCHAR(70)
AS
	SELECT Usuario.IdUsuario,
			Usuario.Nombre,
			Usuario.ApellidoPaterno,
			Usuario.ApellidoMaterno,
			Usuario.Username,
			Usuario.Password,
			Rol.IdRol,
			Rol.NombreRol
	FROM Usuario
	INNER JOIN ROL ON Usuario.IdRol = Rol.IdRol
	WHERE Usuario.Username = @Username 
	AND Usuario.Password = @Password


CREATE TABLE Materia(
IdMateria INT PRIMARY KEY IDENTITY(1,1),
NombreMateria VARCHAR(70),
Creditos INT
)


CREATE TABLE Alumno(
NumCuenta VARCHAR(5) PRIMARY KEY,/*AL001*/
Nombre VARCHAR(60),
ApellidoPaterno VARCHAR(60),
ApellidoMaterno VARCHAR(60),
Curp VARCHAR(30),
FechaNacimiento DATE
)

CREATE PROCEDURE AlumnoAdd
@NumCuenta VARCHAR(5),
@Nombre VARCHAR(60),
@ApellidoPaterno VARCHAR(60),
@ApellidoMaterno VARCHAR(60),
@Curp VARCHAR(30),
@FechaNacimiento DATE,
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Alumno 
	VALUES(@NumCuenta,@Nombre,@ApellidoPaterno,@ApellidoMaterno,@Curp,
	@FechaNacimiento)
	SET @filasInsertadas = @@ROWCOUNT

DROP PROCEDURE AlumnoAdd

CREATE PROCEDURE AlumnoUpdate
@NumCuenta VARCHAR(5),
@Nombre VARCHAR(60),
@ApellidoPaterno VARCHAR(60),
@ApellidoMaterno VARCHAR(60),
@Curp VARCHAR(30),
@FechaNacimiento DATE,
@filasActualizadas INT OUTPUT
AS
	UPDATE Alumno SET
	NumCuenta=@NumCuenta, Nombre=@Nombre,
	ApellidoPaterno=@ApellidoPaterno, ApellidoMaterno=@ApellidoMaterno,
	Curp=@Curp, FechaNacimiento=@FechaNacimiento
	WHERE NumCuenta=@NumCuenta


CREATE TABLE Profesor(
IdProfesor INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(60),
ApellidoPaterno VARCHAR(60),
ApellidoMaterno VARCHAR(60),
RFC VARCHAR(30),
FechaAlta DATE,
IdMateria INT FOREIGN KEY REFERENCES Materia(IdMateria)
)


CREATE TABLE Boleta(
NumBoleta VARCHAR(5), /*B-001*/
NumCuenta VARCHAR(5) FOREIGN KEY REFERENCES Alumno(NumCuenta),
IdMateria INT FOREIGN KEY REFERENCES Materia(IdMateria),
Calificacion INT DEFAULT 0,
PRIMARY KEY(NumBoleta,NumCuenta)
)

/**************Metodos para las materias*************/
CREATE PROCEDURE MateriaAdd
@NombreMateria VARCHAR(70),
@Creditos INT,
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Materia VALUES(@NombreMateria,@Creditos)
	SET @filasInsertadas = @@ROWCOUNT


CREATE PROCEDURE MateriaUpdate
@IdMateria INT,
@NombreMateria VARCHAR(70),
@Creditos INT,
@filasActualizadas INT OUTPUT
AS
	UPDATE Materia SET NombreMateria=@NombreMateria,
	Creditos=@Creditos WHERE IdMateria=@IdMateria
	SET @filasActualizadas = @@ROWCOUNT


ALTER PROCEDURE MateriaDelete
@IdMateria INT,
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Materia
	WHERE IdMateria = @IdMateria
	SET @filasEliminadas = @@ROWCOUNT


CREATE PROCEDURE MateriaGetAll
AS
	SELECT Materia.IdMateria,
		Materia.NombreMateria,
		Materia.Creditos
	FROM Materia


CREATE PROCEDURE MateriaGetById
@IdMateria INT
AS
	SELECT Materia.IdMateria,
		Materia.NombreMateria,
		Materia.Creditos
	FROM Materia
	WHERE Materia.IdMateria=@IdMateria

/************************************************/

/**********Metodos para los alumnos**************/

CREATE PROCEDURE AlumnoAdd
@Nombre VARCHAR(60),
@ApellidoPaterno VARCHAR(60),
@ApellidoMaterno VARCHAR(60),
@Username VARCHAR(60),
@Password VARCHAR(70),
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Usuario VALUES(@Nombre,@ApellidoPaterno,@ApellidoMaterno,@Username,
	@Password,2)
	SET @filasInsertadas = @@ROWCOUNT




CREATE PROCEDURE AlumnoUpdate
@IdUsuario INT,
@Nombre VARCHAR(60),
@ApellidoPaterno VARCHAR(60),
@ApellidoMaterno VARCHAR(60),
@Username VARCHAR(60),
@Password VARCHAR(70),
@filasActualizadas INT OUTPUT
AS
	UPDATE Usuario SET 
	Nombre=@Nombre,ApellidoPaterno=@ApellidoPaterno,
	ApellidoMaterno=@ApellidoMaterno,Username=@Username,
	Password=@Password
	WHERE IdUsuario = @IdUsuario


CREATE PROCEDURE AlumnoGetAll
AS
	SELECT Usuario.IdUsuario,
			Usuario.Nombre,
			Usuario.ApellidoPaterno,
			Usuario.ApellidoMaterno,
			Usuario.Username,
			Rol.IdRol,
			Rol.NombreRol
	FROM Usuario INNER JOIN Rol
	ON Usuario.IdRol = Rol.IdRol
	WHERE Usuario.IdRol = 2


CREATE PROCEDURE AlumnoGetById
@IdUsuario INT
AS
	SELECT Usuario.IdUsuario,
			Usuario.Nombre,
			Usuario.ApellidoPaterno,
			Usuario.ApellidoMaterno,
			Usuario.Username,
			Rol.IdRol,
			Rol.NombreRol
	FROM Usuario INNER JOIN Rol
	ON Usuario.IdRol = Rol.IdRol
	WHERE Usuario.IdRol = 2 
	AND Usuario.IdUsuario = @IdUsuario
/************************************************/

CREATE PROCEDURE ProfesorAdd
@Nombre VARCHAR(60),
@ApellidoPaterno VARCHAR(60),
@ApellidoMaterno VARCHAR(60),
@Username VARCHAR(60),
@Password VARCHAR(70),
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Usuario VALUES(@Nombre,@ApellidoPaterno,@ApellidoMaterno,@Username,
	@Password,3)
	SET @filasInsertadas = @@ROWCOUNT



SELECT * FROM Usuario