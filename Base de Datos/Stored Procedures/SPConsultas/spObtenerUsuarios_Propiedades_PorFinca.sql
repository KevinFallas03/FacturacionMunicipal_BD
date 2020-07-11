USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerPropiedades_Usuarios]    Script Date: 7/6/2020 01:22:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER   procedure [dbo].[spObtenerUsuarios_Propiedades_PorFinca]
(
	@finca int
)
as
BEGIN
	SELECT DISTINCT Usuario_Prop.ID, Usuario.Nombre, Usuario.Password, Usuario.TipoUsuario
	FROM Usuario_Prop
	INNER JOIN Propiedad ON Usuario_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Usuario ON Usuario_Prop.IdUsuario=Usuario.ID
	where Propiedad.NumFinca = @finca and Usuario_Prop.EstaBorrado = 0 and Usuario.EstaBorrado=0 and Propiedad.EstaBorrado=0
END 

exec spObtenerUsuarios_Propiedades_PorFinca @finca = '1176180'