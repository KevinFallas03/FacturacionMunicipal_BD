use FacturacionMunicipal
go
Create procedure spObtenerPropietariosJuridicos
as
Begin
	select P.Nombre, P.IdTipoDocumento, P.ValorDocumento, PJ.IdTipoDocumento, PJ.NombrePersonaResponsable, PJ.ValorDocumento
	from [dbo].PropietarioJuridico PJ inner join [dbo].Propietario P on PJ.ID = P.ID


End