Use FacturacionMunicipal
Go

Create or Alter procedure spVerPropietario     
(      
   @ID int      
)      
as       
begin      
   Select ID, Nombre, IdTipoDocumento, ValorDocumento 
   from [dbo].Propietario where ID=@ID  and EstaBorrado = 0
End

go