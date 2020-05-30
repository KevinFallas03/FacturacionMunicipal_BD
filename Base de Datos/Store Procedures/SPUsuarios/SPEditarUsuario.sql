use FacturacionMunicipal
go

Create procedure spEditarUsuario  
(      
	@id int,
	@Nombre VARCHAR(100),
	@Password VARCHAR(100),
	@TipoUsuario VARCHAR(50)  
)      
as      
begin  
     
   Update [dbo].Usuario
   set Nombre=@Nombre, Password=@Password, TipoUsuario=@TipoUsuario
   where ID=@id      
End

go