--SP para ver una Propiedad
use FacturacionMunicipal
go
Create or Alter procedure spVerPropiedad
(      
   @ID int      
)      
as       
begin      
   Select ID, NumFinca, Valor, Direccion 
   from [dbo].Propiedad where ID=@ID     
End

go