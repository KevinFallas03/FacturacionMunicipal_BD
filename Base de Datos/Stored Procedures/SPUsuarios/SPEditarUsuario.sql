use FacturacionMunicipal
go

Create or Alter procedure spEditarUsuario
(      
	@id int,
	@Nombre varchar(100),
	@Password varchar(100),
	@TipoUsuario VARCHAR(50)  
)      
as      
begin  
     
   Update [dbo].Usuario
   set Nombre=@Nombre, Password=@Password, TipoUsuario=@TipoUsuario
   where ID=@id      
End

go