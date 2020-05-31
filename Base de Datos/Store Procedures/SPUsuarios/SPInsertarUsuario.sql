--SP para insertar Propietarios
use FacturacionMunicipal
go
Create procedure spInsertarPropiedad
(
	@NumFinca int,
	@Valor money,
	@Direccion VARCHAR(150)
)
as
Begin
	Insert into [dbo].Propiedad (NumFinca, Valor, Direccion)
	Values (@NumFinca, @Valor, @Direccion)
End