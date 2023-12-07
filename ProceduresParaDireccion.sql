USE IvbetoProgramacionNCapas

ALTER PROCEDURE PaisGetAll
AS
SELECT IdPais, Nombre 
FROM Pais

PaisGetAll

CREATE PROCEDURE EstadoGetByIdPais
@IdPais INT
AS
SELECT IdEstado, Nombre 
FROM Estado
WHERE IdPais = @IdPais

EstadoGetByIdPais 2

CREATE PROCEDURE MunicipioGetByIdEstado
@IdEstado INT
AS
SELECT IdMunicipio, Nombre
FROM Municipio
WHERE IdEstado = @IdEstado

MunicipioGetByIdEstado 4

CREATE PROCEDURE ColoniaGetByIdMunicipio
@IdMunicipio INT
AS
SELECT IdColonia, Nombre, CodigoPostal
FROM Colonia
WHERE IdMunicipio = @IdMunicipio

ColoniaGetByIdMunicipio 1