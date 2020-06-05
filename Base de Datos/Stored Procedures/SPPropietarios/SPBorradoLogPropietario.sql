Use FacturacionMunicipal
Go

CREATE OR ALTER PROCEDURE spBorradoLogPropietario
(
	@ID int
)
AS 
BEGIN 
	UPDATE dbo.Propietario
	SET EstaBorrado=1
	WHERE ID = @ID
END 