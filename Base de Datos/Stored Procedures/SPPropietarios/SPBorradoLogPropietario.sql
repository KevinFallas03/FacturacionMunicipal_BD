Use FacturacionMunicipal
Go

CREATE OR ALTER PROCEDURE spBorradoLogPropietario
(
	@ID int
)
AS 
BEGIN
	IF @ID is NULL
	BEGIN 
		return -1
	ENd
	UPDATE dbo.Propietario
	SET EstaBorrado=1
	WHERE ID = @ID
END 