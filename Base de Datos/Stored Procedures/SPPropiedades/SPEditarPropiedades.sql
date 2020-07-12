use FacturacionMunicipal
go

Create or Alter procedure spEditarPropiedad 
(      
	@id int,
	@NumFinca int,
	@Valor money,
	@Direccion VARCHAR(100)
)      
as      
begin  
    If @id is null
	BEGIN
		return -1
	END  
	Update [dbo].Propiedad
	set NumFinca=@NumFinca, Valor=@Valor, Direccion = @Direccion
	where ID=@id      
End

go