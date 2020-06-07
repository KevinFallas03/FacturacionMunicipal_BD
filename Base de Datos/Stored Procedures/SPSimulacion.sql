
-- ==========================================================================================
-- Autores:		<Kevin Fallas y Johel Mora>
-- Fecha de creacion: <03/06/2020>
-- Fecha de ultima modificacion <>
-- Descripcion:	<SP para hacer la simulacion de actividades de la municipalidad>
-- ==========================================================================================

	--	///		TABLAS VARIABLES	//
--- SCRIPT DE SIMULACION PARA LA TAREA PROGRAMADA

-- precondición, los nodos para la fecha de operación en el XML vienen en orden ascendente.

/****** Object:  StoredProcedure [dbo].[Simulacion]    Script Date: 11/27/2019 10:20:30 PM ******/
USE [FacturacionMunicipal]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[Simulacion]
AS

BEGIN
	SET NOCOUNT ON 

	Declare @Propiedades table
	(
		sec int identity(1,1) primary key,
		NumFinca int,
		Valor money,
		Direccion varchar(150),
		EstaBorrado bit
	)

	Declare @Propietarios table 
	(
	   sec int identity(1,1) primary key, 
	   TipoDocId int, 
	   Nombre varchar(100),
	   ValorDocId varchar(100),
	   EstaBorrado bit
	)

	Declare @PropJuridico table
	(
		sec int identity(1,1) primary key,
		DocIdPersonaJuridica varchar(100),
		NombrePersonaResponsable varchar(100),
		IdTipoDocumento int,
		ValorDocumento varchar(100),
		EstaBorrado bit
	)

	Declare @PropiedadVsPropietario table
	(
		sec int identity(1,1) primary key, 
		IdPropiedad varchar(100),
		IdPropietario varchar(100),
		EstaBorrado bit
	)

	Declare @PropiedadesxCCobro table
	(
		sec int identity(1,1) primary key,
		IdCCobro int,
		IdPropiedad int, 
		FechaInic date,
		FechaFin date
	)

	Declare @Usuarios table
	(
		sec int identity(1,1) primary key,
		Nombre varchar(100),
		Password varchar(100),
		TipoUsuario varchar(100),
		EstaBorrado bit
	)

	Declare @UsuarioVersusPropiedad table
	(
		sec int identity(1,1) primary key,
		IdPropiedad varchar(100),
		IdUsuario varchar(100),
		EstaBorrado bit
	)

	Declare @FechaOperacion date

	-- se extraen fechas operación
	Declare @FechasAProcesar table 
	(
	   sec int identity(1,1) primary key, 
	   fecha date
	)

	-- Variables para leer xml
	DECLARE @DocumentoXML xml 

	BEGIN TRY
		SELECT @DocumentoXML = DXML
			FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\Operaciones.xml', Single_BLOB) AS DocumentoXML(DXML)
		insert @FechasAProcesar (fecha)
		select f.value('@fecha', 'DATE')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia') AS t(f);
	END TRY
	BEGIN CATCH
		SELECT 'Hubo un error de cargar fechas'
	END CATCH
	--parte 3 
	
	--select * from @FechasAProcesar
	-- variables que almacenan valor constante para controlar emision masiva de recibos

	--Declare @IdCCobro_ConsumoAgua=1, @IdCCobro_PatenteCantina=7   -- Son ids con valores solo de ejemplo

	-- Variables para controlar la iteración
	declare @Lo1 int, @Hi1 int, @Lo2 int, @Hi2 int
	declare @minfecha datetime, @maxfecha datetime 

	-- iterando de la fecha más antigua a la menos antigua

	Select @minfecha=min(F.fecha), @maxfecha=max(F.fecha)  -- min y max son funciones agregadas
	from @FechasAProcesar F

	select @Lo1=F.sec
	from @FechasAProcesar F
	where F.Fecha=@minfecha

	select @Hi1=F.sec
	from @FechasAProcesar F
	where F.Fecha=@maxfecha

	--parte4
	-- iteramos por fecha
	while @Lo1<=@Hi1
	Begin
		Select @FechaOperacion=F.Fecha from @FechasAProcesar F where sec=@Lo1
		
		--DECLARE @fechaOperacionNodo date
		--SET @fechaOperacionNodo = @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE')--revisar

		-- procesar nodos propiedades
		delete @Propiedades
		insert @Propiedades (NumFinca, Valor, Direccion, EstaBorrado)
		select pd.value('@NumFinca', 'INT')
		, pd.value('@Valor', 'MONEY')
		, pd.value('@Direccion', 'VARCHAR(150)')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/Propiedad') AS t(pd)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 

		-- iteramos en propiedades
		Select @Lo2=min(sec), @Hi2=max(sec) 
		from @Propiedades
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Propiedad(NumFinca, Valor, Direccion, EstaBorrado)
		   Select Pd.NumFinca, Pd.Valor, Pd.Direccion, Pd.EstaBorrado from @Propiedades Pd where sec=@Lo2
		   Set @Lo2=@Lo2+1
		end
		
		-- procesar nodos propietario
		delete @Propietarios  
		insert @Propietarios (TipoDocId, Nombre, ValorDocId, EstaBorrado)
		select pt.value('@TipoDocIdentidad','INT')
		, pt.value('@Nombre', 'VARCHAR(100)')
		, pt.value('@identificacion', 'VARCHAR(100)')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/Propietario') AS t(pt)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 
		

		-- iteramos en propietarios
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @Propietarios
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Propietario(IdTipoDocumento, Nombre, ValorDocumento, EstaBorrado)
		   Select P.TipoDocId, P.Nombre, P.ValorDocId, P.EstaBorrado from @Propietarios P where sec=@Lo2
		   Set @Lo2=@Lo2+1
		end

		--Propietarios Juridicos 
		-- procesar nodos propietarios juridicos
		delete @PropJuridico 
		insert @PropJuridico(DocIdPersonaJuridica, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento, EstaBorrado)
		select --ID VALUE
		  pd.value('@docidPersonaJuridica', 'VARCHAR(100)')
		, pd.value('@Nombre', 'VARCHAR(100)')
		, pd.value('@DocidRepresentante', 'VARCHAR(100)')
		, pd.value('@TipDocIdRepresentante', 'INT')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PersonaJuridica') AS t(pd)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 

		--Propietarios x Propiedades
		-- procesar nodos PropietarioxPropiedad
		delete @PropiedadVsPropietario
		insert @PropiedadVsPropietario (IdPropiedad, IdPropietario, EstaBorrado)
		select pp.value('@NumFinca', 'VARCHAR(100)')
		, pp.value('@identificacion', 'VARCHAR(100)')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PropiedadVersusPropietario') AS t(pp)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion

		--insertamos Usuarios
		delete @Usuarios
		insert @Usuarios (Nombre, Password, TipoUsuario, EstaBorrado)-- rultimo atributo 
		select u.value('@Nombre','VARCHAR(100)')
		, u.value('@password', 'VARCHAR(100)')
		, 'Normal' AS TipoUsuario
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/Usuario') AS t(u)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion

		-- iteramos en Usuarios
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @Usuarios
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Usuario(Nombre, Password, TipoUsuario ,EstaBorrado)
		   Select U.Nombre, U.Password, U.TipoUsuario, U.EstaBorrado from @Usuarios U where sec=@Lo2
		   Set @Lo2=@Lo2+1
		end

		--CCobros x Propiedad
		--procesar nodos CCobroVsPropiedad
		delete @PropiedadesxCCobro 
		insert @PropiedadesxCCobro (IdCCobro, IdPropiedad, FechaInic)-- revisar ultimo atributo 
		select pc.value('@idcobro','INT') --buscar el id de ese valor
		, pc.value('@NumFinca', 'INT') --buscar el id de ese valor
		, @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[]', 'DATE') as FechaInic --error carga solo la primera fecha
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/ConceptoCobroVersusPropiedad') AS t(pc)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion

		-- Usuarios x Propiedad
		-- insertamos Usuarios x Propiedad
		delete @UsuarioVersusPropiedad
		insert @UsuarioVersusPropiedad (IdPropiedad, IdUsuario, EstaBorrado)
		select pp.value('@NumFinca', 'VARCHAR(100)') --REVISAR, encontrar la ID de ese valor
		, pp.value('@nombreUsuario', 'VARCHAR(100)') --Revisar, ""
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PropiedadVersusPropietario') AS t(pp)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 

		select * from @PropiedadesxCCobro

		
		set @Lo1 = @Lo1 + 1
		
	end
end

exec IniciarSimulacion

   