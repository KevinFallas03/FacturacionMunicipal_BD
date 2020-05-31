Use FacturacionMunicipal
Go
CREATE PROCEDURE spBorradoLogPropietarios
@ID int
AS 
BEGIN 
	UPDATE dbo.Propietario
	SET EstaBorrado=0
	WHERE ID = @ID
END 