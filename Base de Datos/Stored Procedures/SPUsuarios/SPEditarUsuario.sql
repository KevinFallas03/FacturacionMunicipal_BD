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
	If @id is NULL
	begin
		RETURN -1	
	end
	Update [dbo].Usuario
	set Nombre=@Nombre, Password=@Password, TipoUsuario=@TipoUsuario
	where ID=@id      
End

go