USE IvbetoProgramacionNCapas

CREATE TABLE Dependiente(
IdDependiente INT PRIMARY KEY IDENTITY(1,1),
NumeroEmpleado VARCHAR(50) FOREIGN KEY REFERENCES Empleado(NumeroEmpleado),
Nombre VARCHAR(50) NOT NULL,
ApellidoPaterno VARCHAR(50) NOT NULL,
ApellidoMaterno VARCHAR(50) NULL,
FechaNacimiento DATE,
EstadoCivil VARCHAR(50),
Genero VARCHAR(2) NOT NULL,
Telefono VARCHAR(20) NOT NULL,
RFC VARCHAR(50) NULL
)

CREATE PROCEDURE DependienteAdd
@NumeroEmpleado VARCHAR(50),
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@FechaNacimiento DATE,
@EstadoCivil VARCHAR(50),
@Genero VARCHAR(2),
@Telefono VARCHAR(20),
@RFC VARCHAR(50),
@FilasInsertadas INT OUTPUT
AS
	INSERT INTO Dependiente(NumeroEmpleado,Nombre,ApellidoPaterno,ApellidoMaterno,
	FechaNacimiento,EstadoCivil,Genero,Telefono,RFC)
	VALUES(@NumeroEmpleado,@Nombre,@ApellidoPaterno,@ApellidoMaterno,@FechaNacimiento,
	@EstadoCivil,@Genero,@Telefono,@RFC)
	SET @FilasInsertadas = @@ROWCOUNT


CREATE PROCEDURE DependienteDelete
@IdDependiente INT,
@FilasEliminadas INT OUTPUT
AS
	DELETE FROM Dependiente
	WHERE IdDependiente = @IdDependiente
	SET @FilasEliminadas = @@ROWCOUNT



ALTER PROCEDURE DependienteUpdate
@IdDependiente INT,
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@FechaNacimiento DATE,
@EstadoCivil VARCHAR(50),
@Genero VARCHAR(2),
@Telefono VARCHAR(20),
@RFC VARCHAR(50),
@filasAlteradas INT OUTPUT
AS
	UPDATE Dependiente SET
	Nombre=@Nombre,ApellidoPaterno=@ApellidoPaterno,
	ApellidoMaterno = @ApellidoMaterno,
	FechaNacimiento=@FechaNacimiento,
	EstadoCivil=@EstadoCivil,Genero=@Genero, 
	Telefono=@Telefono, RFC=@RFC
	WHERE IdDependiente = @IdDependiente
	SET @filasAlteradas = @@ROWCOUNT

ALTER PROCEDURE DependienteGetByIdEmpleado
@NumeroEmpleado VARCHAR(50)
AS
	SELECT  Dependiente.IdDependiente,
			Dependiente.Nombre,
			Dependiente.ApellidoPaterno,
			Dependiente.ApellidoMaterno,
			Dependiente.FechaNacimiento,
			Dependiente.EstadoCivil,
			Dependiente.RFC,
			Dependiente.Genero,
			Dependiente.Telefono,
			Empleado.NumeroEmpleado,
			Empleado.Nombre AS NombreEmpleado,
			Empleado.ApellidoPaterno AS ApellidoPaternoEmpleado,
			Empleado.ApellidoMaterno AS ApellidoMaternoEmpleado
	FROM Dependiente
	INNER JOIN Empleado
	ON Dependiente.NumeroEmpleado = Empleado.NumeroEmpleado
	WHERE Dependiente.NumeroEmpleado = @NumeroEmpleado


ALTER PROCEDURE DependienteGetAll
AS
	SELECT Dependiente.Nombre,
		Dependiente.ApellidoPaterno,
		Dependiente.ApellidoMaterno,
		Dependiente.FechaNacimiento,
		Dependiente.EstadoCivil,
		Dependiente.Genero,
		Dependiente.RFC,
		Dependiente.Telefono,
		Empleado.NumeroEmpleado,
		Empleado.Nombre,
		Empleado.ApellidoPaterno,
		Empleado.ApellidoMaterno
	FROM Dependiente
	INNER JOIN Empleado
	ON Dependiente.NumeroEmpleado = Empleado.NumeroEmpleado

DependienteAdd '1','Lauren','Burch','Rochez','2000-07-05','Soltera','F','7457473837','BURL000705PO8',null
DependienteAdd '1','Mauricio','Eduardo','Lopez','2002-05-21','Soltero','M','5556473890','EDLM020521LN8',null
DependienteAdd '2','Ivan','Martinez','Astivia','1999-10-19','Soltero','M','5575793422','MAAI991019UY5',null
DependienteAdd '3','Brenda Liseth','Cuevas','Montaño','1999-05-21','En Relacion','F','5590283782','CUMB990521OM9',null
DependienteAdd '3','Angel','Braikovich','Castillo','1999-09-27','En Relacion','M','5576534273','BRCA990927YB7',null
DependienteAdd '4','Estefania','Fajardo','Barbieri','2004-02-29','Soltera','F','5500986781','FABE040229EG8',null
DependienteAdd '4','Juan Carlos','Djordevic','Savic','1998-01-11','Soltero','M','5572737482','DJSJ980111UZ2',null
DependienteAdd '6','Victor Hugo','Chavez','Aldama','2000-06-12','Soltero','M','5546382932','CHAV000612WL6',null
DependienteAdd '3','Miyuki','Beto','Ichinose','2007-08-19','Soltero','M','5590261819','BEIM070819EH5',null

DependienteAdd '5','Leonardo','Benottiz','Riestra','2002-11-07','Soltero','F','5586849450','BERL021107IS4',null

ALTER PROCEDURE DependienteGetById
@IdDependiente INT
AS
	SELECT Dependiente.IdDependiente,
			Dependiente.Nombre,
			Dependiente.ApellidoPaterno,
			Dependiente.ApellidoMaterno,
			Dependiente.FechaNacimiento,
			Dependiente.EstadoCivil,
			Dependiente.Genero,
			Dependiente.Telefono,
			Dependiente.RFC,
			Empleado.NumeroEmpleado,
			Empleado.Nombre AS NombreEmpleado,
			Empleado.ApellidoPaterno AS ApellidoPaternoEmpleado,
			Empleado.ApellidoMaterno AS ApellidoMaternoEmpleado
	FROM Dependiente
	INNER JOIN Empleado
	ON Dependiente.NumeroEmpleado = Empleado.NumeroEmpleado
	WHERE Dependiente.IdDependiente = @IdDependiente


DependienteUpdate '14','Angel','Braikovich','Castillo','1999-11-07','Soltero','M','5586849450','BRCA021107IS4',null

SELECT * FROM Dependiente
SELECT * FROM Empleado

SELECT @@IDENTITY AS UltimoInsert