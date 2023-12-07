USE IvbetoProgramacionNCapas

ALTER PROCEDURE EmpleadoGetAll
@IdEmpresa INT,
@NombreEmpleado VARCHAR(50)
AS
IF @NombreEmpleado NOT LIKE '' OR @IdEmpresa != ''
BEGIN
	SELECT Empleado.NumeroEmpleado,
	Empleado.RFC,
	Empleado.Nombre,
	Empleado.ApellidoPaterno,
	Empleado.ApellidoMaterno,
	Empleado.Email,
	Empleado.Telefono,
	Empleado.FechaNacimiento,
	Empleado.NSS,
	Empleado.FechaIngreso,
	Empleado.Foto,
	Empresa.IdEmpresa,
	Empresa.Nombre AS NombreEmpresa,
	Empresa.Telefono AS TelefonoEmpresa FROM Empleado
	INNER JOIN Empresa 
	ON Empleado.IdEmpresa = Empresa.IdEmpresa
	WHERE Empleado.IdEmpresa = @IdEmpresa AND
	Empleado.Nombre LIKE '%'+@NombreEmpleado+'%'
END

ELSE
BEGIN
	SELECT Empleado.NumeroEmpleado,
	Empleado.RFC,
	Empleado.Nombre,
	Empleado.ApellidoPaterno,
	Empleado.ApellidoMaterno,
	Empleado.Email,
	Empleado.Telefono,
	Empleado.FechaNacimiento,
	Empleado.NSS,
	Empleado.FechaIngreso,
	Empleado.Foto,
	Empresa.IdEmpresa,
	Empresa.Nombre AS NombreEmpresa,
	Empresa.Telefono AS TelefonoEmpresa FROM Empleado
	INNER JOIN Empresa 
	ON Empleado.IdEmpresa = Empresa.IdEmpresa
END

EmpleadoGetAll '',''