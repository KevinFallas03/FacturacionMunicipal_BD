Use FacturacionMunicipal
Go

Create or Alter procedure spVerPropietario     
(      
   @ID int      
)      
as       
begin
	If @ID is NULL
	BEGIN
		Return -1
	END
   Select ID, Nombre, IdTipoDocumento, ValorDocumento 
   from [dbo].Propietario where ID=@ID  and EstaBorrado = 0
End

go