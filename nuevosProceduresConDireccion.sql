USE IvbetoProgramacionNCapas

ALTER TABLE Usuario
ADD Imagen VARCHAR(MAX)

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
@UserName VARCHAR(50),
@Calle VARCHAR(50),
@NumeroInterior VARCHAR(50),
@NumeroExterior VARCHAR(50),
@IdColonia INT,
@Imagen VARCHAR(MAX), --Cambio 1
@filasAlteradas INT OUTPUT --Cambio 2
AS
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Usuario (UserName,Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
			Email,[Password],Telefono,Celular,Curp,Sexo,IdRol)
			VALUES(@UserName,@Nombre,@ApellidoPaterno,@ApellidoMaterno,@FechaNacimiento,
			@Email,@Password,@Telefono,@Celular,@Curp,@Sexo,@IdRol)
			SET @filasAlteradas = @@ROWCOUNT
			CHECKPOINT

			INSERT INTO Direccion (Calle,NumeroExterior,NumeroInterior,IdColonia,IdUsuario)
			VALUES(@Calle, @NumeroExterior, @NumeroInterior, @IdColonia, @@IDENTITY) --se usa el @@IDENTITY para obtener el ID del usuario
			SET @filasAlteradas = @filasAlteradas + @@ROWCOUNT
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
	END CATCH


--Procedure de eliminar 
ALTER PROCEDURE [dbo].[UsuarioDelete]
@IdUsuario INT,
@filasEliminadas INT OUTPUT --Cambio 1
AS	
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM Direccion 
			WHERE Direccion.IdUsuario = @IdUsuario
			SET @filasEliminadas = @@ROWCOUNT
			CHECKPOINT

			DELETE FROM Usuario 
			WHERE Usuario.IdUsuario = @IdUsuario
			SET @filasEliminadas = @filasEliminadas + @@ROWCOUNT
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
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
@UserName VARCHAR(50),
@Calle VARCHAR(50),
@NumeroInterior VARCHAR(50),
@NumeroExterior VARCHAR(50),
@IdColonia INT,
@Imagen VARCHAR(MAX), --Cambio 1
@filasalteradas INT OUTPUT --Cambio 2
AS
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE Usuario 
			SET Nombre=@Nombre, ApellidoPaterno=@ApellidoPaterno, ApellidoMaterno=@ApellidoMaterno, 
			FechaNacimiento=@FechaNacimiento, Email=@Email, [Password]=@Password, Telefono=@Telefono,
			Celular=@Celular, Curp=@Curp,Sexo=@Sexo, IdRol=@IdRol,UserName=@UserName
			WHERE Usuario.IdUsuario = @IdUsuario
			SET @filasalteradas = @@ROWCOUNT --Para las filas afectadas
			CHECKPOINT

			UPDATE Direccion
			SET Calle=@Calle, NumeroInterior=@NumeroInterior, NumeroExterior=@NumeroExterior,
			IdColonia=@IdColonia 
			WHERE Direccion.IdUsuario = @IdUsuario
			SET @filasalteradas = @filasalteradas + @@ROWCOUNT --Para las filas afectadas
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
	END CATCH


ALTER PROCEDURE [dbo].[UsuarioGetAll]
AS
SELECT Usuario.IdUsuario,
	Usuario.UserName, 
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
------------------------------------------------------------------------------------

ALTER PROCEDURE [dbo].[UsuarioGetById]
@IdUsuario INT
AS
SELECT Usuario.IdUsuario,
	Usuario.UserName, 
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
WHERE Usuario.IdUsuario = @IdUsuario

UPDATE Direccion SET NumeroInterior='No. 16' WHERE IdUsuario = 2
SELECT * FROM Direccion
SELECT * FROM Colonia
SELECT * FROM Usuario

INSERT INTO Direccion (Calle,NumeroInterior,NumeroExterior,IdColonia,IdUsuario)
VALUES('Presidente Mazarik','No.90','Lt.11','4','3')
INSERT INTO Direccion (Calle,NumeroInterior,NumeroExterior,IdColonia,IdUsuario)
VALUES('Huitzilopochitli','No.67','Lt.3','2','4')
INSERT INTO Direccion (Calle,NumeroInterior,NumeroExterior,IdColonia,IdUsuario)
VALUES('Independencia','No.160','Int.6','3','5')
INSERT INTO Direccion (Calle,NumeroInterior,NumeroExterior,IdColonia,IdUsuario)
VALUES('Pacifico','No.223','Int.3','4','7')
INSERT INTO Direccion (Calle,NumeroInterior,NumeroExterior,IdColonia,IdUsuario)
VALUES('Juan Carlos Borda','Mz.22','Lt.2','1','8')
INSERT INTO Direccion (Calle,NumeroInterior,NumeroExterior,IdColonia,IdUsuario)
VALUES('Bökenkamp','No.16','Int.90','12','10')
INSERT INTO Direccion (Calle,NumeroInterior,NumeroExterior,IdColonia,IdUsuario)
VALUES('Wikingstrasse','No.25','Int.34','11','11')


UPDATE Direccion SET IdColonia='13' WHERE IdUsuario = 11
[UsuarioGetById] 11

UsuarioUpdate '11','Diana','Acevedo','Martinez','2000/09/12',
'xdianamoon@gmail.com','pass@word1','56433664539','6567756868','ACMD990912MBARTD09',
'F','2','xlightmoonx','Wikingstrasse','No.25','Int.34','12',null,null
