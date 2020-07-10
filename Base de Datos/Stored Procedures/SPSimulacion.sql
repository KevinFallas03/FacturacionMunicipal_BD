 
-- ==========================================================================================
-- Autores:		<Kevin Fallas y Johel Mora>
-- Fecha de creacion: <03/06/2020>
-- Fecha de ultima modificacion <7/6/2020>
-- Descripcion:	<SP para hacer la simulacion de actividades de la municipalidad>
-- ==========================================================================================

	--	///		TABLAS VARIABLES	//
--- SCRIPT DE SIMULACION PARA LA TAREA PROGRAMADA

-- precondici�n, los nodos para la fecha de operaci�n en el XML vienen en orden ascendente.

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
		FechaIngreso date,
		EstaBorrado bit
	)

	Declare @UsuarioVersusPropiedad table
	(
		sec int identity(1,1) primary key,
		IdPropiedad varchar(100),
		IdUsuario varchar(100),
		EstaBorrado bit
	)

	--Tabla para almacenar los cambios en un dia

	Declare @PropiedadCambio CambioValorPropiedadType

	--Tabla variable para almacenar los pagos dia por dia
	Declare @PagosHoy PagosHoyType

	--Tabla para los movimientos de consumo de agua
	Declare @MovConsumo MovConsumoType

	--Fecha para las simulaciones
	Declare @FechaOperacion date

	-- se extraen fechas operaci�n
	Declare @FechasAProcesar table 
	(
	   sec int identity(1,1) primary key, 
	   fecha date
	)

	-- Variables para leer xml
	DECLARE @DocumentoXML xml 

	BEGIN TRY
		SELECT @DocumentoXML = DXML
		FROM OPENROWSET (Bulk 'C:\Users\Johel Mora\Desktop\FacturacionMunicipal_BD\Base de Datos\XML\Operaciones.xml', Single_BLOB) AS DocumentoXML(DXML)
		insert @FechasAProcesar (fecha)
		select f.value('@fecha', 'DATE')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia') AS t(f);
	END TRY
	BEGIN CATCH
		PRINT 'Hubo un error de cargar fechas'
		RETURN @@ERROR * -1
	END CATCH

	--parte 3 
	
	-- variables que almacenan valor constante para controlar emision masiva de recibos

	--Declare @IdCCobro_ConsumoAgua=1, @IdCCobro_PatenteCantina=7   -- Son ids con valores solo de ejemplo

	-- Variables para controlar la iteraci�n
	declare @Lo1 int, @Hi1 int, @Lo2 int, @Hi2 int
	declare @minfecha datetime, @maxfecha datetime 
	DECLARE @fechaOperacionNodo date

	-- iterando de la fecha m�s antigua a la menos antigua
	Select @minfecha=min(F.fecha), @maxfecha=max(F.fecha)  -- min y max son funciones agregadas
	from @FechasAProcesar F

	select @Lo1=F.sec
	from @FechasAProcesar F
	where F.Fecha=@minfecha

	select @Hi1=F.sec
	from @FechasAProcesar F
	where F.Fecha=@maxfecha

	--parte4
	--iteramos por fecha
	while @Lo1<=@Hi1
	Begin
		Select @FechaOperacion=F.Fecha 
		from @FechasAProcesar F 
		where sec=@Lo1
		
		--DECLARE @fechaOperacionNodo date
		SET @fechaOperacionNodo = @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE')--revisar

		
		--delete @Propiedades -- ELIMINAR

		--procesar nodos propiedades MASIVO

		INSERT INTO Propiedad (NumFinca, Valor, Direccion, M3Acumulados, M3AcumuladosUltimoRecibo, FechaIngreso, EstaBorrado)
		select pd.value('@NumFinca', 'INT')
		, pd.value('@Valor', 'MONEY')
		, pd.value('@Direccion', 'VARCHAR(150)')
		, 0 AS M3Acumulados
		, 0 AS M3AcumuladosUltimoRecibo
		, pd.value('../@fecha', 'DATE')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/Propiedad') AS t(pd)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 
		

		/*-- iteramos en propiedades
		Select @Lo2=min(sec), @Hi2=max(sec) 
		from @Propiedades
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Propiedad(NumFinca, Valor, Direccion, EstaBorrado)
		   Select Pd.NumFinca, Pd.Valor, Pd.Direccion, Pd.EstaBorrado 
		   from @Propiedades Pd where sec=@Lo2
		   Set @Lo2=@Lo2+1
		end
		*/

		--delete @Propietarios
		-- procesar nodos propietario
		INSERT INTO Propietario (IdTipoDocumento, Nombre, ValorDocumento, FechaIngreso, EstaBorrado)
		select pt.value('@TipoDocIdentidad','INT')
		, pt.value('@Nombre', 'VARCHAR(100)')
		, pt.value('@identificacion', 'VARCHAR(100)')
		, pt.value('../@fecha', 'DATE')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/Propietario') AS t(pt)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 
		

		/*-- iteramos en propietarios
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @Propietarios
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Propietario(IdTipoDocumento, Nombre, ValorDocumento, EstaBorrado)
		   Select P.TipoDocId, P.Nombre, P.ValorDocId, P.EstaBorrado 
		   from @Propietarios P where sec=@Lo2
		   Set @Lo2=@Lo2+1
		end*/

		--Propietarios Juridicos 
		-- procesar nodos propietarios juridicos ITERATIVO -- considerar hacerlos masivos
		delete @PropJuridico 
		insert @PropJuridico(DocIdPersonaJuridica, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento, EstaBorrado)
		select --ID VALUE
		  pd.value('@docidPersonaJuridica', 'VARCHAR(100)')
		, pd.value('@Nombre', 'VARCHAR(100)')
		, pd.value('@TipDocIdRepresentante', 'INT')
		, pd.value('@DocidRepresentante', 'VARCHAR(100)')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PersonaJuridica') AS t(pd)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 

		--iteramos en propietarios juridico
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @PropJuridico
		while @Lo2<=@Hi2
		Begin
		   insert dbo.PropietarioJuridico(ID, NombrePersonaResponsable, IdTipoDocumento, ValorDocumento, EstaBorrado)
		   Select Pt.ID, Pj.NombrePersonaResponsable, Pj.IdTipoDocumento, Pj.ValorDocumento, Pj.EstaBorrado
		   from @PropJuridico Pj, dbo.Propietario Pt
		   where sec=@Lo2 and Pj.DocIdPersonaJuridica = Pt.ValorDocumento
		   Set @Lo2=@Lo2+1
		end

		--Propietarios x Propiedades
		-- procesar nodos PropietarioxPropiedad
		delete @PropiedadVsPropietario
		insert @PropiedadVsPropietario (IdPropiedad, IdPropietario, EstaBorrado)
		select pp.value('@NumFinca', 'VARCHAR(100)')
		, pp.value('@identificacion', 'VARCHAR(100)')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PropiedadVersusPropietario') AS t(pp)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion

		--iteramos en PropiedadVsPropietario
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @PropiedadVsPropietario
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Prop_Prop(IdPropiedad, IdPropietario, EstaBorrado)
		   Select Pd.ID, Pt.ID, Pp.EstaBorrado
		   from @PropiedadVsPropietario Pp, dbo.Propietario Pt, dbo.Propiedad Pd
		   where sec=@Lo2 and Pp.IdPropietario = Pt.ValorDocumento and Pp.IdPropiedad = Pd.NumFinca
		   Set @Lo2=@Lo2+1
		end
	 
		--insertamos Usuarios insert MASIVO
		--delete @Usuarios
		INSERT INTO Usuario (Nombre, Password, TipoUsuario, FechaIngreso, EstaBorrado)-- rultimo atributo 
		select u.value('@Nombre','VARCHAR(100)')
		, u.value('@password', 'VARCHAR(100)')
		, 'Normal' AS TipoUsuario
		, u.value('../@fecha', 'DATE')
		, 0 AS EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/Usuario') AS t(u)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion

		/*-- iteramos en Usuarios
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @Usuarios
		while @Lo2<=@Hi2
		Begin
		   Insert dbo.Usuario(Nombre, Password, TipoUsuario, FechaIngreso, EstaBorrado)
		   Select U.Nombre, U.Password, U.TipoUsuario, U.FechaIngreso, U.EstaBorrado from @Usuarios U 
		   Where sec=@Lo2
		   Set @Lo2=@Lo2+1
		end
		*/

		--CCobros x Propiedad
		--procesar nodos CCobroVsPropiedad
		delete @PropiedadesxCCobro 
		insert @PropiedadesxCCobro (IdCCobro, IdPropiedad, FechaInic)-- revisar ultimo atributo 
		select pc.value('@idcobro','INT') --buscar el id de ese valor
		, pc.value('@NumFinca', 'INT') --buscar el id de ese valor
		, pc.value('../@fecha', 'DATE' ) as FechaInic -- POSIBLE error carga solo la primera fecha
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/ConceptoCobroVersusPropiedad') AS t(pc)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion

		-- iteramos en PropiedadesxCCobro 
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @PropiedadesxCCobro 
		while @Lo2<=@Hi2
		Begin
		   insert dbo.CCobro_PNP(IdCCobbro, IdPropiedad, FechaInic)
		   Select PC.IdCCobro, Pd.ID, PC.FechaInic 
		   from @PropiedadesxCCobro PC, dbo.Propiedad Pd
		   where sec=@Lo2 and PC.IdPropiedad = Pd.NumFinca
		   Set @Lo2=@Lo2+1
		end
		
		--Usuarios Versus Propiedad
		--procesamos nodos UsuarioVersusPropiedad
		delete @UsuarioVersusPropiedad
		insert @UsuarioVersusPropiedad (IdPropiedad, IdUsuario, EstaBorrado)
		select up.value('@NumFinca', 'VARCHAR(100)')
		, up.value('@nombreUsuario', 'VARCHAR(100)')
		, 0 as EstaBorrado
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/UsuarioVersusPropiedad') AS t(up)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion
		
		-- iteramos en @UsuarioVersusPropiedad 
		Select @Lo2=min(sec), @Hi2=max(sec)
		from @UsuarioVersusPropiedad 
		while @Lo2<=@Hi2
		Begin
		   insert dbo.Usuario_Prop(IdPropiedad, IdUsuario, EstaBorrado)
		   Select Pd.ID, U.ID, Up.EstaBorrado
		   from @UsuarioVersusPropiedad Up, dbo.Usuario U, dbo.Propiedad Pd
		   where sec=@Lo2 and Up.IdUsuario = U.Nombre and Up.IdPropiedad = Pd.NumFinca
		   Set @Lo2=@Lo2+1
		end

		-- procesar los cambios en las propiedades por dia
		DELETE @PropiedadCambio
		INSERT @PropiedadCambio (NumFinca, NuevoValor)
		select pc.value('@NumFinca', 'INT')
			, pc.value('@NuevoValor', 'MONEY')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PropiedadCambio') AS t(pc)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion
		EXEC spProcesaCambioValorPropiedad @PropiedadCambio

		--procesa los pagos de un dia
		DELETE @PagosHoy
		INSERT @PagosHoy (NumFinca, TipoRecibo, Fecha)
		select ph.value('@NumFinca', 'INT')
			, ph.value('@idTipoRecibo', 'INT')
			, ph.value('../@fecha', 'DATE')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PagoRecibo') AS t(ph)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion
		--EXEC spProcesaPagos @PagosHoy

		--procesa los movimientos en los consumos de las propiedades
		--DELETE @MovConsumo
		INSERT @MovConsumo(NumFinca, M3, TipoMov, Fecha)
		select mc.value('@NumFinca', 'INT')
			, mc.value('@LecturaM3', 'INT')
			, mc.value('@id', 'INT')
			, mc.value('../@fecha', 'DATE')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/Consumo') AS t(mc)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion
		
		
	
		-- PSEUDOCODIGO PARA PROCESAR PAGOS
		/*
		Extraer en una variable table los pagos del dia, @PagosHoy

		-- en algun lado un 
		declare @PagosHoy table (id int identity Primary Key, NumFinca int, IdTipoRecibo int)

		INSERT @PagosHoy (NumFinca, IdTipoRecibo)
		select ph.value('@NumFinca', 'INT')
			, ph.value('idTipoRecibo', 'INT')
		from @DocumentoXML.nodes('/Operaciones_por_Dia/OperacionDia/PagoRecibo') AS t(ph)
		where @DocumentoXML.value('(/Operaciones_por_Dia/OperacionDia/@fecha)[1]', 'DATE') = @FechaOperacion 
		
		EXEC SP_PROCESACAMBIOVALORPROPIEDAD ... se le envia la tabla con la info

		EXEC SP_PROCESAPAGOS ... (se le envia @PagosHoy) --ES ATOMICO, se usa transact

		EXEC SP_PROCESACONSUMO ... se le envia la tabla con la info

		EXEC SP_ProcesaCortes ... se le envia la tabla con la info

		EXEC SP_ProcesaReconexion ... se le envia la tabla con la info

		EXEC_SP_GeneraRecibos


		*/

		set @Lo1 = @Lo1 + 1
		
	end
	select * from @MovConsumo
end

exec IniciarSimulacion
--exec ReiniciarTablas



   