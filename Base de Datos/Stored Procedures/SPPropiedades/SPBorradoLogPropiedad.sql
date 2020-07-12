Use FacturacionMunicipal
Go
CREATE OR ALTER PROCEDURE spBorradoLogPropiedad
(
	@ID int
)
AS 
BEGIN
	If @ID is null
	BEGIN
		return -1
	END 
	UPDATE dbo.Propiedad
	SET EstaBorrado=1
	WHERE ID = @ID
END 