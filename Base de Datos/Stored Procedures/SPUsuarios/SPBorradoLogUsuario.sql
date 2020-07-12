Use FacturacionMunicipal
Go
CREATE OR ALTER PROCEDURE spBorradoLogUsuario
(
	@ID int
)
AS 
BEGIN
	If @ID is NULL
	BEGIN
		Return -1 --ocurrio un error
	END
	UPDATE dbo.Usuario
	SET EstaBorrado=1
	WHERE ID = @ID
END 