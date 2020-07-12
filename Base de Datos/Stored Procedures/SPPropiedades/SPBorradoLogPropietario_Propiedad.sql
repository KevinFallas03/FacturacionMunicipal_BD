--SP para eliminar los propietarios de Propiedades
Use FacturacionMunicipal
Go

CREATE OR ALTER PROCEDURE [dbo].[spBorradoLogPropietario_Propiedad]
	@ID int
AS 
BEGIN
	If @ID is null
	BEGIN
		return -1
	END 
	UPDATE dbo.Prop_Prop
	SET EstaBorrado=1
	WHERE ID = @ID
END 

Go