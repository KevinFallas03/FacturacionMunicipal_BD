USE [FacturacionMunicipal]
GO

--SPs para el CRUD de Propietarios Juridicos

CREATE OR ALTER procedure [dbo].[spInsertarPropietario_Jud]
(
	@id int,
	@Nombre VARCHAR(100),
	@IdTipoDocumento int,
	@ValorDocumento VARCHAR(30)
)
as
Begin
	Insert into [dbo].PropietarioJuridico (ID, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento, EstaBorrado)
	Values (@id, @Nombre, @IdTipoDocumento, @ValorDocumento, 0)
	select ID
	from PropietarioJuridico
End

go

CREATE OR ALTER procedure [dbo].[spEditarPropietario_Jud]  
(      
	@id int,
	@Nombre VARCHAR(100),
	@IdTipoDocumento int,
	@ValorDocumento VARCHAR(30)  
)      
as      
begin  
   Update [dbo].PropietarioJuridico
   set NombrePersonaResponsable=@Nombre, IdTipoDocumento=@IdTipoDocumento, ValorDocumento=@ValorDocumento
   where ID=@id and EstaBorrado = 0   
End

go 

CREATE OR ALTER procedure [dbo].[spVerPropietario_Jud]     
(      
   @ID int      
)      
as       
begin      
   Select ID, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento 
   from [dbo].PropietarioJuridico where ID=@ID  and EstaBorrado = 0
End

go

CREATE or ALTER PROCEDURE [dbo].[spBorradoLogPropietario_Jud]
@ID int
AS 
BEGIN 
	UPDATE dbo.PropietarioJuridico
	SET EstaBorrado=1
	WHERE ID = @ID
END 

go 

EXEC 