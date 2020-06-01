--SP para insertar Propietarios
use FacturacionMunicipal
go  

Create procedure spVerUsuario
(      
   @ID int      
)      
as       
begin      
   Select ID, Nombre, Password, TipoUsuario
   from [dbo].Usuario where ID=@ID     
End

go