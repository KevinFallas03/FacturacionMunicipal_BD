Create procedure spVerPropietario     
(      
   @ID int      
)      
as       
begin      
   Select ID, Nombre, IdTipoDocumento, ValorDocumento 
   from [dbo].Propietario where ID=@ID     
End

go