-- SP para verificar usuarios

create or Alter procedure [dbo].[spValidarUsuario]
(      
   @Nombre varchar(100),
   @Password varchar(100)
)      
as       
begin
	If @Nombre is NULL and @Password is NULL
	BEGIN
		Return -1 --ocurrio un error
	END
   Select ID, Nombre, Password, TipoUsuario 
   from [dbo].Usuario where Nombre=@Nombre and Password=@Password and EstaBorrado=0
End
