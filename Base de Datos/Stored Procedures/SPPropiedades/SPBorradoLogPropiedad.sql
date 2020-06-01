Use FacturacionMunicipal
Go
CREATE PROCEDURE spBorradoLogPropiedad
(
	@ID int
)
AS 
BEGIN 
	UPDATE dbo.Propiedad
	SET EstaBorrado=1
	WHERE ID = @ID
END 