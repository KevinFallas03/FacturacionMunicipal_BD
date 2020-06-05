Use FacturacionMunicipal
Go
CREATE OR ALTER PROCEDURE spBorradoLogPropiedad
(
	@ID int
)
AS 
BEGIN 
	UPDATE dbo.Propiedad
	SET EstaBorrado=1
	WHERE ID = @ID
END 