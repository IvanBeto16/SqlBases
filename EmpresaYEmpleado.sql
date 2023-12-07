USE IvbetoProgramacionNCapas

--Leo, te quería comentar, que quería hacer válido el vale que tenemos (Brian, Yair, Mauricio y yo) de la pizza en la hora de comida.

CREATE TABLE Empresa(
IdEmpresa INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(50),
Telefono VARCHAR(50)
)

CREATE PROCEDURE EmpresaGetAll
AS
	SELECT IdEmpresa,Nombre,Telefono
	FROM Empresa

CREATE TABLE Empleado(
NumeroEmpleado VARCHAR(50) PRIMARY KEY,
RFC VARCHAR(50),
Nombre VARCHAR(50) NOT NULL,
ApellidoPaterno VARCHAR(50) NOT NULL,
ApellidoMaterno VARCHAR(50) NULL,
Email VARCHAR(254) UNIQUE NOT NULL,
Telefono VARCHAR(20) NOT NULL,
FechaNacimiento DATE NULL,
NSS VARCHAR(20),
FechaIngreso DATE,
Foto VARCHAR(MAX),
IdEmpresa INT FOREIGN KEY REFERENCES Empresa(IdEmpresa)
)

SELECT * FROM Empresa

INSERT INTO Empresa (Nombre,Telefono) VALUES('Intel','857694740')
INSERT INTO Empresa (Nombre,Telefono) VALUES('Sony','873657295')
INSERT INTO Empresa (Nombre,Telefono) VALUES('Cisco System','677593503')
INSERT INTO Empresa (Nombre,Telefono) VALUES('Oracle','346684758')
INSERT INTO Empresa (Nombre,Telefono) VALUES('iIexico','586775937')
INSERT INTO Empresa (Nombre,Telefono) VALUES('CoderSlink','556483749')

UPDATE Empresa SET Nombre='iTexico' WHERE IdEmpresa=5

ALTER PROCEDURE EmpleadoAdd 
@NumeroEmpleado VARCHAR(50),
@RFC VARCHAR(50),
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@Email VARCHAR(254),
@Telefono VARCHAR(20),
@FechaNacimiento DATE,
@NSS VARCHAR(20),
@Foto VARCHAR(MAX),
@IdEmpresa INT,
@filasInsertadas INT OUTPUT
AS
	INSERT INTO Empleado (NumeroEmpleado, 
				RFC, 
				Nombre, 
				ApellidoPaterno, 
				ApellidoMaterno,
				Email, Telefono,
				FechaNacimiento,
				NSS, FechaIngreso,
				Foto,
				IdEmpresa)
	VALUES(@NumeroEmpleado,@RFC,@Nombre,@ApellidoPaterno,@ApellidoMaterno,@Email,@Telefono
	,@FechaNacimiento,@NSS,GETDATE(),@Foto,@IdEmpresa)
	SET @filasInsertadas = @@ROWCOUNT

ALTER PROCEDURE EmpleadoGetAll 0,''
@IdEmpresa INT,
@NombreEmpleado VARCHAR(50)
AS
IF @IdEmpresa = '0' OR @IdEmpresa = ''
BEGIN
	SELECT Empleado.NumeroEmpleado,
	Empleado.RFC,
	Empleado.Nombre,
	Empleado.ApellidoPaterno,
	Empleado.ApellidoMaterno,
	Empleado.Email,
	Empleado.Telefono,
	Empleado.FechaNacimiento,
	Empleado.NSS,
	Empleado.FechaIngreso,
	Empleado.Foto,
	Empresa.IdEmpresa,
	Empresa.Nombre AS NombreEmpresa,
	Empresa.Telefono AS TelefonoEmpresa FROM Empleado
	INNER JOIN Empresa 
	ON Empleado.IdEmpresa = Empresa.IdEmpresa
	WHERE Empleado.Nombre LIKE '%'+@NombreEmpleado+'%'

END
IF @NombreEmpleado = '' OR @NombreEmpleado = null
BEGIN
	SELECT Empleado.NumeroEmpleado,
	Empleado.RFC,
	Empleado.Nombre,
	Empleado.ApellidoPaterno,
	Empleado.ApellidoMaterno,
	Empleado.Email,
	Empleado.Telefono,
	Empleado.FechaNacimiento,
	Empleado.NSS,
	Empleado.FechaIngreso,
	Empleado.Foto,
	Empresa.IdEmpresa,
	Empresa.Nombre AS NombreEmpresa,
	Empresa.Telefono AS TelefonoEmpresa FROM Empleado
	INNER JOIN Empresa 
	ON Empleado.IdEmpresa = Empresa.IdEmpresa
END


ALTER PROCEDURE EmpleadoGetById 
@NumeroEmpleado VARCHAR(50)
AS
	SELECT Empleado.NumeroEmpleado,
	Empleado.RFC,
	Empleado.Nombre,
	Empleado.ApellidoPaterno,
	Empleado.ApellidoMaterno,
	Empleado.Email,
	Empleado.Telefono,
	Empleado.FechaNacimiento,
	Empleado.NSS,
	Empleado.FechaIngreso,
	Empleado.Foto,
	Empresa.IdEmpresa,
	Empresa.Nombre AS NombreEmpresa,
	Empresa.Telefono AS TelefonoEmpresa FROM Empleado
	INNER JOIN Empresa 
	ON Empleado.IdEmpresa = Empresa.IdEmpresa
	WHERE NumeroEmpleado = @NumeroEmpleado



ALTER PROCEDURE EmpleadoUpdate 
@NumeroEmpleado VARCHAR(50),
@RFC VARCHAR(50),
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@Email VARCHAR(254),
@Telefono VARCHAR(20),
@FechaNacimiento DATE,
@NSS VARCHAR(20),
@Foto VARCHAR(MAX),
@IdEmpresa INT,
@filasActualizadas INT OUTPUT
AS
	UPDATE Empleado SET RFC=@RFC, Nombre=@Nombre, ApellidoPaterno=@ApellidoPaterno,
	ApellidoMaterno=@ApellidoMaterno, Email=@Email, Telefono=@Telefono, FechaNacimiento=@FechaNacimiento,
	NSS=@NSS, Foto=@Foto, IdEmpresa=@IdEmpresa
	WHERE NumeroEmpleado=@NumeroEmpleado
	SET @filasActualizadas = @@ROWCOUNT


ALTER PROCEDURE EmpleadoDelete 
@NumeroEmpleado VARCHAR(50),
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Empleado
	WHERE NumeroEmpleado = @NumeroEmpleado
	SET @filasEliminadas = @@ROWCOUNT


--TRUNCATE TABLE Empleado

EmpleadoAdd '1','BURJ000705E6F','Julia','Burch','Rochez','juliaburchofficial@yahoo.com.mx','746635821','2000-07-05','77465739402',null,'5',null
EmpleadoAdd '2','QUQJ960924HY6','Julian','Quiñones','Quiñones','julianquinones33@yahoo.com.mx','5564683757','1996-09-24','93055739402',null,'2',null
EmpleadoAdd '3','SAOA990930UI9','Ana Paula','Saenz','Ortega','anapsaenzoficial@yahoo.com.mx','6573958394','1999-09-30','64537583912',null,'4',null
EmpleadoAdd '4','SAME980405T5B','Eleisa','Santos','Martinez','eleisasantos@hotmail.com','5577849586','1998-04-05','99065739402',null,'4',null
EmpleadoAdd '5','MOCE991207HS2','Eduardo','Moreno','Callejas','eduardomoreno99@yahoo.com.mx','554235820','1999-12-07','87215739402',null,'1',null

EmpleadoUpdate '1','BURJ000705E6F','Julia','Burch','Rochez','juliaburchofficial@yahoo.com.mx','746635821','2000-07-05','77465739402',null,'5',null
