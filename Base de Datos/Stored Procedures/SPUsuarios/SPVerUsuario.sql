--SP para insertar Propietarios
use FacturacionMunicipal
go  

Create or Alter procedure spVerUsuario
(      
   @ID int      
)      
as       
begin
	If @ID is NULL
	BEGIN
		Return -1 --ocurrio un error
	END
	Select ID, Nombre, Password, TipoUsuario
	from [dbo].Usuario where ID=@ID     
End

go