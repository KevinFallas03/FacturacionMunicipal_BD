USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerPropiedades_Usuarios]    Script Date: 7/6/2020 01:22:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER   procedure [dbo].[spObtenerPropiedades_Usuarios_PorNombre]
(
	@nombre varchar(100)
)
as
BEGIN
	SELECT Usuario_Prop.ID, Propiedad.NumFinca, Propiedad.Valor, Propiedad.Direccion
	FROM Usuario_Prop
	INNER JOIN Propiedad ON Usuario_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Usuario ON Usuario_Prop.IdUsuario=Usuario.ID
	where Usuario.Nombre = @nombre and Usuario_Prop.EstaBorrado = 0 and Usuario.EstaBorrado = 0 and Propiedad.EstaBorrado=0
END 

exec spObtenerPropiedades_Usuarios_PorNombre @nombre = 'EMadrigal'
