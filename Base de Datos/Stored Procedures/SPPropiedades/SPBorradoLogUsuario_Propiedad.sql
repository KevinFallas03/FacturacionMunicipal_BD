--SP para eliminar los usuarios de Propiedades
Use FacturacionMunicipal
Go

Create or Alter PROCEDURE [dbo].[spBorradoLogUsuario_Propiedad]
	@ID int
AS 
BEGIN 
	UPDATE dbo.Usuario_Prop
	SET EstaBorrado=1
	WHERE ID = @ID 
END 

Go