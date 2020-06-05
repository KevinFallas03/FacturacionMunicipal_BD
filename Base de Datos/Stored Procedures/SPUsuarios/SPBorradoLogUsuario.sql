Use FacturacionMunicipal
Go
CREATE OR ALTER PROCEDURE spBorradoLogUsuario
(
	@ID int
)
AS 
BEGIN 
	UPDATE dbo.Usuario
	SET EstaBorrado=1
	WHERE ID = @ID
END 