CREATE DATABASE IvBetoTrackingAndTrace

USE IvBetoTrackingAndTrace

CREATE TABLE Rol(
IdRol INT PRIMARY KEY IDENTITY(1,1),
Tipo VARCHAR(30)
)

INSERT INTO Rol VALUES('Usuario')
INSERT INTO Rol VALUES('Administrador')
INSERT INTO Rol VALUES('Repartidor')

CREATE PROCEDURE RolGetAll
AS
	SELECT IdRol,Tipo 
	FROM Rol

CREATE TABLE Usuario(
IdUsuario INT PRIMARY KEY IDENTITY(1,1),
Username VARCHAR(20),
Password VARBINARY(MAX),
Email VARCHAR(40),
Nombre VARCHAR(30),
ApellidoPaterno VARCHAR(30),
ApellidoMaterno VARCHAR(30),
IdRol INT FOREIGN KEY REFERENCES Rol(IdRol)
)

DROP TABLE Usuario
TRUNCATE TABLE Usuario
--------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UsuarioAdd
@Username VARCHAR(20),
@Password VARCHAR(MAX),
@Email VARCHAR(40),
@Nombre VARCHAR(30),
@ApellidoPaterno VARCHAR(30),
@ApellidoMaterno VARCHAR(30),
@IdRol INT,
@FilasInsertadas INT OUTPUT
AS
	INSERT INTO Usuario(Username,Password,
	Email,Nombre,ApellidoPaterno,ApellidoMaterno,
	IdRol) VALUES(@Username,CONVERT(VARBINARY(MAX),@Password),@Email,@Nombre,
	@ApellidoPaterno,@ApellidoMaterno,@IdRol)
	SET @filasInsertadas = @@ROWCOUNT


DROP PROCEDURE UsuarioAdd

ALTER PROCEDURE UsuarioUpdate '1','ivanbeto','0x42323231443944424230383341374633333432384437433241334333313938414539323536313444373032313045323837313643434141374344344444423739','betoivan16p@yahoo.com.mx','Ivan','Beto','Perez','2',null
@IdUsuario INT,
@Username VARCHAR(20),
@Password VARCHAR(MAX),
@Email VARCHAR(40),
@Nombre VARCHAR(30),
@ApellidoPaterno VARCHAR(30),
@ApellidoMaterno VARCHAR(30),
@IdRol INT,
@FilasActualizadas INT OUTPUT
AS
	UPDATE Usuario SET Username=@Username, Password=CONVERT(VARBINARY(MAX),@Password),
	Email=@Email,Nombre=@Nombre,ApellidoPaterno=@ApellidoPaterno,
	ApellidoMaterno=@ApellidoMaterno,IdRol=@IdRol
	WHERE IdUsuario = @IdUsuario
	SET @FilasActualizadas = @@ROWCOUNT


CREATE PROCEDURE UsuarioDelete
@IdUsuario INT,
@filasEliminadas INT OUTPUT
AS
	DELETE FROM Usuario
	WHERE IdUsuario = @IdUsuario
	SET @filasEliminadas = @@ROWCOUNT


ALTER PROCEDURE UsuarioGetAll
AS
	SELECT Usuario.IdUsuario,
		Usuario.Username,
		Usuario.Password,
		Usuario.Email,
		Usuario.Nombre,
		Usuario.ApellidoPaterno,
		Usuario.ApellidoMaterno,
		Rol.IdRol,
		Rol.Tipo
	FROM Usuario INNER JOIN Rol
	ON Usuario.IdRol = Rol.IdRol


CREATE PROCEDURE UsuarioGetById
@IdUsuario INT
AS
	SELECT Usuario.IdUsuario,
			Usuario.Username,
			Usuario.Password,
			Usuario.Email,
			Usuario.Nombre,
			Usuario.ApellidoPaterno,
			Usuario.ApellidoMaterno,
			Rol.IdRol,
			Rol.Tipo
	FROM Usuario INNER JOIN Rol
	ON Usuario.IdRol = Rol.IdRol
	WHERE Usuario.IdUsuario = @IdUsuario


ALTER PROCEDURE UsuarioGetByEmail 
@Email VARCHAR(40)
AS
	SELECT Usuario.IdUsuario,
			Usuario.Username,
			Usuario.Password,
			Usuario.Email,
			Usuario.Nombre,
			Usuario.ApellidoPaterno,
			Usuario.ApellidoMaterno,
			Rol.IdRol,
			Rol.Tipo
	FROM Usuario INNER JOIN Rol
	ON Usuario.IdRol = Rol.IdRol
	WHERE Usuario.Email = @Email

---------------------------------------------------------------------------------------
CREATE TABLE EstatusUnidad(
IdEstatus INT PRIMARY KEY IDENTITY(1,1),
Estatus VARCHAR(20)
)

INSERT INTO EstatusUnidad VALUES('Fuera de Servicio')
INSERT INTO EstatusUnidad VALUES('Disponible')
INSERT INTO EstatusUnidad VALUES('Ocupada')


ALTER PROCEDURE EstatusUnidadGetAll
AS
	SELECT IdEstatus, Estatus
	FROM EstatusUnidad

CREATE TABLE UnidadEntrega(
IdUnidad INT PRIMARY KEY IDENTITY(1,1),
NumeroPlaca VARCHAR(10),
Modelo VARCHAR(30),
Marca VARCHAR(30),
AnioFabricacion INT,
IdEstatus INT FOREIGN KEY REFERENCES EstatusUnidad(IdEstatus)
)


ALTER PROCEDURE UnidadEntregaAdd 'JCN-7466','Tsuru','Nissan','2017','3'
@NumeroPlaca VARCHAR(10),
@Modelo VARCHAR(30),
@Marca VARCHAR(30),
@AnioFabricacion INT,
@IdEstatus INT
AS
	INSERT INTO UnidadEntrega(NumeroPlaca,Modelo,Marca,
	AnioFabricacion, IdEstatus) VALUES(@NumeroPlaca,@Modelo,@Marca,
	@AnioFabricacion,@IdEstatus)


CREATE PROCEDURE UnidadEntregaUpdate
@IdUnidad INT,
@NumeroPlaca VARCHAR(10),
@Modelo VARCHAR(30),
@Marca VARCHAR(30),
@AnioFabricacion INT,
@IdEstatus INT
AS
	UPDATE UnidadEntrega SET
	NumeroPlaca=@NumeroPlaca, Modelo=@Modelo, Marca=@Marca,
	AnioFabricacion=@AnioFabricacion,IdEstatus=@IdEstatus
	WHERE IdUnidad=@IdUnidad


CREATE PROCEDURE UnidadEntregaDelete
@IdUnidad INT
AS
	DELETE FROM UnidadEntrega
	WHERE IdUnidad=@IdUnidad


CREATE PROCEDURE UnidadEntregaGetAll
AS
	SELECT UnidadEntrega.IdUnidad,
			UnidadEntrega.NumeroPlaca,
			UnidadEntrega.Modelo,
			UnidadEntrega.Marca,
			UnidadEntrega.AnioFabricacion,
			EstatusUnidad.IdEstatus,
			EstatusUnidad.Estatus
	FROM UnidadEntrega INNER JOIN EstatusUnidad
	ON UnidadEntrega.IdEstatus = EstatusUnidad.IdEstatus



CREATE PROCEDURE UnidadEntregaGetById 
@IdUnidad INT
AS
	SELECT UnidadEntrega.IdUnidad,
			UnidadEntrega.NumeroPlaca,
			UnidadEntrega.Modelo,
			UnidadEntrega.Marca,
			UnidadEntrega.AnioFabricacion,
			EstatusUnidad.IdEstatus,
			EstatusUnidad.Estatus
	FROM UnidadEntrega INNER JOIN EstatusUnidad
	ON UnidadEntrega.IdEstatus = EstatusUnidad.IdEstatus
	WHERE UnidadEntrega.IdUnidad = @IdUnidad
------------------------------------------------------------------------------
CREATE TABLE Repartidor(
IdRepartidor INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(30),
ApellidoPaterno VARCHAR(30),
ApellidoMaterno VARCHAR(30),
Telefono INT,
FechaIngreso DATE,
Fotografia VARCHAR(MAX),
IdUnidad INT FOREIGN KEY REFERENCES UnidadEntrega(IdUnidad)
)

ALTER TABLE Repartidor
ALTER COLUMN Telefono VARCHAR(20)

CREATE TABLE EstatusEntrega(
IdEstatus INT PRIMARY KEY IDENTITY(1,1),
Estatus VARCHAR(20)
)

CREATE TABLE Paquete(
IdPaquete INT PRIMARY KEY IDENTITY(1,1),
Detalle VARCHAR(50),
Peso VARCHAR(10),
DireccionOrigen VARCHAR(MAX),
DireccionDestino VARCHAR(MAX),
FechaEstimadaEntrega DATE,
CodigoRastreo VARCHAR(10)
)

CREATE TABLE Entrega(
IdEntrega INT IDENTITY(1,1),
IdPaquete INT FOREIGN KEY REFERENCES Paquete(IdPaquete),
IdRepartidor INT FOREIGN KEY REFERENCES Repartidor(IdRepartidor),
IdEstatus INT FOREIGN KEY REFERENCES EstatusEntrega(IdEstatus),
PRIMARY KEY(IdEntrega, IdRepartidor, IdEstatus),
fechaEntrega DATE
)

-------STORED PROCEDURES REPARTIDOR----------

ALTER PROCEDURE RepartidorAdd
@Nombre VARCHAR(30),
@ApellidoPaterno VARCHAR(30),
@ApellidoMaterno VARCHAR(30),
@Telefono VARCHAR(20),
@FechaIngreso DATE,
@Fotografia VARCHAR(MAX),
@IdUnidad INT
AS
	INSERT INTO Repartidor
	VALUES(@Nombre,@ApellidoPaterno,@ApellidoMaterno,
	@Telefono,@FechaIngreso,@Fotografia,@IdUnidad)


-------nuevo
ALTER PROCEDURE RepartidorUpdate
@IdRepartidor INT,
@Nombre VARCHAR(30),
@ApellidoPaterno VARCHAR(30),
@ApellidoMaterno VARCHAR(30),
@Telefono VARCHAR(20),
@FechaIngreso DATE,
@Fotografia VARCHAR(MAX),
@IdUnidad INT
AS
	UPDATE Repartidor SET Nombre=@Nombre, ApellidoPaterno=@ApellidoPaterno,
	ApellidoMaterno=@ApellidoMaterno,Telefono=@Telefono,
	FechaIngreso=@FechaIngreso,Fotografia=@Fotografia
	WHERE IdRepartidor=@IdRepartidor


CREATE PROCEDURE RepartidorDelete 
@IdRepartidor INT
AS
	DELETE FROM Repartidor
	WHERE IdRepartidor=@IdRepartidor



CREATE PROCEDURE RepartidorGetAll
AS
	SELECT Repartidor.IdRepartidor,
			Repartidor.Nombre,
			Repartidor.ApellidoPaterno,
			Repartidor.ApellidoMaterno,
			Repartidor.Telefono,
			Repartidor.FechaIngreso,
			Repartidor.Fotografia,
			UnidadEntrega.IdUnidad,
			UnidadEntrega.NumeroPlaca
	FROM Repartidor INNER JOIN UnidadEntrega
	ON Repartidor.IdUnidad = UnidadEntrega.IdUnidad


CREATE PROCEDURE RepartidorGetById
@IdRepartidor INT
AS
	SELECT Repartidor.IdRepartidor,
			Repartidor.Nombre,
			Repartidor.ApellidoPaterno,
			Repartidor.ApellidoMaterno,
			Repartidor.Telefono,
			Repartidor.FechaIngreso,
			Repartidor.Fotografia,
			UnidadEntrega.IdUnidad,
			UnidadEntrega.NumeroPlaca
	FROM Repartidor INNER JOIN UnidadEntrega
	ON Repartidor.IdUnidad = UnidadEntrega.IdUnidad
	WHERE Repartidor.IdRepartidor = @IdRepartidor

SELECT * FROM EstatusUnidad
SELECT * FROM EstatusEntrega
	