SELECT IdUsuario, Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Direccion, Nacionalidad, EstadoCivil FROM Usuario

--TRUNCATE TABLE Usuario

--Creacion de los procedimientos

--Agregar
CREATE PROCEDURE UsuarioAdd
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@FechaNacimiento DATE,
@Direccion VARCHAR(100),
@Nacionalidad VARCHAR(70),
@EstadoCivil VARCHAR(20)
AS
INSERT INTO Usuario (Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,Direccion,Nacionalidad,EstadoCivil)
VALUES(@Nombre,@ApellidoPaterno,@ApellidoMaterno,@FechaNacimiento,@Direccion,@Nacionalidad,@EstadoCivil)

--Actualizar
CREATE PROCEDURE UsuarioUpdate
@IdUsuario INT,
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@FechaNacimiento DATE,
@Direccion VARCHAR(100),
@Nacionalidad VARCHAR(70),
@EstadoCivil VARCHAR(20)
AS
UPDATE Usuario 
SET Nombre=@Nombre, ApellidoPaterno=@ApellidoPaterno, ApellidoMaterno=@ApellidoMaterno, 
FechaNacimiento=@FechaNacimiento, Direccion=@Direccion, Nacionalidad=@Nacionalidad, EstadoCivil=@EstadoCivil 
WHERE IdUsuario = @IdUsuario

--Mostrar todo
CREATE PROCEDURE UsuarioGetAll
AS
SELECT IdUsuario, Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Direccion, Nacionalidad, EstadoCivil 
FROM Usuario


--Mostrar por ID
CREATE PROCEDURE UsuarioGetById
@IdUsuario INT
AS
SELECT IdUsuario, Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Direccion, Nacionalidad, EstadoCivil 
FROM Usuario
WHERE IdUsuario = @IdUsuario

--Eliminar
CREATE PROCEDURE UsuarioDelete
@IdUsuario INT
AS
DELETE FROM Usuario WHERE IdUsuario = @IdUsuario

UsuarioGetAll

UsuarioGetById 5
