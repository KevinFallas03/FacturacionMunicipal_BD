USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spVerUsuario]    Script Date: 9/7/2020 13:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER procedure [dbo].[spVerBitacora]
(      
   @ID int      
)      
as       
begin
	If @ID IS Null
    BEGIN
        Return -1 --ocurrio un error
    END
   Select ID, insertedAt, insertedBy, insertedIn, IdEntityType, EntityId, jsonAntes, jsonDespues
   from [dbo].BitacoraCambios where ID=@ID     
End
 
 GO 

USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerBitacora]    Script Date: 9/7/2020 13:47:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE or ALTER procedure [dbo].[spObtenerBitacora]
as
Begin
	select ID, insertedAt
	from [dbo].BitacoraCambios
	order by insertedAt ASC
End
