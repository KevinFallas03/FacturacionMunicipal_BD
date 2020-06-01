--SP para eliminar los propietarios de Propiedades

alter PROCEDURE [dbo].[spBorradoLogPropietario_Propiedad]
	@ID int
AS 
BEGIN 
	UPDATE dbo.Prop_Prop
	SET EstaBorrado=1
	WHERE ID = @ID
END 
