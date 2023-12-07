CREATE DATABASE TestSol

USE TestSol


CREATE TABLE Empleado(
IdEmpleado INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(70) NOT NULL,
ApellidoPaterno VARCHAR(70) NOT NULL,
ApellidoMaterno VARCHAR(70),
Area VARCHAR(30),
FechaNacimiento DATE,
Sueldo FLOAT
)

CREATE TABLE Empleado
ADD Imagen VARCHAR(MAX)

CREATE PROCEDURE AgregarEmpleado
@Nombre VARCHAR(70),
@ApellidoPaterno VARCHAR(70),
@ApellidoMaterno VARCHAR(70),
@Area VARCHAR(30),
@FechaNacimiento DATE,
@Sueldo FLOAT,
@Imagen VARCHAR(MAX),
@FilasInsertadas INT OUTPUT
AS
	INSERT INTO Empleado 
	VALUES(@Nombre,@ApellidoPaterno,@ApellidoMaterno,
	@Area,@FechaNacimiento,@Sueldo,@Imagen)
	SET @FilasInsertadas = @@ROWCOUNT


CREATE PROCEDURE ActualizarEmpleado
@IdEmpleado INT,
@Nombre VARCHAR(70),
@ApellidoPaterno VARCHAR(70),
@ApellidoMaterno VARCHAR(70),
@Area VARCHAR(30),
@FechaNacimiento DATE,
@Sueldo FLOAT,
@Imagen VARCHAR(MAX),
@FilasActualizadas INT OUTPUT
AS
	UPDATE Empleado SET Nombre=@Nombre,
	ApellidoPaterno=@ApellidoPaterno,
	ApellidoMaterno=@ApellidoMaterno,
	Area=@Area,FechaNacimiento=@FechaNacimiento,
	Sueldo=@Sueldo,Imagen=@Imagen WHERE IdEmpleado=@IdEmpleado
	SET @FilasActualizadas = @@ROWCOUNT



CREATE PROCEDURE EliminarEmpleado
@IdEmpleado INT,
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Empleado
	WHERE IdEmpleado = @IdEmpleado
	SET @filasEliminadas = @@ROWCOUNT



CREATE PROCEDURE MostrarEmpleados
AS
	SELECT Empleado.IdEmpleado,
			Empleado.Nombre,
			Empleado.ApellidoPaterno,
			Empleado.ApellidoMaterno,
			Empleado.Area,
			Empleado.FechaNacimiento,
			Empleado.Sueldo,
			Empleado.Imagen
	FROM Empleado


CREATE PROCEDURE MostrarPorId
@IdEmpleado INT
AS
	SELECT Empleado.IdEmpleado,
			Empleado.Nombre,
			Empleado.ApellidoPaterno,
			Empleado.ApellidoMaterno,
			Empleado.Area,
			Empleado.FechaNacimiento,
			Empleado.Sueldo,
			Empleado.Imagen
	FROM Empleado
	WHERE Empleado.IdEmpleado = @IdEmpleado