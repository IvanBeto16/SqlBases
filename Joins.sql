--IMPLEMENTACION DE JOINS 

SELECT IdUsuario, Usuario.Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
Direccion,Nacionalidad,EstadoCivil,Usuario.IdRol, Rol.Nombre AS NombreRol 
FROM Usuario 
INNER JOIN Rol 
ON Usuario.IdRol = Rol.IdRol


SELECT IdUsuario, Usuario.Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
Direccion,Nacionalidad,EstadoCivil,Usuario.IdRol, Rol.Nombre AS NombreRol 
FROM Usuario 
INNER JOIN Rol 
ON Usuario.IdRol = Rol.IdRol
WHERE IdUsuario = 1

--Alter Procedures con JOIN
ALTER PROCEDURE [dbo].[UsuarioGetAll]
AS
SELECT IdUsuario, Usuario.Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
Direccion,Nacionalidad,EstadoCivil,Usuario.IdRol, Rol.Nombre AS NombreRol 
FROM Usuario 
INNER JOIN Rol 
ON Usuario.IdRol = Rol.IdRol


ALTER PROCEDURE [dbo].[UsuarioGetById]
@IdUsuario INT
AS
SELECT IdUsuario, Usuario.Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
Direccion,Nacionalidad,EstadoCivil,Usuario.IdRol, Rol.Nombre AS NombreRol 
FROM Usuario 
INNER JOIN Rol 
ON Usuario.IdRol = Rol.IdRol
WHERE IdUsuario = @IdUsuario


UsuarioGetByID 6
