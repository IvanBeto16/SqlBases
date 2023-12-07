USE IvbetoProgramacionNCapas

SELECT * FROM Usuario

ALTER TABLE Usuario
ADD Status BIT DEFAULT(1) NOT NULL

ALTER PROCEDURE [dbo].[UsuarioGetAll]
AS
SELECT Usuario.IdUsuario,
	Usuario.UserName,
	Usuario.[Status],
	Usuario.Imagen, 
	Usuario.Nombre,
	Usuario.ApellidoPaterno,
	Usuario.ApellidoMaterno,
	Usuario.FechaNacimiento,
	Usuario.Email,
	Usuario.[Password],
	Usuario.Telefono,
	Usuario.Celular,
	Usuario.Curp,
	Usuario.Sexo,
	Rol.IdRol, 
	Rol.Nombre AS NombreRol,
	Direccion.IdDireccion,
	Direccion.Calle,
	Direccion.NumeroInterior,
	Direccion.NumeroExterior,
	Colonia.IdColonia,
	Colonia.Nombre AS NombreColonia,
	Colonia.CodigoPostal,
	Municipio.IdMunicipio,
	Municipio.Nombre AS NombreMunicipio,
	Estado.IdEstado,
	Estado.Nombre AS NombreEstado,
	Pais.IdPais,
	Pais.Nombre AS NombrePais
FROM Usuario 
INNER JOIN Rol ON Usuario.IdRol = Rol.IdRol
INNER JOIN Direccion ON Usuario.IdUsuario = Direccion.IdUsuario
INNER JOIN Colonia ON Direccion.IdColonia = Colonia.IdColonia
INNER JOIN Municipio ON	Colonia.IdMunicipio = Municipio.IdMunicipio
INNER JOIN Estado ON Municipio.IdEstado = Estado.IdEstado
INNER JOIN Pais ON Estado.IdPais = Pais.IdPais

UsuarioGetAll