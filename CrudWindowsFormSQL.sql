CREATE DATABASE IvBetoCRUDWinForm

USE IvBetoCRUDWinForm

CREATE TABLE Vehiculo(
IdVehiculo INT PRIMARY KEY IDENTITY(1,1),
Modelo VARCHAR(50),
Marca VARCHAR(50),
AnioFabricacion INT,
Tipo VARCHAR(40)
)

CREATE PROCEDURE VehiculoAdd
@Modelo VARCHAR(50),
@Marca VARCHAR(50),
@AnioFabricacion INT,
@Tipo VARCHAR(40)
AS
	INSERT INTO Vehiculo VALUES(@Modelo,@Marca,@AnioFabricacion,@Tipo)


CREATE PROCEDURE VehiculoUpdate
@IdVehiculo INT,
@Modelo VARCHAR(50),
@Marca VARCHAR(50),
@AnioFabricacion INT,
@Tipo VARCHAR(40)
AS
	UPDATE Vehiculo SET
	Modelo = @Modelo, Marca = @Marca,
	AnioFabricacion = @AnioFabricacion,
	Tipo = @Tipo
	WHERE IdVehiculo = @IdVehiculo


CREATE PROCEDURE VehiculoDelete
@IdVehiculo INT
AS
	DELETE FROM Vehiculo 
	WHERE IdVehiculo = @IdVehiculo


CREATE PROCEDURE VehiculoGetAll
AS
	SELECT V.IdVehiculo,
		V.Marca,
		V.Modelo,
		V.AnioFabricacion,
		V.Tipo
	FROM Vehiculo V


CREATE PROCEDURE VehiculoGetById
@IdVehiculo INT
AS
	SELECT V.IdVehiculo,
		V.Marca,
		V.Modelo,
		V.AnioFabricacion,
		V.Tipo
	FROM Vehiculo V
	WHERE V.IdVehiculo = @IdVehiculo