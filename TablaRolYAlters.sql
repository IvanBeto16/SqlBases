CREATE TABLE Rol(
IdRol INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50) NOT NULL
)

ALTER TABLE Usuario ADD IdRol INT

SELECT * FROM ROL

ALTER TABLE USUARIO ADD FOREIGN KEY (IdRol)REFERENCES Rol(IdRol)

INSERT INTO Rol VALUES('Ingeniero')
INSERT INTO Rol VALUES('Medico')
INSERT INTO Rol VALUES('Administrador')
INSERT INTO Rol VALUES('Streamer')
INSERT INTO Rol VALUES('Biologo')
INSERT INTO Rol VALUES('Cientifico')
INSERT INTO Rol VALUES('Actuario')

ALTER PROCEDURE [dbo].[UsuarioAdd]
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@FechaNacimiento DATE,
@Direccion VARCHAR(100),
@Nacionalidad VARCHAR(70),
@EstadoCivil VARCHAR(20),
@IdRol INT
AS
INSERT INTO Usuario (Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,Direccion,Nacionalidad,EstadoCivil,IdRol)
VALUES(@Nombre,@ApellidoPaterno,@ApellidoMaterno,@FechaNacimiento,@Direccion,@Nacionalidad,@EstadoCivil,@IdRol)

ALTER PROCEDURE [dbo].[UsuarioUpdate]
@IdUsuario INT,
@Nombre VARCHAR(50),
@ApellidoPaterno VARCHAR(50),
@ApellidoMaterno VARCHAR(50),
@FechaNacimiento DATE,
@Direccion VARCHAR(100),
@Nacionalidad VARCHAR(70),
@EstadoCivil VARCHAR(20),
@IdRol INT
AS
UPDATE Usuario 
SET Nombre=@Nombre, ApellidoPaterno=@ApellidoPaterno, ApellidoMaterno=@ApellidoMaterno, 
FechaNacimiento=@FechaNacimiento, Direccion=@Direccion, Nacionalidad=@Nacionalidad, EstadoCivil=@EstadoCivil, IdRol=@IdRol 
WHERE IdUsuario = @IdUsuario

ALTER PROCEDURE [dbo].[UsuarioGetAll]
AS
SELECT IdUsuario, Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Direccion, Nacionalidad, EstadoCivil, IdRol 
FROM Usuario


ALTER PROCEDURE [dbo].[UsuarioGetById]
@IdUsuario INT
AS
SELECT IdUsuario, Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Direccion, Nacionalidad, EstadoCivil, IdRol
FROM Usuario
WHERE IdUsuario = @IdUsuario

SELECT * FROM Usuario

UsuarioAdd 'Jorge','Castañeda','Pulido','1987-10-17','Santa Fe','Mexicano','Casado','5'
UsuarioAdd 'Ivan Alejandro','Beto','Perez','1999-08-16','Culhuacan','Mexicano','Soltero','1'
UsuarioAdd 'Anastasiya','Pereira','Laporte','1999-10-16','Culhuacan','Mexicana','Soltera','4'
UsuarioAdd 'Hector Ehecatl','Ruiz','Terron','1999-07-03','Nativitas','Mexicano','Soltero','3'
UsuarioAdd 'Christian','Aguillon','Castellanos','1999-05-28','Naucalpan','Mexicano','Soltero','1'
UsuarioAdd 'Veronica Guadalupe','Zamora','Perez','1999-12-14','Coapa','Mexicana','Soltera','6'
UsuarioAdd 'Acitlalin','Gonzalez','Santiago','1998-01-28','Monterrey','Mexicana','En relacion','2'

UsuarioUpdate '7','Jorge','Castañeda','Pulido','1987-10-17','Santa Fe','Mexicano','Casado','6'
UsuarioGetAll
UsuarioGetById 1


ALTER TABLE Usuario ALTER COLUMN IdRol INT NOT NULL

SELECT * FROM ROL

UPDATE Rol SET Nombre='Administrador' WHERE IdRol=1
UPDATE Rol SET Nombre='Usuario' WHERE IdRol=2
UPDATE Rol SET Nombre='Cliente' WHERE IdRol=3
UPDATE Rol SET Nombre='Invitado' WHERE IdRol=4
UPDATE Rol SET Nombre='Contador' WHERE IdRol=5
--DELETE FROM Rol WHERE IdRol=6

UPDATE Usuario SET IdRol=5 WHERE IdUsuario=6


