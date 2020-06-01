Use FacturacionMunicipal
Go
CREATE PROCEDURE spBorradoLogPropietario
(
	@ID int
)
AS 
BEGIN 
	UPDATE dbo.Propietario
	SET EstaBorrado=0
	WHERE ID = @ID
END 