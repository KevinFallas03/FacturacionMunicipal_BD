Use FacturacionMunicipal
Go
CREATE PROCEDURE spBorradoLogUsuario
(
	@ID int
)
AS 
BEGIN 
	UPDATE dbo.Usuario
	SET EstaBorrado=1
	WHERE ID = @ID
END 