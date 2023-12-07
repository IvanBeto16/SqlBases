USE IvbetoProgramacionNCapas

--Utilizando Transacciones con el Procedure Delete
ALTER PROCEDURE [dbo].[UsuarioDelete]
@IdUsuario INT
AS	
BEGIN TRANSACTION
	BEGIN TRY
			DELETE FROM Usuario WHERE IdUsuario = @IdUsuario
			COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
		SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
	END CATCH


--Con el procedure de Agregar
ALTER PROCEDURE [dbo].[UsuarioAdd]
@IdUsuario INT,
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@FechaNacimiento DATE,
@Email VARCHAR(254),
@Password VARCHAR(50),
@Telefono VARCHAR(20),
@Celular VARCHAR(20),
@Curp VARCHAR(50),
@Sexo VARCHAR(2),
@IdRol INT,
@UserName VARCHAR(50)
AS
BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Usuario (UserName,Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
		Email,[Password],Telefono,Celular,Curp,Sexo,IdRol)
		VALUES(@UserName,@Nombre,@ApellidoPaterno,@ApellidoMaterno,@FechaNacimiento,
		@Email,@Password,@Telefono,@Celular,@Curp,@Sexo,@IdRol)

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
		SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
	END CATCH


--Con el procedure de Actualizar
ALTER PROCEDURE [dbo].[UsuarioUpdate]
@IdUsuario INT,
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@FechaNacimiento DATE,
@Email VARCHAR(254),
@Password VARCHAR(50),
@Telefono VARCHAR(20),
@Celular VARCHAR(20),
@Curp VARCHAR(50),
@Sexo VARCHAR(2),
@IdRol INT,
@UserName VARCHAR(50)
AS
BEGIN TRANSACTION
	BEGIN TRY
		UPDATE Usuario 
		SET Nombre=@Nombre, ApellidoPaterno=@ApellidoPaterno, ApellidoMaterno=@ApellidoMaterno, 
		FechaNacimiento=@FechaNacimiento, Email=@Email, [Password]=@Password, Telefono=@Telefono,
		Celular=@Celular, Curp=@Curp,Sexo=@Sexo, IdRol=@IdRol,UserName=@UserName
		WHERE IdUsuario = @IdUsuario

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
		SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
	END CATCH

EmpleadoGetAll

ALTER PROCEDURE [dbo].[UsuarioGetAll]
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50)
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
WHERE Usuario.Nombre LIKE '%'+@Nombre+'%' 
AND Usuario.ApellidoPaterno LIKE '%'+@ApellidoPaterno+'%'