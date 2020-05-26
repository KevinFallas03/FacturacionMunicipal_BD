CREATE PROCEDURE [dbo].[ObtenerPropietariosSP]
as
Begin
	select Nombre, IdTipoDocumento, ValorDocumento 
	from [dbo].Propietario
End