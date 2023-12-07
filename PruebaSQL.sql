CREATE DATABASE IvBetoPruebaSQL

USE IvBetoPruebaSQL


--**********************Tablas de Prueba***************************
--****Ejercicio Constraints****
CREATE TABLE Padre(
IdPadre INT PRIMARY KEY,
Nombre VARCHAR(MAX) NOT NULL,
Curp VARCHAR(20) UNIQUE
)

ALTER TABLE Padre
ADD Edad INT

CREATE TABLE Hijo(
IdHijo INT PRIMARY KEY,
Nombre VARCHAR(MAX) NOT NULL,
IdPadre INT FOREIGN KEY REFERENCES Padre(IdPadre) ON DELETE CASCADE,
Curp VARCHAR(20) UNIQUE
)

ALTER TABLE Hijo
ADD Edad INT

--******Ejercicio Stored Procedures*******

ALTER PROCEDURE TablasAdd 
@IdPadre INT,
@Nombre VARCHAR(MAX),
@Curp VARCHAR(20),
@EdadPadre INT,
@IdHijo INT,
@NombreHijo VARCHAR(MAX),
@CurpHijo VARCHAR(20),
@EdadHijo INT
AS
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Padre VALUES (@IdPadre,@Nombre,@Curp,@EdadPadre)
			CHECKPOINT
			INSERT INTO Hijo VALUES(@IdHijo,@NombreHijo,@IdPadre,@CurpHijo,@EdadHijo)
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		PRINT ERROR_MESSAGE()
		PRINT ERROR_NUMBER()
	END CATCH

ALTER PROCEDURE TablasGetAll
AS
	SELECT Padre.IdPadre,
			Padre.Nombre,
			Padre.Curp,
			Padre.Edad,
			Hijo.IdHijo,
			Hijo.Nombre,
			Hijo.Curp,
			Hijo.Edad
	FROM Padre INNER JOIN Hijo
	ON Hijo.IdPadre = Padre.IdPadre

INSERT INTO Padre VALUES('1','Ivan Beto Perez','BEPI990816')
DELETE FROM Padre WHERE IdPadre = 1
DELETE FROM Hijo WHERE IdHijo = 1


TablasAdd '1','Ivan Beto Perez','BEPI990816','36','1','Raymundo Beto Bartlett','BEBR350716','10'
TablasAdd '2','Agustin Beto Villa','BEVA570828','69','2','Eduardo Beto Bravo','BEBE930720','30'
TablasGetAll

--*********Ejercicio Vistas**********

CREATE VIEW PadreVW AS
	SELECT Padre.IdPadre,
			Padre.Nombre,
			Padre.Curp FROM Padre

CREATE VIEW HijoVW AS
	SELECT Hijo.IdHijo,
			Hijo.Nombre,
			Hijo.Curp
	FROM Hijo 


SELECT * FROM PadreVW
SELECT * FROM HijoVW


--***********Ejercicio Tablas Temporales*************

--TABLA TEMPORAL LOCAL
CREATE TABLE #PadreHijo(
IdPadre INT, 
IdHijo INT
)

CREATE TABLE #Table(
IdRegistros INT PRIMARY KEY IDENTITY(1,1),
FechaRegistros DATE
)

--TABLA TEMPORAL GLOBAL
CREATE TABLE ##Tabla(
Columna INT IDENTITY(1,1),
Col VARCHAR(MAX)
)

--TABLA TEMPORAL LOCAL
CREATE TABLE #Relaciones(
Fecha DATE,
Relaciones INT
)

SELECT * FROM #PadreHijo
SELECT * FROM #Relaciones
SELECT * FROM #Table

--**********Ejercicio Funciones y Triggers***********


/*****************Bloque de Funciones******************/
ALTER FUNCTION funcionUno (@Nombre VARCHAR(MAX), @Apellido VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
	BEGIN
		RETURN (Upper(@Nombre)+' '+Upper(@Apellido))
	END


PRINT dbo.FuncionUno ('cristina','ramirez')


CREATE FUNCTION funcionDos(@Valor1 INT, @Valor2 INT)
RETURNS INT
AS
	BEGIN
		DECLARE @suma INT
		SET @suma = (@Valor1+@Valor2)
		RETURN @suma
	END


PRINT dbo.FuncionDos(10,12)


/***************Bloque de triggers********************/

CREATE TRIGGER TR_DisparadorUno
ON Hijo
AFTER INSERT
AS
	DECLARE @ValoresRelaciones INT
	SET @ValoresRelaciones = @ValoresRelaciones + 1
	INSERT INTO #Relaciones Values(CONVERT(DATE,CURRENT_TIMESTAMP),@ValoresRelaciones)


PRINT SYSDATETIME()
PRINT CURRENT_TIMESTAMP
PRINT GETDATE()

SELECT * FROM #Relaciones


CREATE TRIGGER TR_DisparadorDos
ON Padre
AFTER INSERT
AS
	INSERT INTO #Table VALUES(CONVERT(DATE,CURRENT_TIMESTAMP))

SELECT * FROM #Table

--**********Ejercicio Cursores e Indices************

--Cursor simpre para traer los datos de la tabla de padre
DECLARE cursor_prueba INSENSITIVE CURSOR
	FOR SELECT * FROM Padre 
OPEN cursor_prueba
FETCH NEXT FROM cursor_prueba	

DECLARE cursor_hijo INSENSITIVE CURSOR
	FOR SELECT * FROM Hijo
OPEN cursor_hijo
FETCH NEXT FROM cursor_hijo


--No se pueden crear index clustered cuando ya existe uno de PK en la tabla
--Si se quieren crear mas indices sobre una tabla, deben ser nonclustered

CREATE NONCLUSTERED INDEX Ix_Edad_Hijo
ON Hijo(Edad)

CREATE NONCLUSTERED INDEX Ix_Edad_Padre
ON Padre(Edad)


--*********Ejercicio Jobs***********

USE [msdb]
GO

/****** Object:  Job [job_prueba]    Script Date: 17/11/2023 04:37:02 p. m. ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 17/11/2023 04:37:02 p. m. ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'job_prueba', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insertar valores en tabla temporal]    Script Date: 17/11/2023 04:37:02 p. m. ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insertar valores en tabla temporal', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'insert into ##Tabla values(''Insercion por Jobs'')', 
		@database_name=N'IvBetoPruebaSQL', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Programacion', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=2, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20231117, 
		@active_end_date=99991231, 
		@active_start_time=163700, 
		@active_end_time=183059, 
		@schedule_uid=N'fdca79e5-4bfc-47a3-98b6-63729b3d51b8'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

SELECT * FROM ##Tabla


USE [msdb]
GO

/****** Object:  Job [job_prueba2]    Script Date: 17/11/2023 04:51:23 p. m. ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 17/11/2023 04:51:23 p. m. ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'job_prueba2', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Eliminar un rango de datos]    Script Date: 17/11/2023 04:51:23 p. m. ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Eliminar un rango de datos', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'delete from ##tabla where Columna between 10 and 30', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Programación', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=2, 
		@freq_subday_interval=20, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20231117, 
		@active_end_date=99991231, 
		@active_start_time=45500, 
		@active_end_time=171059, 
		@schedule_uid=N'c0da9b21-c914-4fdf-9297-c029a87f4ab1'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/********Ejercicio de Funciones de Agregado********/


SELECT COUNT(*) FROM ##Tabla --No. de columnas de la tabla temporal que usan los jobs
SELECT COUNT(*) FROM Padre
SELECT SUM(Columna) FROM ##Tabla  --Suma de los Id's de las columnas de la tabla temporal
SELECT SUM(IdHijo) FROM Hijo

