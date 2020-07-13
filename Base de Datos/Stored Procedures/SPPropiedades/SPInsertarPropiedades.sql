--SP para insertar Propiedades
use FacturacionMunicipal
go

Create or Alter procedure spInsertarPropiedad
(
	@NumFinca int,
	@Valor money,
	@Direccion VARCHAR(100)
)
as
Begin
	Insert into [dbo].Propiedad (NumFinca, Valor, Direccion,M3Acumulados,M3AcumuladosUltimoRecibo,FechaIngreso, EstaBorrado)
	Values (@NumFinca, @Valor, @Direccion, 0,0,CONVERT (datetime, GETDATE()), 0)
End