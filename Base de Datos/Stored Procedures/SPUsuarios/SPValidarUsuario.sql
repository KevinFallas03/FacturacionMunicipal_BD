-- SP para verificar usuarios

create procedure [dbo].[spValidarUsuario]
(      
   @Nombre varchar(100),
   @Password varchar(100)
)      
as       
begin      
   Select ID, Nombre, Password, TipoUsuario 
   from [dbo].Usuario where Nombre=@Nombre and Password=@Password and EstaBorrado=0
End
