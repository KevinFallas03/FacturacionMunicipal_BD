--SP para insertar Propietarios
use FacturacionMunicipal
go
Create procedure spInsertarPropietario
(
	@Nombre VARCHAR(100),
	@IdTipoDocumento int,
	@ValorDocumento VARCHAR(30)
)
as
Begin
	Insert into [dbo].Propietario (Nombre, IdTipoDocumento, ValorDocumento)
	Values (@Nombre, @IdTipoDocumento, @ValorDocumento)
End