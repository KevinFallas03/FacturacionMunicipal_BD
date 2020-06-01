use FacturacionMunicipal
go

Create procedure spEditarPropiedad
(      
	@id int,
	@NumFinca int,
	@Valor money,
	@Direccion VARCHAR(150)  
)      
as      
begin  
     
   Update [dbo].Propiedad
   set NumFinca=@NumFinca, Valor=@Valor, Direccion=@Direccion
   where ID=@id      
End

go