use FacturacionMunicipal
go

Create or Alter procedure spEditarPropietario  
(      
	@id int,
	@Nombre VARCHAR(100),
	@IdTipoDocumento int,
	@ValorDocumento VARCHAR(30)  
)      
as      
begin  
     
   Update [dbo].Propietario
   set Nombre=@Nombre, IdTipoDocumento=@IdTipoDocumento, ValorDocumento=@ValorDocumento
   where ID=@id and EstaBorrado = 0   
End

go