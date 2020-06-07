--SP para insertar Propietarios
use FacturacionMunicipal
go
Create or Alter procedure spInsertarPropietario
(
	@Nombre VARCHAR(100),
	@IdTipoDocumento int,
	@ValorDocumento VARCHAR(30)
)
as
Begin
	Insert into [dbo].Propietario (Nombre, IdTipoDocumento, ValorDocumento, EstaBorrado)
	Values (@Nombre, @IdTipoDocumento, @ValorDocumento, 0)
	select ID from Propietario where @Nombre=Nombre and @IdTipoDocumento=IdTipoDocumento and @ValorDocumento=ValorDocumento and 0=EstaBorrado
End