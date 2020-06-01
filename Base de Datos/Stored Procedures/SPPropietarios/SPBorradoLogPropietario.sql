Use FacturacionMunicipal
Go
CREATE PROCEDURE spBorradoLogPropietario
@ID int
AS 
BEGIN 
	UPDATE dbo.Propietario
	SET EstaBorrado=1
	WHERE ID = @ID
END 