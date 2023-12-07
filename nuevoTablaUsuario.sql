USE IvbetoProgramacionNCapas

--Alteramos las columnas para hacer que se puedan borrar, guardando valores nulos
ALTER TABLE Usuario
ALTER COLUMN FechaNacimiento DATE NULL

ALTER TABLE Usuario
ALTER COLUMN Direccion VARCHAR(100) NULL

ALTER TABLE Usuario
ALTER COLUMN Nacionalidad VARCHAR(70) NULL

ALTER TABLE Usuario
ALTER COLUMN EstadoCivil VARCHAR(20) NULL

UsuarioGetAll

--Actualizamos la tabla usuario en su viejo formato y ponemos nulos los valores
--de las columnas a eliminarse

UsuarioUpdate '1','Ivan Alejandro','Beto','Perez','1999-08-16',null,null,null,'1'
UsuarioUpdate '2','Anastasiya','Pereira','Laporte','1999-10-16',null,null,null,'1'
UsuarioUpdate '3','Hector Ehecatl','Ruiz','Terron','1999-07-03',null,null,null,'1'
UsuarioUpdate '4','Christian','Aguillon','Castellanos','1999-05-28',null,null,null,'1'
UsuarioUpdate '5','Veronica Guadalupe','Zamora','Perez','1999-12-14',null,null,null,'1'
UsuarioUpdate '6','Roberto Carlos','Mosqueda','Angulo','1999-10-20',null,null,null,'1'
UsuarioUpdate '7','Josue','Gomez','Gonzalez','1999-01-16',null,null,null,'1'
UsuarioUpdate '8','Cristina','Ramirez','Torres','1998-09-02',null,null,null,'1'

--Borramos las columnas que tienen los valores nulos
ALTER TABLE Usuario DROP COLUMN Direccion
ALTER TABLE Usuario DROP COLUMN Nacionalidad
ALTER TABLE Usuario DROP COLUMN EstadoCivil

--Agregamos a la tabla Usuario las nuevas columnas con valores nulos
ALTER TABLE Usuario
ADD Email VARCHAR(254) NULL

ALTER TABLE Usuario
ADD [Password] VARCHAR(50) NULL

ALTER TABLE Usuario
ADD Telefono VARCHAR(20) NULL

ALTER TABLE Usuario
ADD Celular VARCHAR(20) NULL

ALTER TABLE Usuario
ADD Curp VARCHAR(50) NULL

ALTER TABLE Usuario
ADD Sexo VARCHAR(2) NULL

ALTER TABLE Usuario
ADD UserName VARCHAR(50) NULL

--Modificamos los procedimientos para que al usarlos, puedan guardar los nuevos valores
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
INSERT INTO Usuario (UserName,Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,Email,[Password],Telefono,Celular,Curp,Sexo,IdRol)
VALUES(@UserName,@Nombre,@ApellidoPaterno,@ApellidoMaterno,@FechaNacimiento,@Email,@Password,@Telefono,@Celular,@Curp,@Sexo,@IdRol)
---------------------------------------------------------------------------------------------------------------------------
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
UPDATE Usuario 
SET Nombre=@Nombre, ApellidoPaterno=@ApellidoPaterno, ApellidoMaterno=@ApellidoMaterno, 
FechaNacimiento=@FechaNacimiento, Email=@Email, [Password]=@Password, Telefono=@Telefono,
Celular=@Celular, Curp=@Curp,Sexo=@Sexo, IdRol=@IdRol,UserName=@UserName
WHERE IdUsuario = @IdUsuario

SELECT * FROM Usuario

SELECT * FROM Rol

UsuarioUpdate '1','Ivan Alejandro','Beto','Perez','1999-08-16','betoivan16p@yahoo.com.mx','pass@word1','5625962814','5518281688','BEPI990816HDFTRV08','M','1','ivanBeto16'


UsuarioUpdate '2','Anastasiya','Pereira','Laporte','1999-10-16','anapereira99@hotmail.com','pass@word1','5687568926','5527935807','PELA991016MDFRTS10','F','1','anaPereiraB'
UsuarioUpdate '3','Hector Ehecatl','Ruiz','Terron','2001-07-03','thischarmingHector@gmail.com','pass@word1','5673287301','5563727452','RUTH010703HDFTZR07','M','4','charmingEhecatl'
UsuarioUpdate '4','Christian','Aguillon','Castellanos','1999-05-28','inquisidorxzx@gmail.com','pass@word1','5683128919','5532427492','AGCC990528HDFLNT05','M','2','inquisidorxzx99'
UsuarioUpdate '5','Veronica Guadalupe','Zamora','Perez','1999-12-14','ronizamora14@gmail.com','pass@word1','5673837290','5524564370','ZAPV991214MDFMRN12','F','4','roniZamora14'
UsuarioUpdate '6','Roberto Carlos','Mosqueda','Angulo','1999-10-20','mosquedarobert6@hotmail.com','pass@word1','4785729472','5543662429','MOAR971020HDFSGR10','M','5','robertoCmosqueda'
UsuarioUpdate '7','Josue','Gomez','Gonzalez','1999-01-16','jgomez16gonzalez@yahoo.com.mx','pass@word1','5687463728','5576372935','GOGJ990116HDFMLS01','M','2','josuesG16'
UsuarioUpdate '8','Cristina','Ramirez','Torres','1998-09-02','axlohaoficial@gmail.com','pass@word1','346976737','698536254','RATC981002MDFRRT02','F','3','axlohaOficial'


--Consulta de prueba para verificar el contenido de los datos de las tablas
SELECT IdUsuario,Username, Usuario.Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
Email,[Password],Telefono,Celular,Curp,Sexo,Usuario.IdRol, Rol.Nombre AS NombreRol 
FROM Usuario 
INNER JOIN Rol 
ON Usuario.IdRol = Rol.IdRol

SELECT IdUsuario,UserName, Usuario.Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
Email,[Password],Telefono,Celular,Curp,Sexo,Usuario.IdRol, Rol.Nombre AS NombreRol 
FROM Usuario 
INNER JOIN Rol 
ON Usuario.IdRol = Rol.IdRol
WHERE IdUsuario = 3

ALTER TABLE Usuario
ALTER COLUMN [Password] VARCHAR(254) NOT NULL

ALTER TABLE Usuario
ALTER COLUMN Sexo VARCHAR(2) NOT NULL

ALTER TABLE Usuario
ALTER COLUMN Telefono VARCHAR(20) NOT NULL

ALTER TABLE Usuario 
ALTER COLUMN Email VARCHAR(254) NOT NULL

ALTER TABLE USUARIO
ADD UNIQUE(Email)



--Modificacion de los procedures de las vistas general y especifica

ALTER PROCEDURE [dbo].[UsuarioGetAll]
AS
SELECT IdUsuario,UserName, Usuario.Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
Email,[Password],Telefono,Celular,Curp,Sexo,Usuario.IdRol, Rol.Nombre AS NombreRol 
FROM Usuario 
INNER JOIN Rol 
ON Usuario.IdRol = Rol.IdRol

ALTER PROCEDURE [dbo].[UsuarioGetById]
@IdUsuario INT
AS
SELECT IdUsuario,UserName, Usuario.Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,
Email,[Password],Telefono,Celular,Curp,Sexo,Usuario.IdRol, Rol.Nombre AS NombreRol 
FROM Usuario 
INNER JOIN Rol 
ON Usuario.IdRol = Rol.IdRol
WHERE IdUsuario = @IdUsuario

UsuarioGetAll
UsuarioGetById 5

--Username y Email UNIQUE
ALTER TABLE USUARIO
ADD UNIQUE(Email)

ALTER TABLE Usuario
ADD UNIQUE(UserName)

/*
ALTER TABLE Usuario
DROP CONSTRAINT UQ__Usuario__C9F284564D150852
*/

ALTER TABLE Usuario
ALTER COLUMN UserName VARCHAR(50) NOT NULL

SELECT * FROM Colonia
SELECT * FROM Usuario
