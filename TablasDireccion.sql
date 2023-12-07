--Creacion de las tablas
CREATE TABLE Pais(
IdPais INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Estado(
IdEstado INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL,
IdPais INT FOREIGN KEY REFERENCES Pais(IdPais)
);

CREATE TABLE Municipio(
IdMunicipio INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL,
IdEstado INT FOREIGN KEY REFERENCES Estado(IdEstado)
);

CREATE TABLE Colonia(
IdColonia INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL,
IdMunicipio INT FOREIGN KEY REFERENCES Municipio(IdMunicipio)
);

CREATE TABLE Direccion(
IdDireccion INT IDENTITY(1,1) PRIMARY KEY,
Calle VARCHAR(50) NOT NULL,
NumeroInterior VARCHAR(50) NOT NULL,
NumeroExterior VARCHAR(50) NOT NULL,
IdColonia INT FOREIGN KEY REFERENCES Colonia(IdColonia),
IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario)
);

ALTER TABLE Colonia
ADD CodigoPostal VARCHAR(50) NOT NULL

--Insert de Paises
INSERT INTO Pais VALUES('Mexico')
INSERT INTO Pais VALUES('Alemania')

--Insert de Estados
INSERT INTO Estado(Nombre,IdPais) VALUES('Ciudad de Mexico','1')
INSERT INTO Estado(Nombre,IdPais) VALUES('Queretaro','1')
INSERT INTO Estado(Nombre,IdPais) VALUES('Chiapas','1')
INSERT INTO Estado(Nombre,IdPais) VALUES('Hamburg','2')
INSERT INTO Estado(Nombre,IdPais) VALUES('Bremen','2')
INSERT INTO Estado(Nombre,IdPais) VALUES('Brandeburgo','2')

--Insert de Municipios
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Iztapalapa','1')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Coyoacan','1')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Miguel Hidalgo','1')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('San Juan del Rio','2')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Queretaro Capital','2')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Corregidora','2')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Arriaga','3')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Bella Vista','3')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Berriozabal','3')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Hamburg-Nord','4')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Hamburg-Mitte','4')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Bergedorf','4')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Neustadt','5')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Seehausen','5')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Vahr','5')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Havelland','6')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Oberhavel','6')
INSERT INTO Municipio(Nombre,IdEstado)VALUES ('Oder-Spree','6')

--Insert de Colonias
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Fuego Nuevo','09800','1')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Lomas Estrella','09340','1')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Paseos de Taxqueña','07820','2')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('San Francisco Culhuacan','04318','2')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Polanco','11510','3')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('La Peña','76804','4')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Cipreses','76125','5')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Bravo','76925','6')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Arriaga Centro','30450','7')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Guadalupe','30134','8')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Berlin','29133','9')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Dulsberg','8947','10')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Finkenwerder','5738','11')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Tatenberg','6749','12')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Kirchenthumbach','3453','13')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Beusterstraße','3240','14')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Neue Vahr','4483','15')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Mühlenberge','2349','16')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Oberkrämer','25249','17')
INSERT INTO Colonia(Nombre,CodigoPostal,IdMunicipio)VALUES ('Jacobsdorf ','43735','18')


SELECT * FROM Pais
SELECT * FROM Estado
SELECT * FROM Municipio
SELECT * FROM Colonia
SELECT * FROM Direccion
