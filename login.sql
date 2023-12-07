USE IvbetoProgramacionNCapas

ALTER PROCEDURE UsuarioLogin
@Email VARCHAR(50),
@Password VARCHAR(50)
AS
SELECT Usuario.Email, Usuario.Password
FROM Usuario
WHERE Email = @Email AND Password = @Password

UsuarioGeTAll
AseguradoraGetAll

UsuarioLogin 'camilacataleya@gmail.com','oduboduvsm'