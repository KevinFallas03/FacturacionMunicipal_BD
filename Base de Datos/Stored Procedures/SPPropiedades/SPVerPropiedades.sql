--SP para ver una Propiedad
use FacturacionMunicipal
go
Create or Alter procedure spVerPropiedad
(      
   @ID int      
)      
as       
begin
	If @ID is null
	Begin
		return -1
	ENd
	Select ID, NumFinca, Valor, Direccion 
	from [dbo].Propiedad where ID=@ID     
End

go