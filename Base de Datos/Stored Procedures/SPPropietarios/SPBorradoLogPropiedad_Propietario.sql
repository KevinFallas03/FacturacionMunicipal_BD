--SP para eliminar las propiedades de Propietarios 
USE FacturacionMunicipal
Go


CREATE OR ALTER PROCEDURE [dbo].[spBorradoLogPropiedad_Propietario]
	@ID int
AS 
BEGIN 
	UPDATE dbo.Prop_Prop
	SET EstaBorrado=1
	WHERE ID = @ID
END 