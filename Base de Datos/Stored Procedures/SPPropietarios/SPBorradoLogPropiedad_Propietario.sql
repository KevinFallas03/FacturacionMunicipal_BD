--SP para eliminar las propiedades de Propietarios 

create PROCEDURE [dbo].[spBorradoLogPropiedad_Propietario]
	@ID int
AS 
BEGIN 
	UPDATE dbo.Prop_Prop
	SET EstaBorrado=1
	FROM Propiedad
	INNER JOIN Prop_Prop ON Prop_Prop.IdPropiedad=Propiedad.ID
	WHERE Propiedad.ID = @ID
END 