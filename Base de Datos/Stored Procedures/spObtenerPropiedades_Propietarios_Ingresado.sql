USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerPropiedades_Propietarios_Ingresado]  Script Date: 6/6/2020 20:56:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER procedure [dbo].[spObtenerPropiedades_Propietarios_Ingresado]
	@ingresado varchar(100)
as
BEGIN
	SET NOCOUNT ON;

	SELECT Prop_Prop.ID, Propiedad.NumFinca, Propiedad.Valor, Propiedad.Direccion
	FROM Prop_Prop
	INNER JOIN Propiedad ON Prop_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Propietario ON Prop_Prop.IdPropietario=Propietario.ID
	where Propietario.Nombre = @ingresado or Propietario.ValorDocumento = @ingresado and Prop_Prop.EstaBorrado = 0 
	and Propietario.EstaBorrado=0 and Propiedad.EstaBorrado=0
END
GO

exec spObtenerPropiedades_Propietarios_Ingresado @ingresado = '301659662'